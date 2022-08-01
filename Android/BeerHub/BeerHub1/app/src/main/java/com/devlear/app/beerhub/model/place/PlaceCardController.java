/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.model.place;

import android.text.TextUtils;

import com.devlear.app.beerhub.model.poi.PoiCardController;
import com.devlear.app.beerhub.util.StrUtils;

/**
 * @author Mikhail.Malakhov
 */
public class PlaceCardController extends PoiCardController<PlaceObject> {

    public PlaceCardController() {
        super();
    }

    /** {@inheritDoc} */
    @Override
    protected String prepareLongText(PlaceObject data) {
        // Add address
        final String origin = super.prepareLongText(data);
        final String address = data.getAddress();
        if (!TextUtils.isEmpty(address)) {
            return origin + StrUtils.CHAR_EMPTY_LINE + address;
        } else {
            return origin;
        }
    }
}
