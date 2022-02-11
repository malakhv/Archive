package com.devlear.app.beerhub.data;

import android.database.Cursor;
import android.database.sqlite.SQLiteCursor;
import android.database.sqlite.SQLiteCursorDriver;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteQuery;

import com.devlear.app.beerhub.data.DBContract;

public class DBCursorFactory implements SQLiteDatabase.CursorFactory {

    public DBCursorFactory() {
        super();
    }

    @Override
    public Cursor newCursor(SQLiteDatabase db, SQLiteCursorDriver masterQuery, String editTable,
            SQLiteQuery query) {
        if (DBContract.ViewCountry.VIEW_NAME.equals(editTable)) {
            return new CityCursor(masterQuery, editTable, query);
        }
        return new SQLiteCursor(masterQuery, editTable, query);
    }

    public class CityCursor extends SQLiteCursor {

        public static final int INDEX_CITY_ID = 0;
        public static final int INDEX_COUNTRY_ID = 1;

        public CityCursor(SQLiteCursorDriver driver, String editTable, SQLiteQuery query) {
            super(driver, editTable, query);
        }

        public int getCityId() {
            return this.getInt(INDEX_CITY_ID);
        }

        public int getCountryId() {
            return this.getInt(INDEX_COUNTRY_ID);
        }
    }

}
