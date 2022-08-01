package com.devlear.beerhub.mapengine;

import com.devlear.beerhub.map.MapMarker;
import com.devlear.beerhub.model.LatLon;

import java.util.HashSet;
import java.util.Set;

/**
 * The base implementation of {@link MapEngine}.
 * @author Mikhail.Malakhov
 * */
abstract class AbstractMapEngine<M> implements MapEngine {

    /** The real map object. */
    protected M mMap = null;

    /** The real map configuration. */
    private final MapConfig mConfig;

    /** The raw set of map markers. */
    private final Set<MapMarker> mMarkers = new HashSet<>();

    /** The callbacks to track real map state. */
    protected MapCallbacks mMapCallbacks = null;

    /**
     * Construct a new {@link AbstractMapEngine} instance with specified parameters.
     * */
    /* package */ AbstractMapEngine(MapConfig config) {
        mConfig = config;
    }

    /** {@inheritDoc} */
    @Override
    public boolean hasMap() {
        return mMap != null;
    }

    public M getMap() {
        return mMap;
    }

    /** {@inheritDoc} */
    @Override
    public boolean addMarker(MapMarker marker) {
        return false;
    }

    /** {@inheritDoc} */
    @Override
    public MapMarker addMarker(String title, LatLon position) {
        return null;
    }

    /** {@inheritDoc} */
    @Override
    public MapMarker addMarker(String title, LatLon position, boolean visible) {
        return null;
    }

    /** {@inheritDoc} */
    @Override
    public void removeMarker(MapMarker marker) {

    }

    /** {@inheritDoc} */
    @Override
    public void updateMarker(MapMarker marker) {

    }

    /** {@inheritDoc} */
    @Override
    public boolean hasMarker(MapMarker marker) {
        return marker != null && mMarkers.contains(marker);
    }

    /** {@inheritDoc} */
    @Override
    public void clear() {
        // TODO need to remove each marker from real map and clear set
        mMarkers.clear();
    }

    /** {@inheritDoc} */
    @Override
    public void hideAll() {
        //TODO May be for mass operation we want to disable callbacks? And update whole map after
        //TODO operation?
        for (MapMarker marker: mMarkers) {
            marker.hide();
        }
    }

    /** {@inheritDoc} */
    @Override
    public void showAll() {
        for (MapMarker marker: mMarkers) {
            marker.show();
        }
    }

    /** {@inheritDoc} */
    @Override
    public void moveCamera(MapMarker marker) {
        // We want move camera to only linked marker (marker that exists on real map)
        if (marker != null && marker.isLinked()) moveCamera(marker.getPosition());
    }

    /** {@inheritDoc} */
    @Override
    public void moveCamera(MapMarker marker, int zoom) {
        // We want move camera to only linked marker (marker that exists on real map)
        if (marker != null && marker.isLinked()) moveCamera(marker.getPosition(), zoom);
    }

    /** {@inheritDoc} */
    @Override
    public void moveCamera(LatLon position, boolean animation) {

    }

    /** {@inheritDoc} */
    @Override
    public void moveCamera(MapMarker marker, int zoom, boolean animation) {
        // We want move camera to only linked marker (marker that exists on real map)
        if (marker != null && marker.isLinked()) moveCamera(marker.getPosition(),
                zoom, animation);
    }

    /** {@inheritDoc} */
    @Override
    public void initMap(MapCallbacks callbacks) {
        mMapCallbacks = callbacks;
    }

    /** {@inheritDoc} */
    @Override
    public float getZoomLevelMe() {
        return mConfig.getFloat(MapConfig.KEY_ZOOM_LEVEL_ME, 0);
    }

    /** {@inheritDoc} */
    @Override
    public float getZoomLevelCity() {
        return 0;
    }

    /** {@inheritDoc} */
    @Override
    public float getZoomLevelCountry() {
        return 0;
    }

    /** {@inheritDoc} */
    @Override
    public float getZoomLevelOff() {
        return 0;
    }

    /* Working with real map markers */
    protected abstract Object addRawMarker(MapMarker marker);
    protected abstract void removeRawMarker(MapMarker marker);
    protected abstract void updateRawMarker(MapMarker marker);

    /***/
    protected void performMapReady() {
        if (mMapCallbacks != null && hasMap()) {
            mMapCallbacks.onMapReady(this);
        }
    }

}
