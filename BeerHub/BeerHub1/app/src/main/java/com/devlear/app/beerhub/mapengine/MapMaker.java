/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.mapengine;

import android.app.Activity;
import android.app.FragmentTransaction;
import android.content.Context;

import com.devlear.app.beerhub.R;

/**
 * The factory class to construct {@link MapEngine} instance.
 * @author Mikhail.Malakhov
 * */
public final class MapMaker {

    private static final int DEF_MAP_CONTAINER_ID = R.id.map_container;

    /** Google zoom level: To see current location. */
    private static final float GOOGLE_ZOOM_LEVEL_ME = 17;

    /** Google zoom level: To see city. */
    private static final float GOOGLE_ZOOM_LEVEL_CITY = 11;

    /** Google zoom level: To keep current zoom level. */
    private static final float GOOGLE_ZOOM_LEVEL_OFF = -1;

    private static MapConfig makeConfig(Context context, MapType type) {
        switch (type) {
            case GOOGLE: return makeGoogleConfig(context);
            default: throw new IllegalArgumentException("Unsupported map type...");
        }
    }

    private static MapConfig makeGoogleConfig(Context context) {
        final MapConfig config = new MapConfig();
        config.put(MapConfig.KEY_ZOOM_LEVEL_ME, GOOGLE_ZOOM_LEVEL_ME);
        config.put(MapConfig.KEY_ZOOM_LEVEL_CITY, GOOGLE_ZOOM_LEVEL_CITY);
        config.put(MapConfig.KEY_ZOOM_LEVEL_OFF, GOOGLE_ZOOM_LEVEL_OFF);
        return config;
    }

    public static MapEngine makeMapEngineForActivity(Activity activity, MapCallbacks callbacks,
            MapType type) {
        switch (type) {
            case GOOGLE:
                makeGoogleMapEngineForActivity(activity, callbacks);
                return null;
            default: throw new IllegalArgumentException("Unsupported map type...");
        }
    }

    private static void makeGoogleMapEngineForActivity(Activity activity,
            MapCallbacks callbacks) {
        // Map Config
        final MapConfig config = makeGoogleConfig(activity);

        // Map fragment
        final com.google.android.gms.maps.MapFragment fragment =
                com.google.android.gms.maps.MapFragment.newInstance();
        FragmentTransaction transaction = activity.getFragmentManager().beginTransaction();
        transaction.add(DEF_MAP_CONTAINER_ID, fragment);
        transaction.commit();

        // Map engine
        final GoogleMapEngine engine = new GoogleMapEngine(activity, config);
        engine.mMapFragment = fragment;
        engine.initMap(callbacks);
    }

}
