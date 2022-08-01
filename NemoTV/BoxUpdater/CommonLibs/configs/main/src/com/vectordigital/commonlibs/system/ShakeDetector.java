package com.vectordigital.commonlibs.system;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Wild Swift
 * Android Libraries
 *
 * @author Wild Swift
 */
public class ShakeDetector implements SensorEventListener {
    private static final int FORCE_THRESHOLD = 700;
    private static final int TIME_THRESHOLD = 100;
    private static final int SHAKE_TIMEOUT = 500;
    private static final int SHAKE_DURATION = 1000;
    private static final int SHAKE_COUNT = 3;

    private SensorManager sensorManager;
    private float lastX = -1.0f, lastY = -1.0f, lastZ = -1.0f;
    private long lastTime;
    private OnShakeListener shakeListener;
    private Context context;
    private int shakeCount = 0;
    private long lastShake;
    private long lastForce;
    private final Logger log = Logger.getLogger(ShakeDetector.class.getName());

    public void onAccuracyChanged(Sensor sensor, int i) {
    }

    public interface OnShakeListener {
        public void onShake();
    }

    public ShakeDetector(Context context) {
        this.context = context;
        resume();
    }

    public void setOnShakeListener(OnShakeListener listener) {
        shakeListener = listener;
    }

    public void resume() {
        sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
        if (sensorManager == null) {
            throw new UnsupportedOperationException("Sensors not supported");
        }
        boolean supported = sensorManager.registerListener(this, sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), SensorManager.SENSOR_DELAY_FASTEST);
        if (!supported) {
            sensorManager.unregisterListener(this, sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER));
            log.warning("Accelerometer not supported");
        }
    }

    public void pause() {
        if (sensorManager != null) {
            sensorManager.unregisterListener(this, sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER));
            sensorManager = null;
        }
    }

    public void onSensorChanged(SensorEvent sensorEvent) {
        boolean loggable = log.isLoggable(Level.CONFIG);

        int sensor = sensorEvent.sensor.getType();
        float[] values = sensorEvent.values;
        if (sensor != Sensor.TYPE_ACCELEROMETER) return;
        long now = System.currentTimeMillis();

        if ((now - lastForce) > SHAKE_TIMEOUT) {
            shakeCount = 0;
        }

        if ((now - lastTime) > TIME_THRESHOLD) {
            long diff = now - lastTime;
            if (loggable) {
                log.config("values[SensorManager.DATA_X] = " + values[0]);
                log.config("values[SensorManager.DATA_Y] = " + values[1]);
                log.config("values[SensorManager.DATA_Z] = " + values[2]);
            }

            float speed = (Math.abs(values[0] - lastX) + Math.abs(values[1] - lastY) + Math.abs(values[2] - lastZ)) / diff * 10000;
            if (speed > FORCE_THRESHOLD) {
                if (loggable) {
                    log.config("speed = " + speed);
                }
                if ((++shakeCount >= SHAKE_COUNT) && (now - lastShake > SHAKE_DURATION)) {
                    lastShake = now;
                    shakeCount = 0;
                    if (shakeListener != null) {
                        shakeListener.onShake();
                    }
                }
                lastForce = now;
            }
            lastTime = now;

            lastX = values[0];
            lastY = values[1];
            lastZ = values[2];
        }
    }

}
