/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub project.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.content;

import android.content.Context;
import android.content.SharedPreferences;
import android.text.TextUtils;

import com.devlear.beerhub.BuildConfig;
import com.devlear.beerhub.R;
import com.devlear.libs.crypto.Crypto;
import com.malakhv.app.ResUtils;
import com.malakhv.util.FileUtils;
import com.malakhv.util.LogCat;
import com.malakhv.util.ZipUtils;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.List;

/**
 * Class contains methods for managing app data (content).
 * @author Mikhail.Malakhov
 * */
public class AppContent {

    /** The tag for LogCat. */
    private static final String TAG = AppContent.class.getSimpleName();

    /** The default path (in app data) for all content (databases, metadata, media, wiki). */
    private static final String CONTENT_PATH = "content";

    /** The default path (in app data) for media content (images, icons, etc.). */
    private static final String MEDIA_PATH = CONTENT_PATH + "/media";

    /** The default path (in app data) for wiki content (html pages and related files). */
    private static final String WIKI_PATH = CONTENT_PATH + "/wiki";

    /** The root dir (absolute path) with app data (content). */
    // TODO May be public File mContentDir ?
    public static String DATA_DIR = null;

    /** The name of preference that contains the current version of app data (content). */
    private static final String PREF_VERSION = "content_version";

    public static FileResources sResManager = null;

    /**
     * Initializes this {@link AppContent} instance. After this point, all data should be
     * ready to use.
     * */
    public static void init(Context context, int version) {

        // Check content version
        final int current = getVersion(context);
        // We don't support upgrade and/or downgrade content's version, now. If versions not
        // equals, just replace it
        if (BuildConfig.DEBUG || current != version) {
            LogCat.i(TAG, "Need to import app content...");
            removeContent(context);
            if (importAllData(context)) {
                setVersion(context, version);
            }
        }

        // Calculate root dir for all app data (content)
        File root = getContentDir(context);
        if (root != null && root.canRead()) {
            DATA_DIR = root.getAbsolutePath();
            if (LogCat.isDebug()) {
                LogCat.d(TAG, "Content dir - " + DATA_DIR);
            }
        }

        // Init res manager
        sResManager = FileResources.makeForDir(DATA_DIR + "/media");
        sResManager.updateConfiguration(context);
    }

    /**
     * Imports all data files from app raw resources.
     * */
    private static boolean importAllData(Context context) {
        boolean result = true;
        String[] rawList = context.getResources().getStringArray(R.array.content_list);
        for (String raw: rawList) {
            int rawId = ResUtils.getId(context, "raw", raw);
            if (!importData(context, raw, rawId)) {
                result = false; break;
            }
        }
        return result;
    }

    /**
     * Imports data file from app raw resources.
     * */
    private static boolean importData(Context context, String name, int rawId) {

        // Create content root dir, if needed
        final File root = getContentDir(context);

        // Copy content from resources
        final File dat = new File(root, name + ".dat");
        try {
            ResUtils.copyRawToFile(context.getResources(), rawId, dat);
        } catch (IOException e) {
            LogCat.w(TAG, e);
            return false;
        }

        // Decode content
        final File zip = new File(root, name + ".zip");
        if (!Crypto.decode(dat, zip)) {
            LogCat.e(TAG, "Cannot decode app data...");
            return false;
        }

        // Unzip content
        try {
            ZipUtils.unzipTo(zip, root);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        FileUtils.delete(dat);
        FileUtils.delete(zip);

        return true;
    }

    /**
     * Makes content root dir, if needed.
     * */
    private static File getContentDir(Context context) {
        final File f = new File(context.getFilesDir(), CONTENT_PATH);
        if (!f.exists() && !f.mkdirs()) {
            LogCat.w(TAG, "Cannot create content root dir - " + f);
            return null;
        }
        return f;
    }

    /**
     * Removes all existing content.
     * */
    public static void removeContent(Context context) {
        File f = new File(context.getFilesDir(), CONTENT_PATH);
        FileUtils.deleteAll(f);
    }

    /**
     * @return The current version of content.
     * */
    private static int getVersion(Context context) {
        final SharedPreferences prefs = context.getSharedPreferences("content",
                Context.MODE_PRIVATE);
        return prefs.getInt(PREF_VERSION, 0);
    }

    /** */
    private static void setVersion(Context context, int version) {
        final SharedPreferences prefs = context.getSharedPreferences("content",
                Context.MODE_PRIVATE);
        final SharedPreferences.Editor editor = prefs.edit();
        editor.putInt(PREF_VERSION, version >= 0 ? version : 0);
        editor.apply();
    }

    public static List<File> getDatabaseFiles(Context context) {
        final File root = getContentDir(context);
        return FileUtils.listFiles(root, new DatabaseFileFilter());
    }

    public static File getContentDirForTable(Context context, String table) {
        if (TextUtils.isEmpty(table)) return null;
        final File f = new File(context.getFilesDir(), MEDIA_PATH + "/" + table);
        return f.exists() ? f : null;
    }

    public static File getContentDirForRow(Context context, String table, long id) {
        if (TextUtils.isEmpty(table)) return null;
        final File f = new File(getContentDirForTable(context, table), "/" + id);
        return f.exists() ? f : null;
    }

    public static FileResources getResources() {
        return sResManager;
    }

    /**
     * The class for filtering database files.
     * */
    private static class DatabaseFileFilter implements FilenameFilter {

        /** The database file extension. */
        private static final String DB_FILE_EXT = "db";

        /** {@inheritDoc} */
        @Override
        public boolean accept(File dir, String name) {
            return name.endsWith(DB_FILE_EXT);
        }
    }
}
