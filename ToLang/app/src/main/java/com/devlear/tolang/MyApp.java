package com.devlear.tolang;

import android.app.Application;
import com.malakhv.util.LogCat;

/**
 * The application class.
 * @author Mikhail.Malakhov
 * */
public class MyApp extends Application {

    /** The main log tag of this app. */
    private static final String APP_TAG = "toLang";

    /** {@inheritDoc} */
    @Override
    public void onCreate() {
        super.onCreate();
        LogCat.init(APP_TAG, BuildConfig.DEBUG);
    }
}