package com.devlear.beerhub.mapengine;

/**
 * @author Mikhail.Malakhov
 */
public interface MapCallbacks {
    void onMapReady(MapEngine engine);
    void onMapFail();
}
