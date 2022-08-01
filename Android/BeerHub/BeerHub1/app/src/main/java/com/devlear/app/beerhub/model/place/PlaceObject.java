package com.devlear.app.beerhub.model.place;

import com.devlear.app.beerhub.data.DBContract;
import com.devlear.app.beerhub.model.poi.PoiObject;
import com.devlear.app.beerhub.model.poi.PoiType;

/**
 * @author Mikhail.Malakhov
 */
public class PlaceObject extends PoiObject {

    public PlaceObject() {
        super(PoiType.PLACE);
    }

    /**
     * @return The phone number of this place.
     * */
    public String getPhone() {
        return getString(DBContract.TablePlace.COLUMN_PHONE);
    }

    /**
     * @return The information about beer in this place.
     * */
    public String getBeer() {
        return getString(DBContract.ViewPlace.COLUMN_COMMENTS);
    }

}
