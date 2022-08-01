package com.vectordigital.commonlibs.ui.floatingfocus;

import android.graphics.Point;
import android.view.View;

/**
 * Created by a.karmanov on 11.07.14.
 */
public class HorizontalPageScrollStrategy extends ScrollStrategy {
    int pageSize = 7;
    @Override
    public Point getInitialScroll(FloatingFocusAdapterView<?> parent, int selectedIndex) {

        return new Point(selectedIndex / pageSize * parent.getWidth(), 0);
    }

    @Override
    public Point onTargetSelectionChanged(FloatingFocusAdapterView<?> parent, View targetSelectedView, int targetIndex) {
        return new Point(targetIndex / pageSize * parent.getWidth(), 0);
    }
}
