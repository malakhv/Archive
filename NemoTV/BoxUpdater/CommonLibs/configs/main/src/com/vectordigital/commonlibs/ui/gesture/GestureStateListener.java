package com.vectordigital.commonlibs.ui.gesture;

import android.view.MotionEvent;

/**
 * 11.02.12
 *
 * @author Wild Swift
 */
public interface GestureStateListener {
    public void onGestureStart(MotionEvent event);

    public void onFingerStart(int index, MotionEvent event);

    public void onFingerEnd(int index, MotionEvent event);

    public void onGestureEnd(MotionEvent event);
}
