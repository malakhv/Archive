package com.vectordigital.commonlibs.application;

import android.app.Application;
import android.content.ComponentName;

/**
 * Created by a.karmanov on 02.10.13.
 */
public class BaseApplication extends Application {

    private String appName;
    private int logConfig;
    private boolean debug;

    protected BaseApplication(String appName, int logConfig, boolean debug) {

        this.appName = appName;
        this.logConfig = logConfig;
        this.debug = debug;
    }

    private boolean instrumentsRunning = false;

    public boolean isInstrumentsRunning() {
        return instrumentsRunning;
    }

    public void setInstrumentsRunning(boolean instrumentsRunning) {
        this.instrumentsRunning = instrumentsRunning;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        ApplicationUtils.setupLogging(this, appName, logConfig);
        if (debug) {
            ApplicationUtils.updateDebugInfo();
        }
        if (!instrumentsRunning && debug) {
            startInstrumentation(new ComponentName(getPackageName(), DebugInstrumentation.class.getCanonicalName()), null, null);
        }
    }
}
