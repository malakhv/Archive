package com.vectordigital.commonlibs.application;

import android.content.ComponentName;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.util.Log;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.Properties;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;

import static java.lang.Thread.currentThread;

/**
 * Created by a.karmanov on 12.08.13.
 */
public class ApplicationUtils {

    public static final String ERROR_REPORT = "%s \n %s";

    public static void setupLogging(Context context, String applicationName, int logFileId) {
        try {
            ClassLoader loader = currentThread().getContextClassLoader();
            currentThread().setContextClassLoader(ApplicationUtils.class.getClassLoader());
            InputStream inputStream = context.getResources().openRawResource(logFileId);
            LogManager.getLogManager().readConfiguration(inputStream);
            inputStream.close();

            // initialize all headers
            inputStream = context.getResources().openRawResource(logFileId);
            Properties properties = new Properties();
            properties.load(inputStream);
            inputStream.close();
            Set<Object> keys = properties.keySet();
            for (Object keyO : keys) {
                String key = (String) keyO;
                if (key != null && key.endsWith(".handlers")) {
                    Logger.getLogger(key.substring(0, key.length() - ".handlers".length())).getHandlers();
                }
            }

            //Log application info
            String version = null;
            String packageName = null;
            try {
                PackageInfo packageInfo = context.getPackageManager().getPackageInfo(new ComponentName(context, context.getClass()).getPackageName(), 0);
                version = packageInfo.versionName;
                packageName = packageInfo.packageName;
            } catch (PackageManager.NameNotFoundException e) {
                e.printStackTrace();
            }
            if (Logger.getLogger("AndroidAppDeveloper").isLoggable(Level.INFO)) {
                Logger.getLogger("AndroidAppDeveloper").info("Starting Application " + applicationName + " v. " + version + " package: " + packageName);
            }

            currentThread().setContextClassLoader(loader);
        } catch (Exception e) {
            Log.e("ApplicationUtils", e.getMessage(), e);
        }
    }

    public static String getErrorReport(String message, Throwable e) {
        if (message != null && message.length() > 0) {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            e.printStackTrace(new PrintStream(byteArrayOutputStream));
            return String.format(ERROR_REPORT, message, byteArrayOutputStream.toString());
        } else {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            e.printStackTrace(new PrintStream(byteArrayOutputStream));
            return byteArrayOutputStream.toString();
        }
    }

    public static void updateDebugInfo() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD ) {
//            StrictMode.setThreadPolicy(new StrictMode.ThreadPolicy.Builder()
//                    .detectAll()
//                    .penaltyDeath()
//                    .build());
//        }

    }

}
