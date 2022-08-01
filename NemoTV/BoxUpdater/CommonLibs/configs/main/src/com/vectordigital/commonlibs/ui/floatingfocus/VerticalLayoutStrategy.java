package com.vectordigital.commonlibs.ui.floatingfocus;

import android.graphics.Rect;
import android.view.Gravity;
import android.view.View;
import android.widget.Adapter;

/**
* Created by a.karmanov on 30.06.14.
*/
class VerticalLayoutStrategy extends LayoutStrategy {
    private int firstVisiblePosition;
    private int separatorSize;
    private int childGravity;


    VerticalLayoutStrategy(int separatorSize, int childGravity) {
        this.separatorSize = separatorSize;
        this.childGravity = childGravity;
    }

    void setSeparatorSize(int separatorSize) {
        this.separatorSize = separatorSize;
    }

    void setChildGravity(int childGravity) {
        this.childGravity = childGravity;
    }

    @Override
    public LayoutTask[] initialLayoutPrepare(FloatingFocusAdapterView<?> parent, int selection, int adapterCount) {
        int gravity = Gravity.CENTER_VERTICAL;
        View child;

        int usedHeight = 0;
        firstVisiblePosition = selection;
        child = parent.makeView(firstVisiblePosition);
        if (child.getLayoutParams() == null) {
            child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
        }
        parent.addViewInLayout(child, FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, child.getLayoutParams());
        measureChild(child, parent);
        usedHeight += child.getMeasuredHeight();

        if (adapterCount == 1) {
            gravity = Gravity.TOP;
        }

        while (usedHeight < parent.getHeight() && parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT < adapterCount) {
            if (firstVisiblePosition > 0) {
                firstVisiblePosition -= 1;
                child = parent.makeView(firstVisiblePosition);
                if (child.getLayoutParams() == null) {
                    child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
                }
                parent.addViewInLayout(child, FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, child.getLayoutParams());
                measureChild(child, parent);
                usedHeight += child.getMeasuredHeight() + separatorSize;
            } else if (gravity != Gravity.TOP) {
                gravity = Gravity.TOP;
            }

            if (firstVisiblePosition + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT < adapterCount) {
                child = parent.makeView(firstVisiblePosition + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
                if (child.getLayoutParams() == null) {
                    child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
                }
                parent.addViewInLayout(child, parent.getChildCount(), child.getLayoutParams());
                measureChild(child, parent);
                usedHeight += child.getMeasuredHeight();
                usedHeight += separatorSize;
            } else if (gravity == Gravity.CENTER_VERTICAL) {
                gravity = Gravity.BOTTOM;
            }
        }

        LayoutTask[] result = new LayoutTask[parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT];
        Rect viewRect = new Rect();
        Rect hitRect = new Rect();


        int start;
        switch (gravity) {
            case Gravity.TOP:
                start = parent.getScrollY() + parent.getPaddingTop();
                for (int i = FloatingFocusAdapterView.SERVICE_VIEWS_COUNT; i < parent.getChildCount(); i++) {
                    View childAt = parent.getChildAt(i);
                    viewRect.set(0, start, parent.getWidth(), start + childAt.getMeasuredHeight());
                    Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
                    result[i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT] = new LayoutTask(i, i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition, new Rect(hitRect));
                    start += separatorSize;
                    start += childAt.getMeasuredHeight();
                }
                break;
            case Gravity.BOTTOM:
                start = parent.getScrollY() + parent.getHeight() - parent.getPaddingBottom();
                for (int i = parent.getChildCount() - 1; i >= FloatingFocusAdapterView.SERVICE_VIEWS_COUNT; i--) {
                    View childAt = parent.getChildAt(i);
                    viewRect.set(0, start - childAt.getMeasuredHeight(), parent.getWidth(), start);
                    Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
                    result[i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT] = new LayoutTask(i, i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition, new Rect(hitRect));

                    start -= separatorSize;
                    start -= childAt.getMeasuredHeight();
                }
                break;
            case Gravity.CENTER_VERTICAL:
                View selectedView = parent.getChildAt(selection - firstVisiblePosition + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
                int top = parent.getScrollY() + parent.getHeight() / 2 - selectedView.getMeasuredHeight() / 2;
                viewRect.set(0, top, parent.getWidth(), top + selectedView.getMeasuredHeight());
                Gravity.apply(childGravity, selectedView.getMeasuredWidth(), selectedView.getMeasuredHeight(), viewRect, hitRect);
                result[selection - firstVisiblePosition] = new LayoutTask(selection - firstVisiblePosition + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, selection, new Rect(hitRect));

                start = result[selection - firstVisiblePosition].childPosition.top - separatorSize;
                for (int i = selection - firstVisiblePosition + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT - 1; i >= FloatingFocusAdapterView.SERVICE_VIEWS_COUNT; i--) {
                    View childAt = parent.getChildAt(i);
                    viewRect.set(0, start - childAt.getMeasuredHeight(), parent.getWidth(), start);
                    Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
                    result[i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT] = new LayoutTask(i, i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition, new Rect(hitRect));

                    start -= separatorSize;
                    start -= childAt.getMeasuredHeight();
                }

                start = result[selection - firstVisiblePosition].childPosition.bottom + separatorSize;
                for (int i = selection - firstVisiblePosition + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + 1; i < parent.getChildCount(); i++) {
                    View childAt = parent.getChildAt(i);
                    viewRect.set(0, start, parent.getWidth(), childAt.getMeasuredHeight() + start);
                    Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
                    result[i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT] = new LayoutTask(i, i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition, new Rect(hitRect));
                    start += separatorSize;
                    start += childAt.getMeasuredHeight();
                }
                break;
        }
        return result;
    }

    @Override
    public LayoutTask[] updateLayout(FloatingFocusAdapterView<?> parent, int targetSelectionIndex, int adapterCount, boolean forceLayout) {
        if (forceLayout) {
            if (parent.getChildCount() + firstVisiblePosition - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT > adapterCount) {
                int removeCount = parent.getChildCount() + firstVisiblePosition - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT - adapterCount;
                parent.removeViewsInLayout(parent.getChildCount() - removeCount, removeCount);
            }
            int firstValidView = -1;
            for (int i = FloatingFocusAdapterView.SERVICE_VIEWS_COUNT; i < parent.getChildCount(); i++) {
                int viewType = parent.getViewTypeAt(i);
                if (viewType != Adapter.IGNORE_ITEM_VIEW_TYPE && viewType == parent.getAdapter().getItemViewType(i + firstVisiblePosition - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT)) {
                    firstValidView = i;
                    break;
                }
            }
            if (firstValidView < 0) {
                parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
            }
            if (firstValidView > FloatingFocusAdapterView.SERVICE_VIEWS_COUNT) {
                parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, firstValidView - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
                firstVisiblePosition += firstValidView - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT;
            }

            int lastValidView = -1;
            for (int i = FloatingFocusAdapterView.SERVICE_VIEWS_COUNT; i < parent.getChildCount(); i++) {
                int viewType = parent.getViewTypeAt(i);
                if (viewType == Adapter.IGNORE_ITEM_VIEW_TYPE || viewType == parent.getAdapter().getItemViewType(i + firstVisiblePosition - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT)) {
                    lastValidView = i - 1;
                }
            }
            if (lastValidView >= 0) {
                parent.removeViewsInLayout(lastValidView + 1, parent.getChildCount() - lastValidView - 1);
            }
        }

        View child = parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
        if (child == null) {
            return initialLayoutPrepare(parent, targetSelectionIndex, adapterCount);
        }

        int addedViewsStart = 0;
        int addedViewsEnd = 0;

        int left = child.getTop() - separatorSize;


        while (left > parent.getScrollY() && firstVisiblePosition > 0) {
            firstVisiblePosition -= 1;
            child = parent.makeView(firstVisiblePosition);
            if (child.getLayoutParams() == null) {
                child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
            }
            parent.addViewInLayout(child, FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, child.getLayoutParams());
            measureChild(child, parent);
            addedViewsStart += 1;
            left -= child.getMeasuredHeight();
            left -= separatorSize;
        }

        int right = parent.getChildAt(parent.getChildCount() - 1).getBottom() + separatorSize;
        while (right < parent.getScrollY() + parent.getHeight() && firstVisiblePosition + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT < adapterCount) {
            child = parent.makeView(firstVisiblePosition + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
            if (child.getLayoutParams() == null) {
                child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
            }
            parent.addViewInLayout(child, parent.getChildCount(), child.getLayoutParams());
            measureChild(child, parent);
            addedViewsEnd += 1;
            right += child.getMeasuredHeight();
            right += separatorSize;
        }

        if (addedViewsStart == 0) {
            int removeViewFromStart = 0;
            while (firstVisiblePosition + removeViewFromStart < targetSelectionIndex &&
                    parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + removeViewFromStart).getBottom() < parent.getScrollY() &&
                    parent.getChildCount() > removeViewFromStart + addedViewsEnd + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT) {
                removeViewFromStart += 1;
            }
            firstVisiblePosition += removeViewFromStart;
            if (removeViewFromStart > 0) {
                parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, removeViewFromStart);
            }
        }

        if (addedViewsEnd == 0) {
            int removeViewFromEnd = 0;
            while (firstVisiblePosition + parent.getChildCount() - 1 - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT - removeViewFromEnd > targetSelectionIndex &&
                    parent.getChildAt(parent.getChildCount() - 1 - removeViewFromEnd).getTop() > parent.getScrollY() + parent.getHeight() &&
                    parent.getChildCount() > removeViewFromEnd + addedViewsStart + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT) {
                removeViewFromEnd += 1;
            }
            if (removeViewFromEnd > 0) {
                parent.removeViewsInLayout(parent.getChildCount() - removeViewFromEnd, removeViewFromEnd);
            }
        }

        LayoutTask[] layoutTasks;
        if (!forceLayout) {
            layoutTasks = new LayoutTask[addedViewsStart + addedViewsEnd];
            Rect viewRect = new Rect();
            Rect hitRect = new Rect();
            int start = parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart).getTop() - separatorSize;
            for (int i = 0; i < addedViewsStart; i++) {
                View childAt = parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart - i - 1);
                viewRect.set(0, start - childAt.getMeasuredHeight(), parent.getWidth(), start);
                Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
                layoutTasks[i] = new LayoutTask(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart - 1 - i, firstVisiblePosition + addedViewsStart - i - 1, new Rect(hitRect));

                start -= separatorSize;
                start -= childAt.getMeasuredHeight();
            }

            start = parent.getChildAt(parent.getChildCount() - addedViewsEnd - 1).getBottom() + separatorSize;
            for (int i = 0; i < addedViewsEnd; i++) {
                View childAt = parent.getChildAt(parent.getChildCount() - addedViewsEnd + i);
                viewRect.set(0, start, parent.getWidth(), start + childAt.getMeasuredHeight());
                Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
                layoutTasks[i + addedViewsStart] = new LayoutTask(parent.getChildCount() - addedViewsEnd + i, parent.getChildCount() - addedViewsEnd + i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition, new Rect(hitRect));

                start += separatorSize;
                start += childAt.getMeasuredHeight();
            }
        } else {
            layoutTasks = new LayoutTask[parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT];
            Rect viewRect = new Rect();
            Rect hitRect = new Rect();

            int start = parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart).getTop();
            for (int i = FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart; i < parent.getChildCount(); i++) {
                if (i < parent.getChildCount() - addedViewsEnd) {
                    parent.verifyViewAt(i, i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition);
                }
                View childAt = parent.getChildAt(i);
                viewRect.set(0, start, parent.getWidth(), start + childAt.getMeasuredHeight());
                Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
                layoutTasks[i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT] = new LayoutTask(i, i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition, new Rect(hitRect));

                start += separatorSize;
                start += childAt.getMeasuredHeight();
            }

