package xds.xdevlib.app;

/**
 * Copyright (C) 2013 xDevStudio
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * */

import android.app.Application;
import android.content.Context;
import android.content.pm.PackageManager;

/**
 * The base class of the application.
 *
 * @author Mikhail Malakhov, 2015
 */
@SuppressWarnings("unused")
public class App extends Application {

    /** The tag for LogCat. */
    private static final String LOG_TAG = App.class.getSimpleName();

    /** The main app tag for LogCat. */
    private static final String APP_LOG_TAG = App.class.getSimpleName();

    /** The bad version code. */
    public static final int BAD_VERSION_CODE = -1;

    /** The bad version code. */
    public static final String BAD_VERSION_NAME = "no_version";

    /** The error message if current app instance is null. */
    public static final String ERR_APP_INSTANCE_IS_NULL = "Link to Application instance is null";

    /** The current instance of this class. */
    private static App mInstance = null;

    /**
     * {@inheritDoc}
     * <p>Store link to the current instance.</p>
     * */
    @Override
    public void onCreate() { super.onCreate(); mInstance = this; }

    /**
     * Return current instance of this class.
     *
     * @throws NullPointerException If current app instance is null
     * */
    private static App getInstance() {
        if (mInstance == null)
            throw new NullPointerException(ERR_APP_INSTANCE_IS_NULL);
        else
            return mInstance;
    }

    /**
     * Return current application context.
     *
     * @throws NullPointerException If current app instance is null
     * */
    public static Context getContext() { return getInstance().getApplicationContext(); }

    /**
     * Returns the version code of this app.
     * */
    public static int getVersionCode() {
        final Context c = App.getContext();
        try {
            return c.getPackageManager().getPackageInfo(c.getPackageName(), 0).versionCode;
        } catch (PackageManager.NameNotFoundException e) { return App.BAD_VERSION_CODE; }
    }

    /**
     * Returns the version name of this app.
     * */
    public static String getVersionName() {
        final Context c = App.getContext();
        try {
            return c.getPackageManager().getPackageInfo(c.getPackageName(), 0).versionName;
        } catch (PackageManager.NameNotFoundException e) { return App.BAD_VERSION_NAME; }
    }
}