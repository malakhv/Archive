/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.data;

import android.content.Context;
import android.database.Cursor;
import android.database.DatabaseErrorHandler;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.provider.BaseColumns;

/**
 * The basic class for SQLite database.
 * @author Mikhail.Malakhov
 * */
@SuppressWarnings({"unused", "WeakerAccess"})
public abstract class DBSQLite extends SQLiteOpenHelper {

    private final Context mContext;

    /**
     * Make a new {@link DBSQLite} instance with specified parameters.
     * */
    public DBSQLite(Context context, String name, SQLiteDatabase.CursorFactory factory,
            int version) {
        super(context, name, factory, version);
        mContext = context;
    }

    /**
     * Make a new {@link DBSQLite} instance with specified parameters.
     * */
    public DBSQLite(Context context, String name, SQLiteDatabase.CursorFactory factory,
            int version, DatabaseErrorHandler errorHandler) {
        super(context, name, factory, version, errorHandler);
        mContext = context;
    }

    /**
     * @return The current context.
     * */
    protected Context getContext() {
        return mContext;
    }

    /**
     * Get readable cursor for a table.
     * @param table The name of table.
     * @return Readable Cursor for this table.
     * */
    public Cursor getReadableCursor(String table) {
        return this.getReadableDatabase().query(table, null, null, null, null,
                null, null);
    }

    /**
     * Get readable cursor for a table.
     * @param table The name of table.
     * @return Readable Cursor for this table.
     * */
    public Cursor getReadableCursor(String table, String idColumn, long id) {
        return this.getReadableDatabase().query(table, null, idColumn + " = ?",
                new String[]{String.valueOf(id)}, null, null, null);
    }

    /**
     * Get writable cursor for a table.
     * @param table The name of table.
     * @return Writable Cursor for this table.
     * */
    public Cursor getWritableCursor(String table) {
        return this.getWritableDatabase().query(table,null, null, null, null,
                null, null);
    }

    /**
     * Execute a single SQL statement that is NOT a SELECT or any other SQL statement that returns
     * data.
     * @param sql The SQL statement to be executed. Multiple statements separated by semicolons
     *            are not supported.
     * */
    public static boolean execSQL(SQLiteDatabase db, String sql) {
        if (db == null) return false;
        try {
            db.execSQL(sql);
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    /**
     * Attaches the database with given {@code name} and {@code path}.
     * */
    public static boolean attachDatabase(SQLiteDatabase db, String name, String path) {
        return execSQL(db, "ATTACH '" + path + "' AS " + name);
    }

    /**
     * Detaches the database with specified {@code name}.
     * */
    public static boolean detachDatabase(SQLiteDatabase db, String name) {
        return execSQL(db, "DETACH DATABASE " + name);
    }

    /**
     * Execute SQL query for drop table from data base.
     * @param db The data base.
     * @param table The name of table.
     * */
    public static boolean dropTable(SQLiteDatabase db, String table) {
        return DBSQLite.execSQL(db, "DROP TABLE IF EXISTS " + table);
    }

    /**
     * Execute SQL query for drop view from data base.
     * @param db The data base.
     * @param table The name of view.
     * */
    public static boolean dropView(SQLiteDatabase db, String table) {
        return DBSQLite.execSQL(db, "DROP VIEW IF EXISTS " + table);
    }

    /**
     * Execute SQL query for removing all data from specified table.
     * @param db The data base.
     * @param table The name of table.
     * */
    public static boolean clearTable(SQLiteDatabase db, String table) {
        return DBSQLite.execSQL(db, "" + table);
    }

    /**
     * The base interface for any table in database.
     * @author Mikhail.Malakhov
     * */
    public interface BaseTable extends BaseColumns {
        /**
         * The unique global ID for a row.
         * <p>Type: INTEGER</p>
         * */
        String COLUMN_GLOBAL_ID = "_id_global";
    }
}