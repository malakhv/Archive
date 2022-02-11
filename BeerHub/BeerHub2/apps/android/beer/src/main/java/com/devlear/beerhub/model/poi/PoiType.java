package com.devlear.beerhub.model.poi;

import com.devlear.beerhub.data.DBContract;

/**
 * @author Mikhail.Malakhov
 */
public enum PoiType {

    UNKNOWN(null, null),
    COUNTRY(DBContract.ViewCountry.VIEW_NAME, DBContract.ViewCountry.TABLE_NAME),
    CITY(DBContract.ViewCity.VIEW_NAME, DBContract.ViewCity.TABLE_NAME),
    BREWERY("view_brewery", "brewery"),
    PLACE(DBContract.ViewPlace.VIEW_NAME, DBContract.ViewPlace.TABLE_NAME);

    private final String mTable;

    private final String mContentPath;

    /** Enum constructor. */
    PoiType(String table, String contentPath) {
        mTable = table;
        mContentPath = contentPath;
    }

    public String getTable() {
        return mTable;
    }

    public String getContentPath() {
        return mContentPath;
    }
}