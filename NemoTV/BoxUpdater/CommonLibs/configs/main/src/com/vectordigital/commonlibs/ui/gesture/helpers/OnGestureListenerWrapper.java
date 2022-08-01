package com.vectordigital.commonlibs.ui.gesture.helpers;

import android.view.GestureDetector;
import android.view.MotionEvent;

/**
 * Wrapper Class for remove implementation GestureDetector.OnDoubleTapListener in gesture detector
 * <p/>
 * 12.02.12
 *
 * @author Wild Swift
 */
public class OnGestureListenerWrapper implements GestureDetector.OnGestureListener {
    private GestureDetector.OnGestureListener listener;

    public OnGestureListenerWrapper(GestureDetector.OnGestureListener listener) {
        this.listener = listener;
    }

    public boolean onDown(MotionEvent event) {
        return listener.onDown(event);
    }

    public boolean onFling(MotionEvent event, MotionEvent event1, float v, float v1) {
        return listener.onFling(event, event1, v, v1);
    }

    public void onLongPress(MotionEvent event) {
        listener.onLongPress(event);
    }

    public boolean onScroll(MotionEvent event, MotionEvent event1, float v, float v1) {
        return listener.onScroll(event, event1, v, v1);
    }

    public void onShowPress(MotionEvent event) {
        listener.onShowPress(event);
    }

    public boolean onSingleTapUp(MotionEvent event) {
        return listener.onSingleTapUp(event);
    }
}
