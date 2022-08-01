package com.vectordigital.commonlibs.ui.gesture.helpers;

import android.content.Context;
import android.view.GestureDetector;
import android.view.MotionEvent;

/**
 * Because Android GestureDetector stops handling any events after onLongPress,
 * I create 2 detectors.
 * <p/>
 * 12.02.12
 *
 * @author Wild Swift
 */
public class DetectorsElement {
    private GestureDetector detector;
    private GestureDetector longPressDetector;

    public <T extends GestureDetector.OnGestureListener & GestureDetector.OnDoubleTapListener> DetectorsElement(Context context, T listener) {
        this.detector = new GestureDetector(context, new OnGestureListenerWrapper(listener));
        this.detector.setIsLongpressEnabled(false);
        this.longPressDetector = new GestureDetector(context, new LongPressWrapper(listener));
        this.longPressDetector.setIsLongpressEnabled(true);
        this.longPressDetector.setOnDoubleTapListener(listener);
    }

    public boolean onTouchEvent(MotionEvent ev) {
        boolean detectorResult = detector.onTouchEvent(ev);
        boolean longPressDetectorResult = longPressDetector.onTouchEvent(ev);
        return detectorResult || longPressDetectorResult;
    }
}
