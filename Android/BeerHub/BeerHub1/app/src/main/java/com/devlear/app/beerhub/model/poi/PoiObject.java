/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.model.poi;

import com.devlear.app.beerhub.data.DBContract;
import com.devlear.app.beerhub.data.FavHelper;
import com.devlear.app.beerhub.data.RowObject;
import com.devlear.app.beerhub.model.LatLon;

/**
 * Class represent a row in database's table as an POI (Point Of Interest) object with
 * additional data.
 * @author Mikhail.Malakhov
 * */
public class PoiObject extends RowObject {

    /** The key to store "favorite" status. */
    private static final String FAV_KEY = "fav";

    private static final String FAV_VALUE = "1";

    /** The location of POI. */
    private LatLon mLatLon = new LatLon();

    /** The type of this POI. */
    private PoiType mType = PoiType.UNKNOWN;

    /**
     * Construct a new {@link PoiObject} instance with default parameters.
     * */
    public PoiObject() {
        this(PoiType.UNKNOWN);
    }

    /**
     * Construct a new {@link PoiObject} instance with specified type.
     * */
    public PoiObject(PoiType type) {
        mType = type;
    }

    /**
     * @return The latitude of this POI, in degrees.
     * */
    public double getLatitude() { return mLatLon.getLatitude(); }

    /**
     * @return The longitude of this POI, in degrees.
     * */
    public double getLongitude() { return mLatLon.getLongitude(); }

    /**
     * @return True, if this POI object has location data, otherwise false.
     * */
    public boolean hasLocation() { return !mLatLon.isEmpty(); }

    /**
     * @return The type of this POI.
     * */
    public PoiType getType() {
        return mType;
    }

    /**
     * The name of this POI.
     * */
    public String getName() {
        return getString(DBContract.PoiView.COLUMN_NAME);
    }

    /**
     * The information about this POI.
     * */
    public String getInfo() {
        return getString(DBContract.PoiView.COLUMN_INFO);
    }

    /**
     * The short information about this POI.
     * */
    public String getAbout() {
        return getString(DBContract.PoiView.COLUMN_ABOUT);
    }

    /**
     * The POI address.
     * */
    public String getAddress() {
        return getString(DBContract.ViewPlace.COLUMN_ADDRESS);
    }

    /**
     * @return The direct link to Google Map object.
     * */
    public String getGoogle() {
        return getString(DBContract.ViewPlace.COLUMN_MAP_GOOGLE);
    }

    /**
     * @return The direct link to web site related to this POI object.
     * */
    public String getWeb() {
        return getString(DBContract.ViewPlace.COLUMN_WEB);
    }

    /**
     * @return The direct link to wiki page related to this POI object.
     * */
    public String getWiki() {
        return getString(DBContract.ViewPlace.COLUMN_WIKI);
    }

    /**
     * @return The phone number of this POI object, or {@code null}.
     * */
    public String getPhone() {
        return getString(DBContract.ViewPlace.COLUMN_PHONE);
    }

    public boolean isFav() {
        // TODO May be should be:
        // TODO if (mType == PlaceType.PLACE) {
        // TODO     return FavHelper.isFavPlace(getId());
        // TODO }
        //return FAV_VALUE.equals(getString(FAV_KEY));
        if (mType == PoiType.PLACE) {
             return FavHelper.isFavPlace(getId());
        } else return false;
    }

    /**
     * @return The comments about this POI.
     * */
    public String getComments() {
        return  getString(DBContract.ViewPlace.COLUMN_COMMENTS);
    }

    /** {@inheritDoc} */
    @Override
    protected String onItemLoad(String key, String value) {
        // Parse original location data and store it
        if (DBContract.LocationTable.COLUMN_LOCATION.equals(key)) {
            mLatLon = LatLon.fromString(value);
        }
        return super.onItemLoad(key, value);
    }

    /** {@inheritDoc} */
    @Override
    protected void onPostLoad() {
        super.onPostLoad();
        if (hasId() && mType == PoiType.PLACE) {
            boolean fav = FavHelper.isFavPlace(getId());
            if (fav) putRaw(FAV_KEY, FAV_VALUE);
        }
    }
}
