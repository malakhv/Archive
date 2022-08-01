package com.vectordigital.commonlibs.ui.floatingfocus;

import android.graphics.Point;
import android.view.View;

/**
* Created by a.karmanov on 30.06.14.
*/
public class SimpleScrollStrategy extends ScrollStrategy {
    @Override
    public Point getInitialScroll(FloatingFocusAdapterView<?> parent, int selectedIndex) {
        return null;
    }

    @Override
    public Point onTargetSelectionChanged(FloatingFocusAdapterView<?> parent, View targetSelectedView, int targetIndex) {
        int scrollX = parent.getScrollX();
        int scrollY = parent.getScrollY();
//        View firstView = parent.getViewByAdapterIndex(0);
//        View lastView = parent.getViewByAdapterIndex(parent.getCount() - 1);
//
//        //Если видны и первый и последний, то вообще не скроллимся
//        if(firstView != null && lastView != null){
//            return new Point(scrollX, scrollY);
//        }
//
        if (scrollX + parent.getPaddingLeft() > targetSelectedView.getLeft()) {
            scrollX = targetSelectedView.getLeft() - parent.getPaddingLeft();
        } else if (scrollX + parent.getWidth() - parent.getPaddingRight() < targetSelectedView.getRight()) {
            scrollX = targetSelectedView.getRight() - parent.getWidth() + parent.getPaddingRight();
        }
        if (scrollY + parent.getPaddingTop() > targetSelectedView.getTop()) {
            scrollY = targetSelectedView.getTop() - parent.getPaddingTop();
        } else if (scrollY + parent.getHeight() - parent.getPaddingBottom() < targetSelectedView.getBottom()) {
            scrollY = targetSelectedView.getBottom() - parent.getHeight() + parent.getPaddingBottom();
        }
        return new Point(scrollX, scrollY);
    }
}
