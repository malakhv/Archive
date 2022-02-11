package com.devlear.beerhub.model.place;

import com.devlear.beerhub.data.DBContract;
import com.devlear.beerhub.data.LocaleHelper;
import com.devlear.beerhub.model.poi.PoiList;
import com.devlear.beerhub.model.poi.PoiType;

/**
 * @author Mikhail.Malakhov
 */
public class PlaceList extends PoiList<PlaceObject> {

    private long mCityId = DBContract.NO_ID;

    public PlaceList() {
        super(PlaceObject.class);
    }

    public void load(long cityId, String locale, int max) {
        this.load(PoiType.PLACE.getTable(), locale,
                DBContract.ViewPlace.COLUMN_CITY_ID + " = ?",
                new String[] {String.valueOf(cityId)});
    }

    public void setCityId(long cityId) {
        mCityId = cityId;
    }

    @Override
    public void update() {
        load(mCityId, LocaleHelper.getCurrentLocale(), 0);
    }
}
