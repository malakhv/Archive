/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.data;

import android.provider.BaseColumns;

import com.devlear.app.beerhub.data.DBSQLite;

/**
 * Class contains information about all tables, views and etc in BeerHub database.
 * @author Mikhail.Malakhov
 * */
@SuppressWarnings({"WeakerAccess","unused"})
public class DBContract {

    /** The default value for row ID, if data doesn't exist. */
    public static final long NO_ID = -1;

    /** The unique identifier of row in database table. */
    public static final String COLUMN_ID = BaseColumns._ID;

    /**
     * The base interface for any table in database which support different localization.
     * */
    public interface LocaleTable {
        /**
         * The localisation of a row object.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_LOCALE = "locale";
    }

    /**
     * The base interface for any table in database which includes location information.
     * */
    public interface LocationTable {

        /**
         * The location of a row object in WGS84 format (for example 50.083698,45.407367).
         * <p>Type: TEXT</p>
         * */
        String COLUMN_LOCATION = "location";

        /**
         * The direct link to a row object on Google map.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_MAP_GOOGLE = "google";

        /**
         * The direct link to a row object on MAPS.ME map.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_MAP_MAPSME = "mapsme";

        /**
         * The direct link to a row object on Mapy.cz map.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_MAP_MAPYCZ = "mapycz";

        /**
         * The direct link to a row object on Yandex map.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_MAP_YANDEX = "yandex";
    }

    /**
     * The base interface for any table in database which includes link to a web-site.
     * */
    public interface WebTable {
        /**
         * The web link to a row object.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_WEB = "web";
    }

    /**
     * The base interface for any table in database which includes link to a Wikipedia.
     * */
    public interface WikiTable {
        /**
         * The Wikipedia link to a row object.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_WIKI = "wiki";
    }

    /**
     * The base interface for any table in database which includes the name of stock
     * keeping unit.
     * */
    public interface SkuTable {
        /**
         * The stock keeping unit.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_SKU = "sku";
    }

    /**
     * The base interface for any table in database which includes contacts information, such
     * as phone, address and etc.
     * */
    public interface ContactsTable {
        /**
         * The phone for contact and/or reservation.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_PHONE = "phone";

        /**
         * The email for contact and/or reservation.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_EMAIL = "email";

        /**
         * The address in regional format.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_ADDRESS = "address";
    }

    /**
     * The base interface for any table in database that represents POI object.
     * */
    public interface PoiTable extends DBSQLite.BaseTable, LocationTable, WebTable, WikiTable {

        /**
         * The name of POI object. The data of this columns can be translated.
         * <p>Type: TEXT</p>
         * */
        // TODO Rename to 'Title'?!
        String COLUMN_NAME = "name";

        /**
         * The information about POI object. The data of this columns can be translated.
         * <p>Type: TEXT</p>
         * */
        //String COLUMN_INFO = "info";

        /**
         * The "enabled" flag. It means enabled POI for user, or not. By default,
         * it's {@code true}.
         * <p>Type: BOOLEAN</p>
         * */
        String COLUMN_ENABLED = "enabled";
    }

    /**
     * The base interface for any table in database that represents POI object.
     * */
    public interface PoiView extends LocaleTable, PoiTable {

        /**
         * The short information about POI object. The data of this columns can be translated.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_ABOUT = "about";

        /**
         * The information about POI object. The data of this columns can be translated.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_INFO = "info";

        /**
         * The original name of POI object (name on native language, for example). This is alias
         * for {@link PoiTable#COLUMN_NAME}.
         * <p>Type: TEXT</p>
         * */
        String COLUMN_ORIGIN_NAME = "origin_name";

        /**
         * The original information about POI object (info on native language, for example). This
         * is alias for {@link PoiTable#COLUMN_INFO}.
         * <p>Type: TEXT</p>
         * */
        //String COLUMN_ORIGIN_INFO = "origin_info";

        /**
         * The any additional comments for POI (The list of the important beers that recommended
         * to try, for example, opening hours and/or etc).
         * <p>Type: TEXT</p>
         * */
        String COLUMN_COMMENTS = "comments";
    }

    //------------------------------------------------------------------------------------------
    // Country
    //------------------------------------------------------------------------------------------

    /**
     * The table contains information about countries.
     * */
    public static class TableCountry implements PoiTable {
        /** The name of this table. */
        public static final String TABLE_NAME = "country";
    }

    /**
     * The view contains information about countries.
     * */
    public static final class ViewCountry extends TableCountry implements PoiView {
        /** The name of this view. */
        public static final String VIEW_NAME = "view_country";
    }

    //------------------------------------------------------------------------------------------
    // City
    //------------------------------------------------------------------------------------------

    /**
     * The table contains information about cities.
     * @author Mikhail.Malakhov
     * */
    public static class TableCity implements PoiTable, SkuTable {

        /** The name of this table. */
        public static final String TABLE_NAME = "city";

        /**
         * The ID of city's country.
         * <p>Type: INTEGER (long)</p>
         * */
        public static final String COLUMN_COUNTRY_ID = "country_id";
    }

    /**
     * The view contains information about cities.
     * @author Mikhail.Malakhov
     * */
    public static final class ViewCity extends TableCity implements PoiView {

        /** The name of this view. */
        public static final String VIEW_NAME = "view_city";

        /**
         * The city's country.
         * <p>Type: TEXT</p>
         * */
        public static final String COLUMN_COUNTRY = "country";
    }

    //------------------------------------------------------------------------------------------
    // Place
    //------------------------------------------------------------------------------------------

    /**
     * The table contains information about places.
     * @author Mikhail.Malakhov
     * */
    public static class TablePlace implements PoiTable, ContactsTable {

        /** The name of this table. */
        public static final String TABLE_NAME = "place";

