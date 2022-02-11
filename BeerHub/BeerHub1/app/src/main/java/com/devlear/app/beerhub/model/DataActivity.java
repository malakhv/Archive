/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.model;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;

import androidx.annotation.Nullable;

import com.devlear.app.beerhub.BeerHubApp;
import com.devlear.app.beerhub.data.DBContract;
import com.devlear.app.beerhub.data.LocaleHelper;
import com.devlear.app.beerhub.data.RowObject;
import com.devlear.app.beerhub.util.MetaData;

/**
 * The Activity that represents one database object.
 * @author Mikhail.Malakhov
 * */
public abstract class DataActivity<T extends RowObject> extends Activity {

    /**
     * The Intent Extra data: the unique ID for a row.
     * <p>TYPE: long</p>
     * */
    public static final String EXTRA_ID = "extra_id";

    /**
     * The Intent Extra data: the database table for retrieve data.
     * */
    public static final String EXTRA_TABLE = "extra_table";

    /** The data item that represents one database object. */
    private T mDataItem = makeDataItem();

    /*** {@inheritDoc} */
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        final DataItemInfo info = getDataItemInfo();
        loadDataItem(info.table, info.id);
    }

    protected DataItemInfo getDataItemInfo() {
        long id = DBContract.NO_ID;
        String table  = null;

        final Intent intent = getIntent();

        // Try to load data from deep link, firstly
        if (Intent.ACTION_VIEW.equals(intent.getAction())) {
            final Uri uri = intent.getData();
            if (uri != null) {
                String placeId = uri.getLastPathSegment();
                id = Long.parseLong(placeId);
            }
            return new DataItemInfo(id, DBContract.ViewPlace.VIEW_NAME);
        }

        // Try to load data from metadata, first
        id = MetaData.getInt(this,"com.devlear.app.beerhub.content.city_id", -1);
        if (id > DBContract.NO_ID) {
            table = DBContract.ViewCity.VIEW_NAME;
        } else {
            if (intent != null) {
                id = DataActivity.getId(intent);
                table = DataActivity.getTable(intent);
            }
        }

        // Try to load from deep link
        if (id <= DBContract.NO_ID) {
            ///
        }

        return new DataItemInfo(id, table);
    }

    /**
     * Makes the data item that represents database row that activity was started for. In future
     * implementation you should create instance and configure it, if needed.
     * */
    protected abstract T makeDataItem();

    /**
     * Loads data that activity was started for, from database.
     * */
    protected void loadDataItem(String table, long id) {
        DataActivity.loadDataItem(table,id, mDataItem);
    }

    /**
     * @return The current row ID that activity was started for, or {@link DBContract#NO_ID}.
     * */
    protected long getId() {
        return mDataItem.getId();
    }

    /**
     * @return True, if this activity associated data from database, otherwise false.
     * @see #getData()
     * */
    protected boolean hasData() { return !mDataItem.isEmpty(); }

    /**
     * @return The data from database that this activity associated for, or {@code null}.
     * @see #hasData()
     * */
    protected T getData() {
        return mDataItem;
    }

    /**
     * Makes the intent for launch activity with specified class for given row ID.
     * */
    public static Intent makeLaunchIntent(Context context, Class<? extends Activity> clazz,
            String table, long id) {
        final Intent intent = new Intent(context, clazz);
        intent.putExtra(EXTRA_ID, id);
        intent.putExtra(EXTRA_TABLE, table);
        return intent;
    }

    /**
     * Receives database row's id from specified intent.
     * */
    public static long getId(Intent intent) {
        return intent != null ? intent.getLongExtra(EXTRA_ID, DBContract.NO_ID) : DBContract.NO_ID;
    }

    /**
     * Receives database table from specified intent.
     * */
    public static String getTable(Intent intent) {
        return intent != null ? intent.getStringExtra(EXTRA_TABLE) : null;
    }

    /**
     * Loads data item from database.
     * */
    public static void loadDataItem(String table, long id, RowObject out) {
        if (out != null) {
            out.clear();
        } else {
            return;
        }
        if (TextUtils.isEmpty(table) || id <= DBContract.NO_ID) return;
        final Cursor cursor = BeerHubApp.getInstance().getDataBase().getReadableCursor(
                table, LocaleHelper.getCurrentLocale(), id);
        if (cursor == null) return;
        cursor.moveToFirst();
        out.load(cursor);
        cursor.close();
    }

    protected static class DataItemInfo {
        public final long id;
        public final String table;

        public DataItemInfo(long id, String table) {
            this.id = id;
            this.table = table;
        }
    }

}
