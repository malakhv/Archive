package com.vectordigital.commonlibs.ui.floatingfocus;

import android.graphics.Rect;
import android.view.View;

/**
* Created by a.karmanov on 27.06.14.
*/
public abstract class FocusStrategy {
    public abstract void initMove(View currentFocusedView, View targetFocusedView, int currentIndex, int targetIndex);

    public abstract void updateFocusState(FloatingFocusAdapterView<?> parent, View focusView, double time);

    public abstract void applyFocus(View currentFocusedView, View focusView, Rect calculatedFocusedViewPosition);
}