            start = parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart).getTop() - separatorSize;
            for (int i = 0; i < addedViewsStart; i++) {
                View childAt = parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart - i - 1);
                viewRect.set(0, start - childAt.getMeasuredHeight(), parent.getWidth(), start);
                Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
                layoutTasks[i] = new LayoutTask(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart - 1 - i, firstVisiblePosition + addedViewsStart - i - 1, new Rect(hitRect));

                start -= separatorSize;
                start -= childAt.getMeasuredHeight();
            }
        }


        return layoutTasks;
    }

    @Override
    public LayoutTask[] fillToIndex(FloatingFocusAdapterView<?> parent, int index, int adapterCount) {
//        log.fine("fillToIndex() index: "+index+", adapterCount: "+adapterCount);
//        log.fine("fillToIndex() parentChilds: "+parent.getChildCount());
        int addedViewsStart = 0;
        int addedViewsEnd = 0;
        while (index < firstVisiblePosition) {
            firstVisiblePosition -= 1;
//            log.fine("fillToIndex() [while #1] = firstVisiblePosition: "+firstVisiblePosition);
            View child = parent.makeView(firstVisiblePosition);
            if (child.getLayoutParams() == null) {
                child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
            }
            parent.addViewInLayout(child, FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, child.getLayoutParams());
            measureChild(child, parent);
            addedViewsStart += 1;
        }
        while (index > firstVisiblePosition + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT - 1) {
//            log.fine("fillToIndex() [while #2] = firstVisiblePosition: "+firstVisiblePosition);
            View child = parent.makeView(firstVisiblePosition + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
            if (child.getLayoutParams() == null) {
                child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
            }
            parent.addViewInLayout(child, parent.getChildCount(), child.getLayoutParams());
            measureChild(child, parent);
            addedViewsEnd += 1;
        }

        LayoutTask[] layoutTasks = new LayoutTask[addedViewsStart + addedViewsEnd];
        Rect viewRect = new Rect();
        Rect hitRect = new Rect();
        int start = parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart).getTop() - separatorSize;
        for (int i = 0; i < addedViewsStart; i++) {
            View childAt = parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart - i - 1);
            viewRect.set(0, start - childAt.getMeasuredHeight(), parent.getWidth(), start);
            Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
            layoutTasks[i] = new LayoutTask(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + addedViewsStart - i - 1, firstVisiblePosition + addedViewsStart - i - 1, new Rect(hitRect));

            start -= separatorSize;
            start -= childAt.getMeasuredHeight();
        }

        start = parent.getChildAt(parent.getChildCount() - addedViewsEnd - 1).getBottom() + separatorSize;
        for (int i = 0; i < addedViewsEnd; i++) {
            View childAt = parent.getChildAt(parent.getChildCount() - addedViewsEnd + i);
            viewRect.set(0, start, parent.getWidth(), start + childAt.getMeasuredHeight());
            Gravity.apply(childGravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), viewRect, hitRect);
            layoutTasks[i + addedViewsStart] = new LayoutTask(parent.getChildCount() - addedViewsEnd + i, parent.getChildCount() - addedViewsEnd + i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition, new Rect(hitRect));

            start += separatorSize;
            start += childAt.getMeasuredHeight();
        }
        return layoutTasks;
    }

    @Override
    public View getViewByAdapterIndex(FloatingFocusAdapterView<?> parent, int index) {
        if (index < firstVisiblePosition) return null;
        return parent.getChildAt(index - firstVisiblePosition + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
    }



    @Override
    public int calculateNextFocus(FloatingFocusAdapterView<?> parent, int currentIndex, int direction, int adapterCount) {
        switch (direction) {
            case LEFT:
            case RIGHT:
                return -1;
            case UP: return currentIndex - 1;
            case DOWN: return currentIndex + 1 < adapterCount? currentIndex + 1:-1;
        }
        return -1;
    }

    @Override
    public int getChildViewType(FloatingFocusAdapterView<?> parent, int index) {
        if (index >= FloatingFocusAdapterView.SERVICE_VIEWS_COUNT) {
            return parent.getAdapter().getItemViewType(index + firstVisiblePosition - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
        }
        return Adapter.IGNORE_ITEM_VIEW_TYPE;
    }

    @Override
    public int getAdapterIndex(int viewIndex) {
        return viewIndex - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstVisiblePosition;
    }

    @Override
    public void offsetSelectionWithoutLayout(FloatingFocusAdapterView<?> parent, int offset) {

        firstVisiblePosition += offset;
        if (firstVisiblePosition < 0) {
            parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, -firstVisiblePosition);
            firstVisiblePosition = 0;
        }

    }

    @Override
    public int getFirstVisiblePosition(FloatingFocusAdapterView<?> parent) {
        return firstVisiblePosition;
    }

    @Override
    public int getVisibleItemsCount(FloatingFocusAdapterView<?> parent) {
        return parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT;
    }
}
