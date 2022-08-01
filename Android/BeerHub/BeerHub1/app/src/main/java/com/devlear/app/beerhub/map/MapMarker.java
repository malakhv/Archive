package com.devlear.app.beerhub.map;

import com.devlear.app.beerhub.model.LatLon;
import com.devlear.app.beerhub.model.poi.PoiObject;

/**
 * @author Mikhail.Malakhov
 */
public class MapMarker {

    private String mTitle = null;
    private LatLon mPosition = new LatLon();
    private boolean mIsVisible = true;

    private MapEngineImpl.MarkerCallbacks mCallbacks;

    private PoiObject mPoi = null;

    /**
     * The original marker on a map.
     * @see #isLinked()
     * */
    private Object mOrigin = null;

    public MapMarker(String title, LatLon position) {
        setTitle(title);
        setPosition(position);
    }

    /**
     * @return True, if this {@link MapMarker} instance has linked to original map marker.
     * */
    public boolean isLinked() {
        return mOrigin != null;
    }

    /**
     * Links this {@link MapMarker} instance to the original marker on a map.
     * */
    /* package */ void link(Object origin) {
        if (origin != null) {
            mOrigin = origin;
        }
    }

    /* package */ void unlink() {
        mOrigin = null;
    }

    public String getTitle() {
        return mTitle;
    }

    public void setTitle(String title) {
        mTitle = title; // Can be null
        performMarkerDataChanged();
    }

    public void setPosition(LatLon position) {
        if (position != null) {
            mPosition.obtain(position);
        } else {
            mPosition.clear();
        }
        performMarkerDataChanged();
    }

    public LatLon getPosition() {
        return mPosition;
    }

    public void setVisibility(boolean visible) {
        mIsVisible = visible;
        performMarkerVisibilityChanged();
    }

    public boolean isVisible() {
        return mIsVisible;
    }

    public void show() {
        setVisibility(true);
    }

    public void hide() {
        setVisibility(false);
    }

    protected void performMarkerDataChanged() {
        if (mCallbacks != null) mCallbacks.onMarkerDataChanged(this);
    }

    protected void performMarkerVisibilityChanged() {
        if (mCallbacks != null) mCallbacks.onMarkerVisibilityChanged(this, isVisible());
    }

    void setMarkerCallbacks(MapEngineImpl.MarkerCallbacks callbacks) {
        mCallbacks = callbacks;
    }

}
