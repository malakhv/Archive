package com.devlear.app.beerhub.ui.city;

import com.devlear.app.beerhub.model.poi.PoiObject;

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
