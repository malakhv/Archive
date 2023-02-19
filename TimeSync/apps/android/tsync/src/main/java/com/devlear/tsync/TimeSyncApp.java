/* *
 * Copyright (C) 2022 DevLear - All Rights Reserved.
 *
 * This file is a part of TimeSync project.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.tsync;

import android.app.Application;

import com.malakhv.util.LogCat;

/**
 * The main class for this app.
 * @author Mikhail.Malakhov
 * */
public class TimeSyncApp extends Application {

    /** The log tag for this app. */
    private static final String APP_TAG = "TimeSync";

    /** {@inheritDoc} */
    @Override
    public void onCreate() {
        super.onCreate();
        
        // Initialize logging
        LogCat.init(APP_TAG, BuildConfig.DEBUG);

        // Common app initialization
        appInit();

        // Print debug info after app initialization
        if (LogCat.isDebug()) {
            dumpAll();
        }
    }

    /**
     * All app initialization.
     * */
    private void appInit() {
        // Empty
    }

    /**
     * Prints to log common app data.
     * */
    public void dumpAll() {
        LogCat.printThreads(LogCat.DEBUG);
        LogCat.d(this.getResources().getConfiguration().toString());
    }
}
