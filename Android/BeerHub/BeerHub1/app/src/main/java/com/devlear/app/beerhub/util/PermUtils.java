/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.util;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.text.TextUtils;

import androidx.annotation.RequiresApi;

import java.util.HashSet;
import java.util.Set;

import static android.Manifest.permission.ACCESS_COARSE_LOCATION;
import static android.Manifest.permission.ACCESS_FINE_LOCATION;

/**
 * The class for manage app permissions.
 * @author Mikhail.Malakhov
 * */
public class PermUtils {

    /**
     * @return True, if device support runtime permissions mechanism.
     * */
    private static boolean isOldDevice() {
        return Build.VERSION.SDK_INT <= Build.VERSION_CODES.M;
    }

    /**
     * Checks the app permissions and request them if needed.
     * */
    // TODO Need to move to a base activity class
    public static void check(Activity activity, int requestCode) {
        if (isOldDevice()) return;
        request(activity, requestCode, ACCESS_FINE_LOCATION, ACCESS_COARSE_LOCATION);
    }

    /**
     * Checks the specified permission for app.
     * @return True, if app has permission with specified name.
     * */
    public static boolean has(Context context, String name) {
        if (context == null || TextUtils.isEmpty(name)) return false;
        if (isOldDevice()) return true;
        return context.checkCallingOrSelfPermission(name) == PackageManager.PERMISSION_GRANTED;
    }

    /**
     * Request specified permissions.
     * */
    @RequiresApi(api = Build.VERSION_CODES.M)
    private static void request(Activity activity, int requestCode, String... names) {
        if (activity == null || names == null || names.length <= 0) return;

        // Check granted permissions
        final Set<String> toRequest = new HashSet<>(names.length);
        for (String name : names) {
            if (TextUtils.isEmpty(name)) continue;
            if (!has(activity, name)) toRequest.add(name);
        }
        // All permission granted?
        if (toRequest.isEmpty()) return;

        // Request permissions
        String[] permissions = new String[toRequest.size()];
        toRequest.toArray(permissions);
        activity.requestPermissions(permissions, requestCode);
    }

    /** This class has only static data, not need to create instance. */
    private PermUtils() {
        /* empty */
    }
}