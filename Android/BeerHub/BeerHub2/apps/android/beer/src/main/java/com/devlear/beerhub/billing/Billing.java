/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.billing;

import android.content.Context;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.malakhv.util.BuildConfig;

/**
 * Class for management billing and purchases.
 * @author Mikhail.Malakhov
 * */
public class Billing {

    /**
     * The count of places for free version.
     * */
    public static final int FREE_PLACE_COUNT = 5;

    /**
     * Restore all purchases for current user.
     * */
    public static void restorePurchases(Context context) {
        // TODO Need to implement
    }

    /**
     * Checks purchase with specified {@code sku}.
     * @return True, if current user has purchase specified {@code sku}.
     * */
    public static boolean hasPurchase(Context context, String sku) {
        return BuildConfig.DEBUG || true;
    }

    /**
     * @return True, if Google Play Services are available on this device.
     * */
    public static boolean isGooglePlayServicesAvailable(Context context) {
        if (context == null) return false;
        GoogleApiAvailability instance = GoogleApiAvailability.getInstance();
        int responseCode = instance.isGooglePlayServicesAvailable(context);
        return responseCode == ConnectionResult.SUCCESS;
    }
}