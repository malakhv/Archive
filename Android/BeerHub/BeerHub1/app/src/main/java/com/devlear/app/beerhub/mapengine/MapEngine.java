/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.mapengine;

import com.devlear.app.beerhub.map.MapMarker;
import com.devlear.app.beerhub.model.LatLon;

/**
 * The abstract engine for unspecified map. This interface contains basic operations available
 * for any map.
 * @author Mikhail.Malakhov
 * */
public interface MapEngine {

    /**
     * Returns {@code true}, if this engine has a real map and this map was been initialized,
     * otherwise {@code false}.
     * */
    boolean hasMap();

    /**
     * Adds an existing marker to map. The raw marker object for real map will be created.
     * @return True, if marker has been added to real map.
     * */
    boolean addMarker(MapMarker marker);

    /**
     * Creates new marker and adds it to real map. The raw marker object for real map will be
     * created.
     * @return The new marker instance, or {@code null}.
     * */
    MapMarker addMarker(String title, LatLon position);

    /**
     * Creates new marker and adds it to real map. The raw marker object for real map will be
     * created.
     * @return The new marker instance, or {@code null}.
     * */
    MapMarker addMarker(String title, LatLon position, boolean visible);

    /**
     * Removes marker from real map. After this operation, specified object will unlinked
     * from any marker on real map, but you can use it again.
     * */
    void removeMarker(MapMarker marker);

    /**
     * Updates marker on real map follow specified object.
     * */
    void updateMarker(MapMarker marker);

    /**
     * Returns {@code true} if real map contain marker related with specified object.
     * */
    boolean hasMarker(MapMarker marker);

    /**
     * Removes all objects from real map. After this operation this engine will have
     * no any map objects. If you had any map object filter, it will be removed.
     * */
    void clear();

    /**
     * Temporary hides all objects on real map. After this operation this engine will continue
     * have all map objects. If you had any map object filter, it will be removed.
     * */
    void hideAll();

    /**
     * Shows all existing objects on real map. This operation does not create new objects
     * on map, just show existing. If you had any map object filter, it will be removed.
     * */
    void showAll();

    /**
     * Moves camera to specified position.
     * */
    void moveCamera(LatLon position);

    /**
     * Moves camera to specified marker.
     * */
    void moveCamera(MapMarker marker);

    /**
     * Moves camera to specified position and settings up zoom level.
     * */
    void moveCamera(LatLon position, int zoom);

    /**
     * Moves camera to specified marker and settings up zoom level.
     * */
    void moveCamera(MapMarker marker, int zoom);

    /**
     * Moves camera to specified position and settings up animation.
     * */
    void moveCamera(LatLon position, boolean animation);

    /**
     * Moves camera to specified position and settings up zoom level and animation.
     * */
    void moveCamera(LatLon position, int zoom, boolean animation);

    /**
     * Moves camera to specified marker and settings up zoom level and animation.
     * */
    void moveCamera(MapMarker marker, int zoom, boolean animation);

    /**
     * Start initialization of real map instance. Before this operation real map instance
     * may not be available for use. Also, before this operation, engine should have all
     * necessary data to initialization real map object. The map initialization can be
     * asynchronous.
     * */
    void initMap(MapCallbacks callbacks);

    /**
     * Returns value of zoom level to comfort show current location on a map.
     * */
    float getZoomLevelMe();

    /**
     * Returns value of zoom level to comfort show city on a map.
     * */
    float getZoomLevelCity();

    /**
     * Returns value of zoom level to comfort show country on a map.
     * */
    float getZoomLevelCountry();

    /**
     * Returns value of zoom level to inform a map that not needed change current zoom level.
     * */
    float getZoomLevelOff();
}
