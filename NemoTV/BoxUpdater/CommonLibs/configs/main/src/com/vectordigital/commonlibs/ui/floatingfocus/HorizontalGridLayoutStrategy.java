package com.vectordigital.commonlibs.ui.floatingfocus;

/**
 * Created by nikita on 07.10.14.
 */


import android.graphics.Rect;
import android.view.View;
import android.widget.Adapter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;

/**
 * Created by a.karmanov on 30.06.14.
 */
public class HorizontalGridLayoutStrategy extends LayoutStrategy {
    /*


        TODO: WARNING GOVNOKOD IS HERE


     */
    private static final Logger log = Logger.getLogger(HorizontalGridLayoutStrategy.class.getName());

//    private int currentPage = 0;
    private final int colsCount;
    private final int rowsCount;
    private final int itemsOnPage;

    private int colWidth = -1;
    private int rowHeight = -1;

    private int lastVisibleIndex = -1;
    private int firstVisibleIndex = 0;

    public HorizontalGridLayoutStrategy(int colsCount, int rowsCount) {
        this.colsCount = colsCount;
        this.rowsCount = rowsCount;
        this.itemsOnPage = colsCount * rowsCount;
    }

    private int getParentInnerWidth(FloatingFocusAdapterView<?> parent){
        return parent.getWidth() - parent.getPaddingLeft() - parent.getPaddingRight();
    }

    private int getParentInnerHeight(FloatingFocusAdapterView<?> parent){
        return  parent.getHeight() - parent.getPaddingTop() - parent.getPaddingBottom();
    }

    public void setColWidth(int colWidth) {
        this.colWidth = colWidth;
    }

    public void setRowHeight(int rowHeight) {
        this.rowHeight = rowHeight;
    }

    private interface ValidViewStrategy {
        boolean isValid(FloatingFocusAdapterView<?> parent, Rect viewRect, int adapterIndex);
    }

    private class ParentBoundsViewValidStrategy implements ValidViewStrategy{
        private final int leftBound;
        private final int rightBound;

        private ParentBoundsViewValidStrategy(int leftBound, int rightBound) {
            this.leftBound = leftBound;
            this.rightBound = rightBound;
        }

        @Override
        public boolean isValid(FloatingFocusAdapterView<?> parent, Rect viewRect, int adapterIndex) {
            return isInBounds(viewRect, leftBound, rightBound);
        }
    }

    @Override
    public LayoutTask[] initialLayoutPrepare(FloatingFocusAdapterView<?> parent, int selection, int adapterCount) {
        log.info("initialLayoutPrepare() parent: "+parent+", selection: "+selection+", adapterCount: "+adapterCount);

        int page = selection / itemsOnPage;
        firstVisibleIndex = page * itemsOnPage;
        lastVisibleIndex = page * itemsOnPage - 1;

        int leftBound = parent.getScrollX() + parent.getPaddingLeft();
        int rightBound = parent.getScrollX() + parent.getWidth() - parent.getPaddingRight();

        return fillToEnd(parent, firstVisibleIndex, adapterCount, new ParentBoundsViewValidStrategy(leftBound, rightBound));
    }

    @Override
    public LayoutTask[] updateLayout(FloatingFocusAdapterView<?> parent, int targetSelectionIndex, int adapterCount, boolean forceLayout) {
//        log.info("updateLayout() parent.getChildCount(): "+parent.getChildCount()+", targetSelectionIndex: "+targetSelectionIndex+
//                ", adapterCount: "+adapterCount+", forceLayout: "+forceLayout+", scrollX: "+parent.getScrollX());
        if(forceLayout){

        }

        int targetPage = targetSelectionIndex / itemsOnPage;

        final int leftBound = Math.min(
                parent.getScrollX() + parent.getPaddingLeft(),
                targetPage * parent.getWidth());
        final int rightBound = Math.max(
                parent.getScrollX() + parent.getWidth() - parent.getPaddingRight(),
                (targetPage + 1) * parent.getWidth());

//        log.info("updateLayout() removing items in bounds: left: "+leftBound+", right: "+rightBound);
        // Search invisible views
        int removeFromBeginCount = 0;
        while(!isInBounds(parent.getChildAt(removeFromBeginCount + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT), leftBound, rightBound)){
            removeFromBeginCount += 1;
        }

//        log.info("updateLayout() removeFromBeginCount: "+removeFromBeginCount);
        parent.removeViewsInLayout(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, removeFromBeginCount);
        firstVisibleIndex += removeFromBeginCount;

        int firstRemoveIndex = 0;
        while (firstRemoveIndex + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT < parent.getChildCount() &&
                isInBounds(parent.getChildAt(firstRemoveIndex + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT), leftBound, rightBound)){
            firstRemoveIndex += 1;
        }

//        log.info("updateLayout() firstRemoveIndex: "+firstRemoveIndex+", parent.getChildCount(): "+parent.getChildCount());
        if(firstRemoveIndex +  FloatingFocusAdapterView.SERVICE_VIEWS_COUNT < parent.getChildCount()) {
            int removeCount = parent.getChildCount() - firstRemoveIndex - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT;
            lastVisibleIndex -= removeCount;
            parent.removeViewsInLayout(firstRemoveIndex + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, removeCount);

        }

//        log.info("updateLayout() parent.getChildCount(): "+parent.getChildCount()+", firstVisibleIndex: "+firstVisibleIndex+", lastVisibleIndex: "+lastVisibleIndex);

        LayoutTask[] fillToEndTasks = fillToEnd(parent, lastVisibleIndex + 1, adapterCount, new ParentBoundsViewValidStrategy(leftBound, rightBound));
        LayoutTask[] fillToStartTasks = fillToStart(parent, firstVisibleIndex - 1, new ParentBoundsViewValidStrategy(leftBound, rightBound));

        LayoutTask[] result = Arrays.copyOf(fillToEndTasks, fillToEndTasks.length + fillToStartTasks.length);
        System.arraycopy(fillToStartTasks, 0, result, fillToEndTasks.length, fillToStartTasks.length);


        return result;
    }

