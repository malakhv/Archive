/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.util;

import android.content.Context;
import android.content.res.Resources;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * Class contains some things to work with app resources.
 * @author Mikhail.Malakhov
 * */
@SuppressWarnings({"unused", "WeakerAccess"})
public final class ResUtils {

    /**
     * Copies raw resources to file.
     * @param res The app resources.
     * @param rawId The raw resource id.
     * @param path The full file path to copy raw resource.
     *
     * @throws IOException When any problem with file operations happens.
     * */
    public static void copyRawToFile(Resources res, int rawId, String path) throws IOException {
        try (InputStream in = res.openRawResource(rawId);
             FileOutputStream out = new FileOutputStream(path)) {
            FileUtils.copy(in, out);
        }
    }

    /**
     * Copies raw resources to file.
     * @param res The app resources.
     * @param rawId The raw resource id.
     * @param path The file to copy raw resource.
     *
     * @throws IOException When any problem with file operations happens.
     * */
    public static void copyRawToFile(Resources res, int rawId, File path) throws IOException {
        if (path != null) {
            copyRawToFile(res, rawId, path.getAbsolutePath());
        }
    }

    /**
     * Return a resource identifier for the given resource name.
     * @param res The app resources.
     * @param pkg The package to find resource.
     * @param type The resource type to find.
     * @param name The name of the desired resource.
     *
     * @return The associated resource identifier. Returns {@code 0} if no such
     * resource was found ({@code 0} is not a valid resource ID).
     * */
    public static int getId(Resources res, String pkg, String type, String name) {
        return res.getIdentifier(name, type, pkg);
    }

    /**
     * Return a resource identifier for the given resource name.
     * @param context The app context to accesses to the resources.
     * @param type The resource type to find.
     * @param name The name of the desired resource.
     *
     * @return The associated resource identifier. Returns {@code 0} if no such
     * resource was found ({@code 0} is not a valid resource ID).
     * */
    public static int getId(Context context, String type, String name) {
        return getId(context.getResources(), context.getPackageName(), type, name);
    }

    /**
     * This class has only static data, not need to create instance.
     * */
    private ResUtils() { /* Empty */ }
}
