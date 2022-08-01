package com.vectordigital.commonlibs.ui.gesture.helpers;

import android.view.GestureDetector;
import android.view.MotionEvent;

/**
 * Wrapper Class for remove Handling all events excepting onLongPress
 * Because Android GestureDetector stops handling any events after onLongPress,
 * I create 2 detectors and need events to be generating single time
 * <p/>
 * 12.02.12
 *
 * @author Wild Swift
 */
public class LongPressWrapper implements GestureDetector.OnGestureListener {
    private GestureDetector.OnGestureListener listener;

    public LongPressWrapper(GestureDetector.OnGestureListener listener) {
        this.listener = listener;
    }

    public boolean onDown(MotionEvent motionEvent) {
        return true;
    }

    public void onShowPress(MotionEvent motionEvent) {
    }

    public boolean onSingleTapUp(MotionEvent motionEvent) {
        return true;
    }

    public boolean onScroll(MotionEvent motionEvent, MotionEvent motionEvent1, float v, float v1) {
        return true;
    }

    public void onLongPress(MotionEvent motionEvent) {
        listener.onLongPress(motionEvent);
    }

    public boolean onFling(MotionEvent motionEvent, MotionEvent motionEvent1, float v, float v1) {
        return true;
    }
}