    private boolean isInBounds(View view, int startBound, int endBound){
          return view.getRight() >= startBound && view.getLeft() < endBound;
    }

    private boolean isInBounds(Rect rect, int startBound, int endBound){
        return rect.right >= startBound && rect.left< endBound;
    }

    private LayoutTask[] fillToEnd(FloatingFocusAdapterView<?> parent, int initialIndex, int adapterCount, ValidViewStrategy validViewStrategy){
//        log.info("fill to end() initialIndex: "+initialIndex+", parent: "+parent.getChildCount());
        List<LayoutTask> layoutTasks = new LinkedList<LayoutTask>();
        for (int adapterIndex = initialIndex; adapterIndex < adapterCount; adapterIndex++) {
            Rect viewRect = viewRect(parent, adapterIndex);

            if(!validViewStrategy.isValid(parent, viewRect, adapterIndex)){
                break;
            }
            lastVisibleIndex += 1;
            View child = parent.makeView(adapterIndex);
            int viewIndex = parent.getChildCount();
            child.measure(View.MeasureSpec.makeMeasureSpec(viewRect.width(), View.MeasureSpec.EXACTLY),
                    View.MeasureSpec.makeMeasureSpec(viewRect.height(), View.MeasureSpec.EXACTLY));
            parent.addViewInLayout(child, parent.getChildCount(), child.getLayoutParams());

            layoutTasks.add(new LayoutTask(viewIndex, adapterIndex, viewRect));
        }
//        log.info("fill to end done: initialIndex: "+initialIndex+", parent: "+parent.getChildCount()+", lastVisibleIndex: "+lastVisibleIndex);
        return layoutTasks.toArray(new LayoutTask[layoutTasks.size()]);
    }

    private LayoutTask[] fillToStart(FloatingFocusAdapterView<?> parent, int initialIndex, ValidViewStrategy validViewStrategy){
//        log.info("fill to start() initialIndex: "+initialIndex+", parent: "+parent.getChildCount());
        List<LayoutTask> layoutTasks = new LinkedList<LayoutTask>();
        for (int adapterIndex = initialIndex; adapterIndex >= 0; adapterIndex--) {
            Rect viewRect = viewRect(parent, adapterIndex);

            if(!validViewStrategy.isValid(parent, viewRect, adapterIndex)){
                break;
            }
            firstVisibleIndex -= 1;

            View child = parent.makeView(adapterIndex);
            child.measure(View.MeasureSpec.makeMeasureSpec(viewRect.width(), View.MeasureSpec.EXACTLY),
                    View.MeasureSpec.makeMeasureSpec(viewRect.height(), View.MeasureSpec.EXACTLY));
            parent.addViewInLayout(child, FloatingFocusAdapterView.SERVICE_VIEWS_COUNT, child.getLayoutParams());

            layoutTasks.add(new LayoutTask(-1, adapterIndex, viewRect));
        }

        LayoutTask[] res = layoutTasks.toArray(new LayoutTask[layoutTasks.size()]);
        for (int i = 0; i < res.length; i++) {
            LayoutTask layoutTask = res[i];
            res[i] = new LayoutTask(res.length - i - 1 + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT,
                    layoutTask.adapterIndex,
                    layoutTask.childPosition
            );
        }
//        log.info("fill to start() initialIndex: "+initialIndex+", parent: "+parent.getChildCount()+", firstVisibleIndex: "+firstVisibleIndex);
        return res;
    }

