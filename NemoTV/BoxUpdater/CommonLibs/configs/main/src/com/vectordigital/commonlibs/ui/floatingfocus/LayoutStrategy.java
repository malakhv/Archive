package com.vectordigital.commonlibs.ui.floatingfocus;

import android.view.View;
import android.view.ViewGroup;

/**
* Created by a.karmanov on 27.06.14.
*/
abstract class LayoutStrategy {
    public static final int UP = 0;
    public static final int DOWN = 1;
    public static final int LEFT = 2;
    public static final int RIGHT = 3;


    public abstract LayoutTask[] initialLayoutPrepare(FloatingFocusAdapterView<?> parent, int selection, int adapterCount);

    public abstract LayoutTask[] updateLayout(FloatingFocusAdapterView<?> parent, int targetSelectionIndex, int adapterCount, boolean forceLayout);

    public abstract LayoutTask[] fillToIndex(FloatingFocusAdapterView<?> parent, int index, int adapterCount);

    public abstract View getViewByAdapterIndex(FloatingFocusAdapterView<?> parent, int index);

    public abstract int calculateNextFocus(FloatingFocusAdapterView<?> parent, int currentIndex, int direction, int adapterCount);

    public abstract int getChildViewType(FloatingFocusAdapterView<?> parent, int index);

    public abstract int getAdapterIndex(int viewIndex);

    public abstract void offsetSelectionWithoutLayout(FloatingFocusAdapterView<?> parent, int offset);

    public abstract int getFirstVisiblePosition(FloatingFocusAdapterView<?> parent);

    public abstract int getVisibleItemsCount(FloatingFocusAdapterView<?> parent);

    protected void measureChild(View view, FloatingFocusAdapterView<?> parent) {
        ViewGroup.LayoutParams layoutParams;

        layoutParams = view.getLayoutParams();
        if (layoutParams == null)
            layoutParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);

        int widthMeasureSpec = 0;
        int heightMeasureSpec = 0;
        if (layoutParams.width == ViewGroup.LayoutParams.MATCH_PARENT) {
            widthMeasureSpec = View.MeasureSpec.makeMeasureSpec(parent.getWidth(), View.MeasureSpec.EXACTLY);
        }
        if (layoutParams.width >= 0) {
            widthMeasureSpec = View.MeasureSpec.makeMeasureSpec(layoutParams.width, View.MeasureSpec.EXACTLY);
        }
        if (layoutParams.width == ViewGroup.LayoutParams.WRAP_CONTENT) {
            widthMeasureSpec = View.MeasureSpec.makeMeasureSpec(parent.getWidth(), View.MeasureSpec.UNSPECIFIED);
        }
        if (layoutParams.height == ViewGroup.LayoutParams.MATCH_PARENT) {
            heightMeasureSpec = View.MeasureSpec.makeMeasureSpec(parent.getHeight(), View.MeasureSpec.EXACTLY);
        }
        if (layoutParams.height >= 0) {
            heightMeasureSpec = View.MeasureSpec.makeMeasureSpec(layoutParams.height, View.MeasureSpec.EXACTLY);
        }
        if (layoutParams.height == ViewGroup.LayoutParams.WRAP_CONTENT) {
            heightMeasureSpec = View.MeasureSpec.makeMeasureSpec(parent.getHeight(), View.MeasureSpec.AT_MOST);
        }
        view.measure(widthMeasureSpec, heightMeasureSpec);
    }
}
