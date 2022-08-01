/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.model;

import android.text.TextUtils;

import com.devlear.app.beerhub.util.StrUtils;

import java.util.Locale;

/**
 * Since in different map system/different API we may have a different structures to store
 * location data, we want to have our own to bring everything to a common denominator.
 * @author Mikhail.Malakhov
 */
@SuppressWarnings({"unused", "WeakerAccess"})
public final class LatLon {

    /** The minimal valid latitude value. */
    private static final double MIN_LATITUDE = -90.0D;

    /** The maximal valid latitude value. */
    private static final double MAX_LATITUDE = 90.0D;

    /** The minimal valid longitude value. */
    private static final double MIN_LONGITUDE = -180.0D;

    /** The maximal valid longitude value. */
    private static final double MAX_LONGITUDE = 180.0D;

    /**
     * The delimiter that using to convert location data to/from string.
     * <p><b>Attention!</b> Please keep it sync with location format into database.</p>
     * */
    private static final String LOCATION_SEPARATOR = StrUtils.CHAR_COMMA;

    /**
     * The format to represent location data as string.
     * */
    private static final String LOCATION_FORMAT;
    static {
        final String formatEntry = "%.7f";
        LOCATION_FORMAT = formatEntry + LOCATION_SEPARATOR + formatEntry;
    }

    /**
     * The location data value (for latitude and/or longitude) when we have no correct values.
     * */
    private static final double WRONG_LOCATION = 512D; // Na GlaZ!

    /**
     * The latitude in WGS84 format (for example 50.0835494).
     * */
    private double mLat;

    /**
     * The longitude in WGS84 format (for example 14.4341414).
     * */
    private double mLon;

    /**
     * Construct a new {@link LatLon} instance with default parameters.
     * @see #hasLat()
     * @see #hasLon()
     * */
    public LatLon() {
        this(WRONG_LOCATION, WRONG_LOCATION);
    }

    /**
     * Construct a new {@link LatLon} instance with specified parameters.
     * */
    private LatLon(double lat, double lon) {
        mLat = lat; mLon = lon;
    }

    /**
     * Clears data in this object.
     * */
    public void clear() {
        mLat = mLon = WRONG_LOCATION;
    }

    /**
     * @return The latitude of this POI, in degrees.
     * */
    public double getLatitude() { return mLat; }

    /**
     * @return The longitude of this POI, in degrees.
     * */
    public double getLongitude() { return mLon; }

    /**
     * @return True, if this object has no valid location data.
     * */
    public boolean isEmpty() {
        return !(hasLat() && hasLon());
    }

    /**
     * @return True, if this object has valid latitude value.
     * */
    public boolean hasLat() {
        return LatLon.isValidLatitude(getLatitude());
    }

    /**
     * @return True, if this object has valid longitude value.
     * */
    public boolean hasLon() {
        return LatLon.isValidLongitude(getLongitude());
    }

    /**
     * Obtains value from another {@link LatLon} object.
     * */
    public void obtain(LatLon origin) {
        if (origin == null) return;
        mLat = origin.getLatitude();
        mLon = origin.getLongitude();
    }

    /** {@inheritDoc} */
    public String toString() {
        return String.format(Locale.US, LOCATION_FORMAT, getLatitude(), getLongitude());
    }

    /**
     * Retrieves {@link LatLon} from string. Cannot be {@code null}, but can contains wrong data.
     * @see #isEmpty()
     * @see #hasLat()
     * @see #hasLon()
     * */
    public static LatLon fromString(String value) {
        final LatLon obj = new LatLon();

        // Check input value
        if (TextUtils.isEmpty(value) || !value.contains(LOCATION_SEPARATOR)) {
            return obj;
        }
        final String[] splitData = value.split(LOCATION_SEPARATOR, 2);
        if (splitData.length != 2) return obj;

        // Parse location
        double lat, lon;
        try {
            lat = Double.parseDouble(splitData[0]);
            lon = Double.parseDouble(splitData[1]);
        } catch (NumberFormatException e) {
            return obj;
        }
        obj.mLat = lat; obj.mLon = lon;

        return obj;
    }

    /**
     * Checks latitude value.
     * @return True, if specified latitude value is valid, otherwise false.
     * */
    private static boolean isValidLatitude(double value) {
        return value >= MIN_LATITUDE && value <= MAX_LATITUDE;
    }

    /**
     * Checks longitude value.
     * @return True, if specified longitude value is valid, otherwise false.
     * */
    private static boolean isValidLongitude(double value) {
        return value >= MIN_LONGITUDE && value <= MAX_LONGITUDE;
    }
}