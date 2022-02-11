/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.model.city;

import com.devlear.app.beerhub.data.DBContract;
import com.devlear.app.beerhub.model.poi.PoiObject;
import com.devlear.app.beerhub.model.poi.PoiType;

/**
 * Class represents the City as data set from a database.
 * @author Mikhail.Malakhov
 * */
public class CityObject extends PoiObject {

    public CityObject() {
        super(PoiType.CITY);
    }

    /**
     * @return The country of this city.
     * */
    public String getCountry() {
        return getString(DBContract.ViewCity.COLUMN_COUNTRY);
    }

}