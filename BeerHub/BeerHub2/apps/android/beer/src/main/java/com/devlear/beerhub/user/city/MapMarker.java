package com.devlear.beerhub.user.city;

import com.devlear.beerhub.model.poi.PoiObject;

/**
 * @author Mikhail.Malakhov
 */
class MapMarker<M> {

    private M mMarker = null;
    private PoiObject mPoi;

    public MapMarker(M marker, PoiObject poi) {
        mMarker = marker;
        mPoi = poi;
    }

}
