/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.data;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.text.TextUtils;
import android.util.Pair;

import androidx.annotation.Nullable;

import com.devlear.app.beerhub.app.AppComponent;
import com.devlear.app.beerhub.content.AppContent;
import com.devlear.app.beerhub.util.StrUtils;
import com.malakhv.util.LogCat;

import java.io.File;
import java.util.Arrays;
import java.util.List;

/**
 * Class for management BeerHub database.
 * @author Mikhail.Malakhov
 * */
@SuppressWarnings("WeakerAccess")
public class BeerHubDB extends DBSQLite implements AppComponent {

    /** The tag for LogCat. */
    private static final String TAG = BeerHubDB.class.getSimpleName();

    /** The name of database file. */
    public static final String DB_NAME = "beer_hub.db";

    /** The current database version. */
    public static final int DB_VERSION = 1;

    /**
     * Constructs a new {@link BeerHubDB} instance with specified parameter.
     * */
    public BeerHubDB(Context context, SQLiteDatabase.CursorFactory factory) {
        super(context, DB_NAME, factory, DB_VERSION);
    }

    /**
     * {@inheritDoc}
     * <p>In this implementation, we should manage only app internal database.</p>
     * */
    @Override
    public void onCreate(SQLiteDatabase db) {
        // TableFavoriteBeer
        DBSQLite.dropTable(db, DBContract.TableFavBeer.TABLE_NAME);
        DBSQLite.execSQL(db, DBContract.TableFavBeer.SQL_CREATE);
        // TableFavPlace
        DBSQLite.dropTable(db, DBContract.TableFavPlace.TABLE_NAME);
        DBSQLite.execSQL(db, DBContract.TableFavPlace.SQL_CREATE);
        // TableNotes
        DBSQLite.dropTable(db, DBContract.TableNotes.TABLE_NAME);
        DBSQLite.execSQL(db, DBContract.TableNotes.SQL_CREATE);
    }

    /**
     * {@inheritDoc}
     * <p>In this implementation, we should manage only app internal database.</p>
     * */
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // No any action here, because we have only one app internal database version, right now
    }

    /**
     * {@inheritDoc}
     * <p>We attach database with real BeerHub data (external database) in this point.</p>
     * */
    @Override
    public void onOpen(SQLiteDatabase db) {
        super.onOpen(db);
        List<File> dbFiles = AppContent.getDatabaseFiles(getContext());
        for (int i = 0; i < dbFiles.size(); i++) {
            final File f = dbFiles.get(i);
            if (f == null || !f.canRead()) continue;
            if(!DBSQLite.attachDatabase(db, "data_" + i, f.getAbsolutePath())) {
                LogCat.e(TAG, "Cannot attach database - " + f.getAbsolutePath());
            }
        }
    }

    public void initHelpers() {
        FavHelper.init();
        LocaleHelper.init();
    }

    /** {@inheritDoc} */
    @Override
    public String getName() {
        return this.getDatabaseName();
    }

    /** {@inheritDoc} */
    @Override
    public String getVersion() {
        final SQLiteDatabase db = this.getReadableDatabase();
        return String.valueOf(db.getVersion());
    }

    /** {@inheritDoc} */
    @Override
    public boolean hasVersion() {
        return true;
    }

    /** {@inheritDoc} */
    public void dump() {
        final SQLiteDatabase db = this.getReadableDatabase();
        LogCat.i(TAG, "Name - " + this.getDatabaseName());
        LogCat.i(TAG, "Version - " +db.getVersion());
        LogCat.i(TAG, "Path - " + db.getPath());
        final List<Pair<String, String>> dbs = db.getAttachedDbs();
        if (dbs.isEmpty()) return;
        final StringBuilder builder = new StringBuilder(dbs.size());
        for (Pair<String, String> attached: dbs) {
            if (attached == null) continue;
            builder.append(attached.first).append(StrUtils.CHAR_EQUAL)
                    .append(attached.second).append(StrUtils.CHAR_NEW_LINE);
        }
        LogCat.i(TAG,"Attached DBs:\n" + builder.toString());
    }

    /**
     * Gets readable cursor for a table.
     * @return The readable cursor, or null.
     * */
    @Nullable
    public Cursor getReadableCursor(String table, String locale) {
        return getReadableCursor(table, locale, null, null);
    }

    /**
     * Gets readable cursor for a table's row with specified {@code id}.
     * @return The readable cursor, or null.
     * */
    @Nullable
    public Cursor getReadableCursor(String table, String locale, long id) {
        return getReadableCursor(table, locale, DBContract.COLUMN_ID + " = ?",
                new String[] { String.valueOf(id) });
    }

    /**
     * @return The readable cursor, or null.
     * */
    @Nullable
    public Cursor getReadableCursor(String table, String locale, String selection,
        String[] selectionArgs) {

        // Build selection
        final String sel;
        if (!TextUtils.isEmpty(selection)) {
            sel = selection + " and " + DBContract.LocaleTable.COLUMN_LOCALE + " = ?";
        } else {
            sel = DBContract.LocaleTable.COLUMN_LOCALE + " = ?";
        }

        // Build selection arguments
        final String[] args;
        if (selectionArgs != null) {
            args = Arrays.copyOf(selectionArgs, selectionArgs.length + 1);
            args[args.length -1 ] = locale;
        } else {
            args = new String[] { locale };
        }

        // Receive cursor
        try {
            return this.getReadableDatabase().query(table, null, sel, args,
                    null, null, null);
        } catch (SQLiteException e) {
            LogCat.e("Cannot receive a cursor", e);
            return null;
        }
    }
}