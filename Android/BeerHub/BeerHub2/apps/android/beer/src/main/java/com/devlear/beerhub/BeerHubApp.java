/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub project.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub;

import android.app.Application;
import android.content.Context;

import com.devlear.beerhub.app.AppCompList;
import com.devlear.beerhub.billing.Billing;
import com.devlear.beerhub.data.BeerHubDB;
import com.devlear.beerhub.data.DBCursorFactory;
import com.devlear.beerhub.content.AppContent;
import com.devlear.beerhub.test.DeviceTest;
import com.devlear.beerhub.test.TestCases;
import com.malakhv.util.Device;
import com.malakhv.util.LogCat;

/**
 * The main class for this app.
 * @author Mikhail.Malakhov
 * */
public class BeerHubApp extends Application {

    /** The log tag for this app. */
    private static final String APP_TAG = "BeerHub";

    /** The app components. */
    private final AppCompList mAppComponents = new AppCompList();

    /** The BeerHub database. */
    private BeerHubDB mBeerHubDB = null;

    /** The application instance. */
    private static BeerHubApp sInstance = null;

    /** {@inheritDoc} */
    @Override
    public void onCreate() {
        super.onCreate();
        sInstance = this;

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
        final Context context = this.getApplicationContext();

        // We want to initialize content only on supported devices
        if (isSupportDevice()) {
            AppContent.init(context, context.getResources().getInteger(
                    R.integer.content_version));
            Billing.restorePurchases(context);
        } else {
            AppContent.removeContent(context);
            return;
        }

        // We can initialize database on any devices because, by default, this database does not
        // contain any real BeerHub data
        mBeerHubDB = new BeerHubDB(context, new DBCursorFactory());
        mAppComponents.register(mBeerHubDB);
        mBeerHubDB.initHelpers();
    }

    /**
     * @return True, if we can work on this device (device has GMS or any other restrictions).
     * */
    private boolean isSupportDevice() {
        final DeviceTest test = TestCases.deviceTest;
        return test.isEnabled() ? test.isSupportedDevice()
                : (BuildConfig.DEBUG
                    || (Billing.isGooglePlayServicesAvailable(this)
                        && Device.isRealDevice()));
    }

    /**
     * @return The BeerHub database instance.
     * */
    public BeerHubDB getDataBase() {
        return mBeerHubDB;
    }

    /**
     * @return The current instance of this app.
     * */
    public static BeerHubApp getInstance() {
        return sInstance;
    }

    public void dumpAll() {
        LogCat.printThreads(LogCat.DEBUG);
        LogCat.d(this.getResources().getConfiguration().toString());
        mAppComponents.dump();
    }
}
