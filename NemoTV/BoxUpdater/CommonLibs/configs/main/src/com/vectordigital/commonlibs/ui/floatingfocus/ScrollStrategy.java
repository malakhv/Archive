package com.vectordigital.commonlibs.ui.floatingfocus;

import android.graphics.Point;
import android.view.View;

/**
* Created by a.karmanov on 27.06.14.
*/
public abstract class ScrollStrategy {
    public abstract Point getInitialScroll(FloatingFocusAdapterView<?> parent, int selectedIndex);

    public abstract Point onTargetSelectionChanged(FloatingFocusAdapterView<?> parent, View targetSelectedView, int targetIndex);
}
