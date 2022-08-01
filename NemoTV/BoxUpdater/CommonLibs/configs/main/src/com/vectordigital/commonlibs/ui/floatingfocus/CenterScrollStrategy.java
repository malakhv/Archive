package com.vectordigital.commonlibs.ui.floatingfocus;

import android.graphics.Point;
import android.view.View;

/**
 * Created by nikita on 29.09.14.
 */
public class CenterScrollStrategy extends ScrollStrategy {
    public static final float BOUND_HALF = 0.5f;
    public static final float BOUND_QUATER = 0.25f;
    public static final float BOUND_ONE_THIRD = 1f/3f;
    public static final float BOUND_ZERO = 0f;
    public static final float BOUND_NEVER = -1f;

    private final float boundValueX;
    private final float boundValueY;

    public CenterScrollStrategy(float boundValueX, float boundValueY) {
        this.boundValueX = boundValueX;
        this.boundValueY = boundValueY;
    }

    @Override
    public Point getInitialScroll(FloatingFocusAdapterView<?> parent, int selectedIndex) {
        return null;
    }

    @Override
    public Point onTargetSelectionChanged(FloatingFocusAdapterView<?> parent, View targetSelectedView, int targetIndex) {
        int scrollX = parent.getScrollX();
        int scrollY = parent.getScrollY();

        View firstView = parent.getViewByAdapterIndex(0);
        View lastView = parent.getViewByAdapterIndex(parent.getCount() - 1);

        //Если видны и первый и последний, то вообще не скроллимся
        if(firstView != null && lastView != null){
            return new Point(scrollX, scrollY);
        }

        if(boundValueX > 0){
            int boundWidthX = (int)(parent.getWidth() * boundValueX);
            int lowerBoundX = scrollX + parent.getPaddingLeft() + boundWidthX;
            int upperBoundX = scrollX + parent.getWidth() - parent.getPaddingLeft() - boundWidthX;

            if(targetSelectedView.getLeft() < lowerBoundX){
                scrollX = targetSelectedView.getLeft() - parent.getPaddingLeft() - boundWidthX;
            }

            if(targetSelectedView.getRight() > upperBoundX){
                scrollX = targetSelectedView.getRight() - parent.getWidth() + parent.getPaddingRight() + boundWidthX;
            }

            if(firstView != null){
                //TODO: учесть паддинги списка
                scrollX = Math.max(scrollX, firstView.getLeft());
            }

            if(lastView != null){
                //TODO: учесть паддинги списка
                scrollX = Math.min(scrollX, lastView.getRight() - parent.getWidth());
            }
        }

        if(boundValueY > 0){
            int boundWidthY = (int)(parent.getHeight() * boundValueY);
            int lowerBoundY = scrollY + parent.getPaddingTop() + boundWidthY;
            int upperBoundY = scrollY + parent.getHeight() - parent.getPaddingBottom() - boundWidthY;

            if(targetSelectedView.getTop() < lowerBoundY){
                scrollY = targetSelectedView.getTop() - parent.getPaddingTop() - boundWidthY;
            }

            if(targetSelectedView.getBottom() > upperBoundY){
                scrollY = targetSelectedView.getBottom() - parent.getHeight() + parent.getPaddingBottom() + boundWidthY;
            }

            if(firstView != null){
                //TODO: учесть паддинги списка
                scrollY = Math.max(scrollY, firstView.getTop());
            }

            if(lastView != null){
                //TODO: учесть паддинги списка
                scrollY = Math.min(scrollY, lastView.getBottom() - parent.getHeight());
            }
        }

        return new Point(scrollX, scrollY);

    }

}
