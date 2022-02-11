package com.devlear.beerhub.map;

import com.devlear.beerhub.model.LatLon;

/**
 * @author Mikhail.Malakhov
 */
public interface MapEngine {

    boolean hasMap();

    boolean addMarker(MapMarker marker);
    boolean hasMarker(MapMarker marker);
    void removeMarker(MapMarker marker);
    void updateMarker(MapMarker marker);
    MapMarker addMarker(String title, LatLon position);
    MapMarker addMarker(String title, LatLon position, boolean visible);

    void moveCamera(LatLon position);
    void moveCamera(MapMarker marker);
    void moveCamera(LatLon position, int zoom);
    void moveCamera(MapMarker marker, int zoom);
    void moveCamera(LatLon position, boolean animation);
    void moveCamera(LatLon position, int zoom, boolean animation);
    void moveCamera(MapMarker marker, int zoom, boolean animation);

}
