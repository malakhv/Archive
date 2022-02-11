/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.content;

import static com.devlear.app.beerhub.content.AppContent.sResManager;

import android.content.Context;
import android.text.TextUtils;
import android.util.DisplayMetrics;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.model.poi.PoiType;
import com.devlear.app.beerhub.util.StrUtils;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * Class provides methods to retrieve media files related with database content from file system.
 * The API of this class mimics to Android {@link android.content.res.Resources}.
 * @author Mikhail.Malakhov
 * */
public class FileResources {

    /** The density string for unspecified dpi value. */
    public static final String DENSITY_NO = "nodpi";

    /** The density string for {@link DisplayMetrics#DENSITY_LOW} dpi. */
    public static final String DENSITY_LOW = "ldpi";

    /** The density string for {@link DisplayMetrics#DENSITY_MEDIUM} dpi. */
    public static final String DENSITY_MEDIUM = "mdpi";

    /** The density string for {@link DisplayMetrics#DENSITY_TV} dpi. */
    public static final String DENSITY_TV = "tvdpi";

    /** The density string for {@link DisplayMetrics#DENSITY_HIGH} dpi. */
    public static final String DENSITY_HIGH = "hdpi";

    /** The density string for {@link DisplayMetrics#DENSITY_XHIGH} dpi. */
    public static final String DENSITY_XHIGH = "xhdpi";

    /** The density string for {@link DisplayMetrics#DENSITY_XXHIGH} dpi. */
    public static final String DENSITY_XXHIGH = "xxhdpi";

    /** The density string for {@link DisplayMetrics#DENSITY_XXXHIGH} dpi. */
    public static final String DENSITY_XXXHIGH = "xxxhdpi";

    /** The map to quick access to density string values. */
    private static final Map<Integer, String> DENSITY_MAP = new HashMap<>();
    static {
        DENSITY_MAP.put(0, DENSITY_NO);
        DENSITY_MAP.put(DisplayMetrics.DENSITY_LOW, DENSITY_LOW);
        DENSITY_MAP.put(DisplayMetrics.DENSITY_MEDIUM, DENSITY_MEDIUM);
        DENSITY_MAP.put(DisplayMetrics.DENSITY_TV, DENSITY_TV);
        DENSITY_MAP.put(DisplayMetrics.DENSITY_HIGH, DENSITY_HIGH);
        DENSITY_MAP.put(DisplayMetrics.DENSITY_XHIGH, DENSITY_XHIGH);
        DENSITY_MAP.put(DisplayMetrics.DENSITY_XXHIGH, DENSITY_XXHIGH);
        DENSITY_MAP.put(DisplayMetrics.DENSITY_XXXHIGH, DENSITY_XXXHIGH);
    }

    /**
     * The internal map for dependencies between res id and file name. Please keep it sync
     * with {code R.id.*} and files on disk.
     * */
    private static final Map<Integer, String> RES_MAP = new HashMap<>();
    static {
        RES_MAP.put(R.id.logo, "logo.png");
    }

    /** The root absolute path of . */
    private final String mResRoot;

    /** The current density value. */
    private int mDensityDpi = DisplayMetrics.DENSITY_MEDIUM;

    /**
     * Constructs the {@link FileResources} instance with specified parameters.
     * @param resRoot The root path (absolute) for target resources.
     * */
    private FileResources(String resRoot) {
        mResRoot = resRoot;
    }

    /**
     * Gets directory with media content for specified database table.
     * */
    private static File getContentDirForTable(Context context, String table) {
        if (TextUtils.isEmpty(table)) return null;
        final File f = new File(context.getFilesDir(), sResManager.mResRoot + "/" + table);
        return f.exists() ? f : null;
    }

    /**
     * Gets directory with media content for specified row in table.
     * */
    private static File getContentDirForRow(Context context, String table, long id) {
        if (TextUtils.isEmpty(table)) return null;
        final File f = new File(FileResources.getContentDirForTable(context, table), "/" + id);
        return f.exists() ? f : null;
    }

    /**
     * Gets directory with media content for POI with specified {@code type}.
     * */
    public static File getContentDirForPoi(Context context, PoiType type, long id) {
        final String prefix = getDpiAsString(context);
        if (prefix != null) {
            return FileResources.getContentDirForRow(context, type.getContentPath() + "/"
                    + prefix, id);
        } else {
            return FileResources.getContentDirForRow(context, type.getContentPath(), id);
        }
    }

    /**
     * Gets DPI as string. In normal case this value should be {@code mdpi}, {@code hdpi} and etc,
     * but it can be raw value.
     * */
    public static String getDpiAsString(Context context) {
        final int dpi = getRawDpi(context);
        final String dpiAsStr = DENSITY_MAP.get(dpi);
        return dpiAsStr != null ? dpiAsStr : DENSITY_NO;
    }

    /**
     * Gets DPI as string. In normal case this value should be {@code mdpi}, {@code hdpi} and etc,
     * but it can be raw value.
     * */
    public static String getDensityAsString(int density) {
        final String dpiAsStr = DENSITY_MAP.get(density);
        return dpiAsStr != null ? dpiAsStr : DENSITY_NO;
    }

    /**
     * Gets the screen density expressed as dots-per-inch. May be either
     * {@link @DisplayMetrics#DENSITY_LOW}, {@link @DisplayMetrics#DENSITY_MEDIUM}, or
     * {@link @DisplayMetrics#DENSITY_HIGH}.
     * */
    protected static int getRawDpi(Context context) {
        final DisplayMetrics dm = context.getResources().getDisplayMetrics();
        return dm.densityDpi;
    }

    /**
     *
     * */
    public String getResPathForDensity(String table, long rowId, int resId, int density) {
        final String SLASH = StrUtils.CHAR_SLASH;
        // For example: media/place/1/hdpi/logo.png
        final String d = getDensityAsString(density);
        if (!TextUtils.isEmpty(d)) {
            return mResRoot + SLASH + table + SLASH + rowId + SLASH + d + SLASH
                    + resIdToStr(resId);
        } else {
            return null;
        }
    }

    public String getResPath(String table, long rowId, int resId) {
        final String pathForDensity = getResPathForDensity(table, rowId, resId, mDensityDpi);
        final File f = new File(pathForDensity);
        if (!f.exists()) {
            return getResPathForDensity(table, rowId, resId, 0);
        }
        return pathForDensity;
    }

    public File getResFile() {
        return null;
    }

    protected static String resIdToStr(int resId) {
        return RES_MAP.get(resId);
    }


    public void updateConfiguration(Context context) {
        mDensityDpi = getRawDpi(context);
    }


    public static String getDrawablePath(Context context, String description, int id) {
        return null; // By ID
    }

    /**
     * Makes the {@link FileResources} for specified resources dir.
     * */
    public static FileResources makeForDir(String resRoot) {
        final File root = new File(resRoot);
        if (root.exists() && root.canRead()) {
            return new FileResources(resRoot);
        } else {
            throw new IllegalArgumentException("The " + resRoot + " should exists and readable!");
        }
    }

}