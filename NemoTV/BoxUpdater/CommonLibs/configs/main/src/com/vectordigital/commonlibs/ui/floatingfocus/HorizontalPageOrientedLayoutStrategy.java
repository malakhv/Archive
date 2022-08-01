package com.vectordigital.commonlibs.ui.floatingfocus;

import android.graphics.Rect;
import android.view.View;
import android.widget.Adapter;

/**
 * Created by a.karmanov on 11.07.14.
 */
public class HorizontalPageOrientedLayoutStrategy extends LayoutStrategy {
    private int pageSize = 7;
    private int space = 5;
    private int firstItemIndex;


    @Override
    public LayoutTask[] initialLayoutPrepare(FloatingFocusAdapterView<?> parent, int selection, int adapterCount) {
        int startPage = parent.getScrollX() / parent.getWidth() + ((parent.getScrollX() % parent.getWidth()) == 0?0:1);
        int pageNum = selection / pageSize;
        int posterWidth = (parent.getWidth() - parent.getPaddingLeft() - parent.getPaddingRight() - (pageSize - 1) * space) / pageSize;
        int leftPageOffset = (parent.getWidth() - (posterWidth * pageSize + (pageSize - 1) * space)) / 2;
        int posterHeight = parent.getHeight() - parent.getPaddingTop() - parent.getPaddingBottom();
        firstItemIndex = Math.min(Math.max(startPage * pageSize, 0), adapterCount);
        int lastItemIndex = Math.min(Math.max(pageNum * pageSize + pageSize - 1, 0), adapterCount - 1);
        if (lastItemIndex < firstItemIndex) return new LayoutTask[0];
        LayoutTask[] layoutTasks = new LayoutTask[lastItemIndex - firstItemIndex + 1];
        for (int i = startPage; i <= pageNum; i++) {
            for (int j = 0; j < pageSize; j++) {
                int index = i * pageSize + j;
                if (index < 0 || index > adapterCount)
                    continue;
                View view = parent.makeView(index);
                view.measure(View.MeasureSpec.makeMeasureSpec(posterWidth, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(posterHeight, View.MeasureSpec.EXACTLY));
                parent.addViewInLayout(view, parent.getChildCount(), view.getLayoutParams() != null?view.getLayoutParams():FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
                layoutTasks[index - firstItemIndex] = new LayoutTask(parent.getChildCount() - 1, index, new Rect(leftPageOffset + (i * parent.getWidth()) + j * (posterWidth + space), parent.getPaddingTop(), leftPageOffset + (i * parent.getWidth()) + j * (posterWidth + space) + posterWidth, parent.getHeight() - parent.getPaddingBottom()));
            }
        }
        return layoutTasks;
    }

    @Override
    public LayoutTask[] updateLayout(FloatingFocusAdapterView<?> parent, int targetSelectionIndex, int adapterCount, boolean forceLayout) {
        if (forceLayout) {
            if (parent.getChildCount() + firstItemIndex - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT > adapterCount) {
                int removeCount = parent.getChildCount() + firstItemIndex - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT - adapterCount;
                parent.removeViewsInLayout(parent.getChildCount() - removeCount, removeCount);
            }
            int firstValidView = -1;
            for (int i = FloatingFocusAdapterView.SERVICE_VIEWS_COUNT; i < parent.getChildCount(); i++) {
                int viewType = parent.getViewTypeAt(i);
                if (viewType != Adapter.IGNORE_ITEM_VIEW_TYPE && viewType == parent.getAdapter().getItemViewType(i + firstItemIndex - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT)) {
                    firstValidView = i;
                    break;
                }
            }
            if (firstValidView < 0) {
                parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
            }
            if (firstValidView > FloatingFocusAdapterView.SERVICE_VIEWS_COUNT) {
                parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, firstValidView - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
                firstItemIndex += firstValidView - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT;
            }

            int lastValidView = -1;
            for (int i = FloatingFocusAdapterView.SERVICE_VIEWS_COUNT; i < parent.getChildCount(); i++) {
                int viewType = parent.getViewTypeAt(i);
                if (viewType == Adapter.IGNORE_ITEM_VIEW_TYPE || viewType == parent.getAdapter().getItemViewType(i + firstItemIndex - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT)) {
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

        int posterWidth = (parent.getWidth() - parent.getPaddingLeft() - parent.getPaddingRight() - (pageSize - 1) * space) / pageSize;
        int leftPageOffset = (parent.getWidth() - (posterWidth * pageSize + (pageSize - 1) * space)) / 2;
        int posterHeight = parent.getHeight() - parent.getPaddingTop() - parent.getPaddingBottom();

        int visiblePage = parent.getScrollX() / parent.getWidth();
        boolean nextPageVisible = parent.getScrollX() % parent.getWidth() > 0;
        int targetPage = targetSelectionIndex / pageSize;

        int firstVisiblePage;
        int lastVisiblePage;

        if (targetPage == visiblePage) {
            if (nextPageVisible) {
                firstVisiblePage = visiblePage;
                lastVisiblePage = visiblePage + 1;
            } else {
                firstVisiblePage = visiblePage;
                lastVisiblePage = visiblePage;
            }
        } else if (targetPage == visiblePage + 1 && nextPageVisible) {
            firstVisiblePage = visiblePage;
            lastVisiblePage = visiblePage + 1;
        } else if (targetPage > visiblePage) {
            firstVisiblePage = visiblePage;
            lastVisiblePage = targetPage;
        } else {
            if (nextPageVisible) {
                firstVisiblePage = targetPage;
                lastVisiblePage = visiblePage + 1;
            } else {
                firstVisiblePage = targetPage;
                lastVisiblePage = visiblePage;
            }
        }

        int addedViewsStart = 0;
        int addedViewsEnd = 0;

        while (firstVisiblePage * pageSize < firstItemIndex) {
            firstItemIndex -= 1;
            child = parent.makeView(firstItemIndex);
            if (child.getLayoutParams() == null) {
                child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
            }
            parent.addViewInLayout(child, FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, child.getLayoutParams());
            child.measure(View.MeasureSpec.makeMeasureSpec(posterWidth, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(posterHeight, View.MeasureSpec.EXACTLY));
            addedViewsStart += 1;
        }

        while (((lastVisiblePage + 1) * pageSize > firstItemIndex + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT) && (firstItemIndex + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT < adapterCount)) {
            child = parent.makeView(firstItemIndex + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
            if (child.getLayoutParams() == null) {
                child.setLayoutParams(FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
            }
            parent.addViewInLayout(child, parent.getChildCount(), child.getLayoutParams());
            child.measure(View.MeasureSpec.makeMeasureSpec(posterWidth, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(posterHeight, View.MeasureSpec.EXACTLY));
            addedViewsEnd += 1;
        }

        if (addedViewsStart == 0) {
            int removeViewFromStart = firstVisiblePage * pageSize - firstItemIndex;
            firstItemIndex += removeViewFromStart;
            if (removeViewFromStart > 0) {
                parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, removeViewFromStart);
            }
        }

        if (addedViewsEnd == 0) {
            int removeViewFromEnd = (lastVisiblePage + 1) * pageSize - 1 - (firstItemIndex + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT - 1);
            if (removeViewFromEnd > 0) {
                parent.removeViewsInLayout(parent.getChildCount() - removeViewFromEnd, removeViewFromEnd);
            }
        }

        LayoutTask[] layoutTasks = new LayoutTask[forceLayout?parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT:addedViewsStart+addedViewsEnd];

        for (int i = FloatingFocusAdapterView.SERVICE_VIEWS_COUNT; i < parent.getChildCount(); i++) {
            int adapterIndex = i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstItemIndex;
            if (i < parent.getChildCount() - addedViewsEnd && i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT >= addedViewsStart) {
                if (forceLayout) {
                    parent.verifyViewAt(i, adapterIndex);
                } else {
                    continue;
                }
            }
            int left = adapterIndex / pageSize * parent.getWidth() + (adapterIndex % pageSize) * (posterWidth + space) + leftPageOffset;
            if (i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT < addedViewsStart || forceLayout) {
                layoutTasks[i - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT] = new LayoutTask(i, adapterIndex, new Rect(left, parent.getPaddingTop(), left + posterWidth, parent.getHeight() - parent.getPaddingBottom()));
            } else if (i >= parent.getChildCount() - addedViewsEnd) {
                layoutTasks[addedViewsStart + i - (parent.getChildCount() - addedViewsEnd)] = new LayoutTask(i, adapterIndex, new Rect(left, parent.getPaddingTop(), left + posterWidth, parent.getHeight() - parent.getPaddingBottom()));
            }
        }

        return layoutTasks;
    }

    @Override
    public LayoutTask[] fillToIndex(FloatingFocusAdapterView<?> parent, int tIndex, int adapterCount) {
        int firstCurrentPage = firstItemIndex / pageSize;
        int lastCurrentPage = (firstItemIndex + parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT - 1) / pageSize;
        int targetPage = tIndex / pageSize;
        int posterWidth = (parent.getWidth() - parent.getPaddingLeft() - parent.getPaddingRight() - (pageSize - 1) * space) / pageSize;
        int leftPageOffset = (parent.getWidth() - (posterWidth * pageSize + (pageSize - 1) * space)) / 2;
        int posterHeight = parent.getHeight() - parent.getPaddingTop() - parent.getPaddingBottom();

        if (targetPage < firstCurrentPage) {
            LayoutTask[] layoutTasks = new LayoutTask[(firstCurrentPage - targetPage) * pageSize];
            firstItemIndex = targetPage * pageSize;
            for (int i = targetPage; i < firstCurrentPage ; i++) {
                for (int j = 0; j < pageSize; j++) {
                    int index = i * pageSize + j;
                    if (index < 0 || index > adapterCount)
                        continue;
                    View view = parent.makeView(index);
                    view.measure(View.MeasureSpec.makeMeasureSpec(posterWidth, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(posterHeight, View.MeasureSpec.EXACTLY));
                    parent.addViewInLayout(view, FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + index - firstItemIndex, view.getLayoutParams() != null?view.getLayoutParams():FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
                    layoutTasks[index - firstItemIndex] = new LayoutTask(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + index - firstItemIndex, index, new Rect(leftPageOffset + (i * parent.getWidth()) + j * (posterWidth + space), parent.getPaddingTop(), leftPageOffset  + (i * parent.getWidth()) + j * (posterWidth + space) + posterWidth, parent.getHeight() - parent.getPaddingBottom()));
                }
            }
            return layoutTasks;
        }
        if (targetPage > lastCurrentPage) {
            LayoutTask[] layoutTasks = new LayoutTask[(targetPage - lastCurrentPage) * pageSize];
            for (int i = lastCurrentPage + 1; i < targetPage + 1 ; i++) {
                for (int j = 0; j < pageSize; j++) {
                    int index = i * pageSize + j;
                    if (index < 0 || index > adapterCount)
                        continue;
                    View view = parent.makeView(index);
                    view.measure(View.MeasureSpec.makeMeasureSpec(posterWidth, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(posterHeight, View.MeasureSpec.EXACTLY));
                    parent.addViewInLayout(view, FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + index - firstItemIndex, view.getLayoutParams() != null?view.getLayoutParams():FloatingFocusAdapterView.DEFAULT_LAYOUT_PARAMS);
                    layoutTasks[(i - lastCurrentPage - 1) * pageSize + j] = new LayoutTask(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + index - firstItemIndex, index, new Rect(leftPageOffset + (i * parent.getWidth()) + j * (posterWidth + space), parent.getPaddingTop(), leftPageOffset + (i * parent.getWidth()) + j * (posterWidth + space) + posterWidth, parent.getHeight() - parent.getPaddingBottom()));
                }
            }
            return layoutTasks;
        }
        return new LayoutTask[0];
    }

    @Override
    public View getViewByAdapterIndex(FloatingFocusAdapterView<?> parent, int index) {
        if (index < firstItemIndex) return null;
        return parent.getChildAt(index - firstItemIndex + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
    }

    @Override
    public int calculateNextFocus(FloatingFocusAdapterView<?> parent, int currentIndex, int direction, int adapterCount) {
        switch (direction) {
            case UP:
            case DOWN:
                return -1;
            case LEFT: return currentIndex - 1;
            case RIGHT: return currentIndex + 1 < adapterCount? currentIndex + 1:-1;
        }
        return -1;
    }

    @Override
    public int getChildViewType(FloatingFocusAdapterView<?> parent, int index) {
        if (index >= FloatingFocusAdapterView.SERVICE_VIEWS_COUNT) {
            return parent.getAdapter().getItemViewType(index + firstItemIndex - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
        }
        return Adapter.IGNORE_ITEM_VIEW_TYPE;
    }

    @Override
    public int getAdapterIndex(int viewIndex) {
        return viewIndex - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + firstItemIndex;
    }

    @Override
    public void offsetSelectionWithoutLayout(FloatingFocusAdapterView<?> parent, int offset) {
        firstItemIndex += offset;
        if (firstItemIndex < 0) {
            parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, -firstItemIndex);
            firstItemIndex = 0;
        }

    }

    @Override
    public int getFirstVisiblePosition(FloatingFocusAdapterView<?> parent) {
        return firstItemIndex;
    }

    @Override
    public int getVisibleItemsCount(FloatingFocusAdapterView<?> parent) {
        return parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT;
    }
}
