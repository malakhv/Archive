package com.devlear.beerhub.model.place;

import com.devlear.beerhub.data.DBContract;
import com.devlear.beerhub.model.poi.PoiObject;
import com.devlear.beerhub.model.poi.PoiType;

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
