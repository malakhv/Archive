package com.devlear.app.beerhub.map;

import com.devlear.app.beerhub.data.RowObject;
import com.devlear.app.beerhub.model.DataActivity;
import com.devlear.app.beerhub.model.LatLon;

/**
 * @author Mikhail.Malakhov
 */
public abstract class MapActivity<D extends RowObject, M> extends DataActivity<D> {

    /** The map object in this activity. */
    private M mMap = null;

    /**
     * @return The current map object in this Activity, or {@code null}.
     * */
    protected M getMap() {
        return mMap;
    }

    /**
     * Sets the map object to this Activity.
     * */
    protected void setMap(M map) {
        mMap = map;
    }

    /**
     * @return True, if this activity has map object and it's ready to use.
     * */
    protected boolean hasMap() {
        return getMap() != null;
    }

    /**
     * Map initialization.
     * */
    protected abstract void initMap();

    /**
     * Moves map camera to specified point.
     * */
    protected void moveCamera(LatLon point) {
        moveCamera(point, false);
    }

    /**
     * Moves map camera to specified point.
     * */
    protected void moveCamera(LatLon point, boolean animation) {
        moveCamera(point, -1, animation);
    }

    /**
     * Moves map camera to specified point with specified zoom level.
     * */
    protected void moveCamera(LatLon point, float zoom, boolean animation) {
        if (point != null) {
            moveCamera(point.getLatitude(), point.getLongitude(), zoom, animation);
        }
    }

    /**
     * Moves map camera to specified point with specified zoom level.
     * */
    protected abstract void moveCamera(double lat, double lon, float zoom, boolean animation);

}
