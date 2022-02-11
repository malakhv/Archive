/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.model.poi;

import android.content.Context;

import com.devlear.beerhub.data.DBContract;

/**
 * @author Mikhail.Malakhov
 */
public interface PoiActions {

    /**
     * Sets the POI to this actions.
     * */
    void setPoi(PoiObject poi);

    /**
     * @return True, if this actions have POI object.
     * */
    boolean hasPoi();

    /**
     * POI action: Toggling favorites.
     * */
    void onFav();

    /**
     * POI action: Showing POI on external MAP application.
     * @see DBContract.LocationTable#COLUMN_MAP_GOOGLE
     * @see DBContract.LocationTable#COLUMN_MAP_MAPSME
     * @see DBContract.LocationTable#COLUMN_MAP_MAPYCZ
     * */
    void onMap(Context context);

    /**
     * POI action: Opening web page associated with POI.
     * @see DBContract.WebTable#COLUMN_WEB
     * */
    void onWeb(Context context);

    /**
     * POI action: Opening wiki page associated with POI.
     * @see DBContract.WikiTable#COLUMN_WIKI
     * */
    void onWiki(Context context);

    /**
     * POI action: Sharing information about POI to another app.
     * */
    void onShare(Context context);

    /**
     * POI action: Make a phone call to selected place.
     * */
    void onCall(Context context);

}
