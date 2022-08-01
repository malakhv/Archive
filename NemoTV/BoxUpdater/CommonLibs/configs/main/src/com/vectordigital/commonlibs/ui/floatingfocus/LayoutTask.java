package com.vectordigital.commonlibs.ui.floatingfocus;

import android.graphics.Rect;

/**
* Created by a.karmanov on 27.06.14.
*/
class LayoutTask {
    protected final int childIndex;
    protected final int adapterIndex;
    protected final Rect childPosition;

    public LayoutTask(int childIndex, int adapterIndex, Rect childPosition) {
        this.childIndex = childIndex;
        this.adapterIndex = adapterIndex;
        this.childPosition = childPosition;
    }
}