        /**
         * The city where place is.
         * <p>Type: INTEGER (long)</p>
         * */
        public static final String COLUMN_CITY_ID = "city_id";

        /**
         * The type of place (Pub, Bar, Taproom, Restaurant, etc.).
         * <p>Type: INTEGER (long)</p>
         * */
        public static final String COLUMN_TYPE = "type";

        /**
         * The rating of a beer in this place. This is a publisher rating. A five-point scale is
         * used for evaluation. By default, it's {@code 0}.
         * <p>Type: INTEGER (long)</p>
         * */
        public static final String COLUMN_RATING_BEER = "rating_beer";

        /**
         * The rating of a food in this place. This is a publisher rating. A five-point scale is
         * used for evaluation. By default, it's {@code 0}.
         * <p>Type: INTEGER (long)</p>
         * */
        public static final String COLUMN_RATING_FOOD = "rating_food";

        /**
         * The rating of a service in this place. This is a publisher rating. A five-point scale is
         * used for evaluation. By default, it's {@code 0}.
         * <p>Type: INTEGER (long)</p>
         * */
        public static final String COLUMN_RATING_SERVICE = "rating_service";
    }

    /**
     * The view contains information about places.
     * @author Mikhail.Malakhov
     * */
    public static class ViewPlace extends TablePlace implements PoiView {

        /** The name of this view. */
        public static final String VIEW_NAME = "view_place";

        /**
         * The country where place is.
         * <p>Type: TEXT</p>
         * */
        public static final String COLUMN_COUNTRY = "country";

        /**
         * The city where place is.
         * <p>Type: TEXT</p>
         * */
        public static final String COLUMN_CITY = "city";

    }

    //------------------------------------------------------------------------------------------
    // Brewery
    //------------------------------------------------------------------------------------------

    /**
     * The table contains information about breweries.
     * @author Mikhail.Malakhov
     * */
    public static class TableBrewery implements PoiTable, ContactsTable {

        /** The name of this table. */
        public static final String TABLE_NAME = "brewery";

        /**
         * This is small brewery or not.
         * <p>Type: BOOLEAN</p>
         * */
        public static final String COLUMN_SMALL = "small";
    }

    /**
     * The table contains information about breweries.
     * @author Mikhail.Malakhov
     * */
    public static class ViewBrewery extends TableBrewery implements PoiView {
        /** The name of this view. */
        public static final String VIEW_NAME = "view_brewery";
    }

    //------------------------------------------------------------------------------------------
    // Locale
    //------------------------------------------------------------------------------------------

    /**
     * The special table contains information about supported locales.
     * @author Mikhail.Malakhov
     * */
    public static class TableLocale {

        /** The name of this table. */
        public static final String TABLE_NAME = "locale";

        /**
         * The locale code contains language and country/region code. For example: {@code ru_RU},
         * {@code en_US}, {@code cs_rCZ}. By default we can use only language code in app.
         * */
        public static final String COLUMN_CODE = "code";

        /** The locale name on its language. */
        public static final String COLUMN_NAME = "name";

        /**
         * The "enabled" flag. It means enabled locale for user, or not. By default,
         * it's {@code true}.
         * <p>Type: BOOLEAN</p>
         * */
        public static final String COLUMN_ENABLED = "enabled";

    }

    public static class ViewLocale extends TableLocale {
        /** The name of this view. */
        public static final String VIEW_NAME = "view_locale";
    }

    //------------------------------------------------------------------------------------------
    // Favorites
    //------------------------------------------------------------------------------------------

    /**
     * The list of favorite beer. This table contains end-user data.
     * @author Mikhail.Malakhov
     * */
    public static class TableFavBeer implements DBSQLite.BaseTable {

        /** The name of this table. */
        public static final String TABLE_NAME = "fav_beer";

        /**
         * The id of a beer.
         * <p>Type: INTEGER</p>
         * */
        public static final String COLUMN_BEER_ID = "beer_id";

        /** The SQL expression for creating this table. */
        public static final String SQL_CREATE = "CREATE TABLE " + TABLE_NAME + " ("
                + _ID + " INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, "
                + COLUMN_BEER_ID + " INTEGER NOT NULL)";

    }

    /**
     * The list of favorite places. This table contains end-user data.
     * @author Mikhail.Malakhov
     * */
    public static class TableFavPlace implements DBSQLite.BaseTable {

        /** The name of this table. */
        public static final String TABLE_NAME = "fav_place";

        /**
         * The id of a place.
         * <p>Type: INTEGER</p>
         * */
        public static final String COLUMN_PLACE_ID = "place_id";

        /** The SQL expression for creating this table. */
        public static final String SQL_CREATE = "CREATE TABLE " + TABLE_NAME + " ("
                + _ID + " INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, "
                + COLUMN_PLACE_ID + " INTEGER NOT NULL)";
    }

    //------------------------------------------------------------------------------------------
    // Notes
    //------------------------------------------------------------------------------------------

    public static class TableNotes implements DBSQLite.BaseTable {

        /** The name of this table. */
        public static final String TABLE_NAME = "notes";

        /**
         * The id of a place.
         * <p>Type: INTEGER</p>
         * */
        public static final String COLUMN_PLACE_ID = "place_id";

        /**
         * The text on this note.
         * */
        public static final String COLUMN_TEXT = "text";

        /** The SQL expression for creating this table. */
        public static final String SQL_CREATE = "CREATE TABLE " + TABLE_NAME + " ("
                + _ID + " INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, "
                + COLUMN_PLACE_ID + " INTEGER NOT NULL UNIQUE, "
                + COLUMN_TEXT + " NOT NULL)";
    }

    /** This class has only static data, not need to create instance. */
    private DBContract() { /* Empty */ }
}