    private Rect viewRect(FloatingFocusAdapterView<?> parent, int itemIndex){
        int page = itemIndex / itemsOnPage;
        int colIndex = itemIndex / rowsCount  - page * colsCount;
        int rowIndex = itemIndex % rowsCount;

        int itemWidth = colWidth < 0 ? getParentInnerWidth(parent) / colsCount : colWidth;
        int itemHeight = rowHeight < 0 ? getParentInnerHeight(parent) / rowsCount : rowHeight;

        int cellWidth = getParentInnerWidth(parent) / colsCount;
        int cellHeight = getParentInnerHeight(parent) / rowsCount;

        int cellCenterX = page * parent.getWidth() + parent.getPaddingLeft() + (int)(cellWidth * (colIndex + 0.5f));
        int cellCenterY = (int)(cellHeight * (rowIndex + 0.5f)) + parent.getPaddingTop();

        int left = cellCenterX - itemWidth / 2;
        int top = cellCenterY - itemHeight / 2;
        return new Rect(left, top, itemWidth + left, top + itemHeight);
    }

    @Override
    public LayoutTask[] fillToIndex(FloatingFocusAdapterView<?> parent, final int index, int adapterCount) {
//        log.info("fillToIndex() parent.getChildCount(): "+parent.getChildCount()+", index: "+index+", adapterCount: "+adapterCount);
//        int firstItemIndex = viewIndex(parent, parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT));
//        int lastItemIndex = viewIndex(parent, parent.getChildAt(parent.getChildCount() - 1));

        if(index > lastVisibleIndex){
            return fillToEnd(parent, lastVisibleIndex + 1, adapterCount, new ValidViewStrategy() {
                @Override
                public boolean isValid(FloatingFocusAdapterView<?> parent, Rect viewRect, int adapterIndex) {
                    return adapterIndex <= index;
                }
            });
        }

        if(index < firstVisibleIndex){
            return fillToStart(parent, firstVisibleIndex - 1, new ValidViewStrategy() {
                @Override
                public boolean isValid(FloatingFocusAdapterView<?> parent, Rect viewRect, int adapterIndex) {
                    return adapterIndex >= index;
                }
            });
        }

        return new LayoutTask[0];
    }

    @Override
    public View getViewByAdapterIndex(FloatingFocusAdapterView<?> parent, int index) {
        return parent.getChildAt(FloatingFocusAdapterView.SERVICE_VIEWS_COUNT + index - firstVisibleIndex);
    }


    private int adapterFocusConstraint(int index, int adapterCount){
        return (index >= 0 && index < adapterCount) ? index : -1;
    }

    @Override
    public int calculateNextFocus(FloatingFocusAdapterView<?> parent, int currentIndex, int direction, int adapterCount) {
        switch (direction) {
            case UP:
                if( (currentIndex - 1) % rowsCount != currentIndex % rowsCount - 1){
                    return -1;
                }
                return adapterFocusConstraint(currentIndex - 1, adapterCount);
            case DOWN:
                if( (currentIndex + 1) % rowsCount != currentIndex % rowsCount + 1){
                    return -1;
                }

                return adapterFocusConstraint(currentIndex +1, adapterCount);
            case LEFT:
                return adapterFocusConstraint(currentIndex - rowsCount, adapterCount);
            case RIGHT:
                return adapterFocusConstraint(currentIndex + rowsCount, adapterCount);
        }
        return -1;
    }

    @Override
    public int getChildViewType(FloatingFocusAdapterView<?> parent, int index) {
        if (index >= FloatingFocusAdapterView.SERVICE_VIEWS_COUNT) {

            return parent.getAdapter().getItemViewType(index - firstVisibleIndex + FloatingFocusAdapterView.SERVICE_VIEWS_COUNT);
        }
        return Adapter.IGNORE_ITEM_VIEW_TYPE;
    }

    @Override
    public int getAdapterIndex(int viewIndex) {
        return viewIndex + firstVisibleIndex;
    }

    @Override
    public void offsetSelectionWithoutLayout(FloatingFocusAdapterView<?> parent, int offset) {
        log.info("offsetSelectionWithoutLayout() offset: "+offset);
        //TODO: implement

    }

    @Override
    public int getFirstVisiblePosition(FloatingFocusAdapterView<?> parent) {
        return firstVisibleIndex;
    }

    @Override
    public int getVisibleItemsCount(FloatingFocusAdapterView<?> parent) {
        return parent.getChildCount() - FloatingFocusAdapterView.SERVICE_VIEWS_COUNT;
    }
}
