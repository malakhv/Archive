package com.vectordigital.commonlibs.ui.floatingfocus;

import android.annotation.TargetApi;
import android.graphics.Rect;
import android.os.Build;
import android.view.View;

/**
* Created by a.karmanov on 30.06.14.
*/
@TargetApi(Build.VERSION_CODES.HONEYCOMB)
public class SimpleFocusStrategy extends FocusStrategy {
    private int initialLeft;
    private int initialRight;
    private int initialTop;
    private int initialBottom;

    private int targetLeft;
    private int targetRight;
    private int targetTop;
    private int targetBottom;

    private int currentLeft;
    private int currentRight;
    private int currentTop;
    private int currentBottom;

    @Override
    public void initMove(View currentFocusedView, View targetFocusedView, int currentIndex, int targetIndex) {
        if (currentFocusedView != null) {
            initialLeft = currentFocusedView.getLeft();
            initialTop = currentFocusedView.getTop();
            initialRight = currentFocusedView.getRight();
            initialBottom = currentFocusedView.getBottom();
        } else {
            initialLeft = currentLeft;
            initialRight = currentRight;
            initialTop = currentTop;
            initialBottom = currentBottom;
        }
        targetLeft = targetFocusedView.getLeft();
        targetRight = targetFocusedView.getRight();
        targetTop = targetFocusedView.getTop();
        targetBottom = targetFocusedView.getBottom();
    }

    @Override
    public void updateFocusState(FloatingFocusAdapterView<?> parent, View focusView, double time) {
        currentLeft = (int) ((targetLeft - initialLeft) * time) + initialLeft;
        currentRight = (int) ((targetRight - initialRight) * time) + initialRight;
        currentTop = (int) ((targetTop - initialTop) * time) + initialTop;
        currentBottom = (int) ((targetBottom - initialBottom) * time) + initialBottom;

        focusView.setLeft(currentLeft);
        focusView.setRight(currentRight);
        focusView.setTop(currentTop);
        focusView.setBottom(currentBottom);

    }

    @Override
    public void applyFocus(View currentFocusedView, View focusView, Rect calculatedFocusedViewPosition) {
        currentFocusedView.layout(calculatedFocusedViewPosition.left, calculatedFocusedViewPosition.top, calculatedFocusedViewPosition.right, calculatedFocusedViewPosition.bottom);
        focusView.layout(calculatedFocusedViewPosition.left, calculatedFocusedViewPosition.top, calculatedFocusedViewPosition.right, calculatedFocusedViewPosition.bottom);
//        focusView.setScaleX(1);
//        focusView.setScaleY(1);
        initialLeft = currentLeft = calculatedFocusedViewPosition.left;
        initialRight = currentRight = calculatedFocusedViewPosition.right;
        initialTop = currentTop = calculatedFocusedViewPosition.top;
        initialBottom = currentBottom = calculatedFocusedViewPosition.bottom;
    }
}
