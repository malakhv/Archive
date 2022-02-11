/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.data;

import android.content.ContentValues;
import android.database.Cursor;

import com.devlear.app.beerhub.BeerHubApp;
import com.devlear.app.beerhub.model.poi.PoiType;

import java.util.HashSet;
import java.util.Set;

import static com.devlear.app.beerhub.data.DBContract.TableFavPlace.COLUMN_PLACE_ID;

/**
 * The helper class to manage favorites beer and place.
 * @author Mikhail.Malakhov
 * */
// TODO Need to support favorites beer
public final class FavHelper {

    /** The SQL WHERE statement for select a one element by id. */
    private static final String SQL_WHERE_BY_PLACE_ID = COLUMN_PLACE_ID + "=?";

    /** The instance of this class. */
    private static FavHelper sInstance = null;

    /**
     * Cache to store favorites places.
     * */
    private final Set<Long> mPlaceFav = new HashSet<>();

    /**
     * The external listeners of favorite items change event.
     * @see #addOnFavChangedListener(OnFavChangedListener)
     * @see #removeOnFavChangedListener(OnFavChangedListener)
     * */
    private final Set<OnFavChangedListener> mFavChangedListeners = new HashSet<>();

    /**
     * Clears all cached data in this object.
     * */
    private void clear() {
        mPlaceFav.clear();
    }

    /**
     * Loads data from database
     * */
    private void load() {
        clear();
        final BeerHubDB db = getDatabase();
        final Cursor cursor = db.getReadableCursor(DBContract.TableFavPlace.TABLE_NAME);
        if (!cursor.moveToFirst()) return;
        do {
            int col = cursor.getColumnIndex(DBContract.TableFavPlace.COLUMN_PLACE_ID);
            long id = cursor.getInt(col);
            mPlaceFav.add(id);
        } while (cursor.moveToNext());
    }

    /**
     * @return True, if a place with specified {@code id} is in favorite place list.
     * */
    public static boolean isFavPlace(long id) {
        return sInstance != null && sInstance.mPlaceFav.contains(id);
    }

    /**
     * @return True, if specified {@link RowObject} is in favorite place list.
     * */
    public static boolean isFavPlace(RowObject object) {
        final long id = object != null ? object.getId() : DBContract.NO_ID;
        return isFavPlace(id);
    }

    /**
     * Changes favorite state for place with specified {@code id}.
     * @return True, if place with specified id was added to the favorite place list,
     * otherwise false.
     * */
    public static boolean toggleFavPlace(long id) {
        final boolean fav = isFavPlace(id);
        if (fav) {
            removePlace(id);
        } else {
            addPlace(id);
        }
        return !fav;
    }

    /**
     * Adds place with specified id to the favorite place list.
     * */
    private static void addPlace(long id) {
        if (sInstance == null) return;
        ContentValues v = new ContentValues();
        v.put(DBContract.TableFavPlace.COLUMN_PLACE_ID, id);
        sInstance.getDatabase().getWritableDatabase().insert(
                DBContract.TableFavPlace.TABLE_NAME, null, v);
        sInstance.mPlaceFav.add(id);
        sInstance.performFavChanged(PoiType.PLACE);
    }

    /**
     * Removes place with specified id from the favorite place list.
     * */
    private static void removePlace(long id) {
        if (sInstance == null) return;
        sInstance.getDatabase().getWritableDatabase().delete(
                DBContract.TableFavPlace.TABLE_NAME, SQL_WHERE_BY_PLACE_ID,
                new String[]{String.valueOf(id)});
        sInstance.mPlaceFav.remove(id);
        sInstance.performFavChanged(PoiType.PLACE);
    }

    /**
     * @return The database object to quick access.
     * */
    private BeerHubDB getDatabase() {
        return BeerHubApp.getInstance().getDataBase();
    }

    /**
     * Initialize {@link FavHelper} singleton.
     * */
    static void init() {
        sInstance = new FavHelper();
        sInstance.load();
    }

    /**
     * Registers a listener to receive events of favorite items changed.
     * */
    public static void addOnFavChangedListener(OnFavChangedListener listener) {
        if (listener != null) sInstance.mFavChangedListeners.add(listener);
    }

    /**
     * Unregisters a listener to receive events of favorite items changed.
     * */
    public static void removeOnFavChangedListener(OnFavChangedListener listener) {
        if (listener != null) sInstance.mFavChangedListeners.remove(listener);
    }

    /**
     * Performs OnFavChanged events for external listeners.
     * */
    private void performFavChanged(PoiType type) {
        for (OnFavChangedListener l: mFavChangedListeners) {
            if (l != null) l.OnFavChanged(type);
        }
    }

    /**
     * Interface definition for a callback to be invoked when favorite items have been changed.
     * */
    public interface OnFavChangedListener {
        /**
         * Callback method to be invoked when favorite items have been changed.
         * */
        void OnFavChanged(PoiType type);
    }
}
