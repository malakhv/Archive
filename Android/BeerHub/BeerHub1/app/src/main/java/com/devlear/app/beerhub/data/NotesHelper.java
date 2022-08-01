package com.devlear.app.beerhub.data;

import android.content.ContentValues;
import android.database.Cursor;

import com.devlear.app.beerhub.BeerHubApp;
import com.devlear.app.beerhub.util.StrUtils;

/**
 * @author Mikhail.Malakhov
 */
public final class NotesHelper {

    private static final String TABLE_NAME = DBContract.TableNotes.TABLE_NAME;

    private static final String COLUMN_PLACE_ID = DBContract.TableNotes.COLUMN_PLACE_ID;

    private static final String COLUMN_TEXT = DBContract.TableNotes.COLUMN_TEXT;

    private long mCityId = DBContract.NO_ID;

    public NotesHelper(long cityId) {

    }

    public void setCityId() {

    }


    public static boolean hasNote(long placeId) {
        return true;
    }

    public static String getNote(long placeId) {
        final Cursor cursor = BeerHubApp.getInstance().getDataBase().getReadableCursor(
                TABLE_NAME, COLUMN_PLACE_ID, placeId);
        if (cursor == null || !cursor.moveToFirst()) return null;
        final RowObject row = new RowObject();
        row.load(cursor);
        cursor.close();
        return row.getString(COLUMN_TEXT);
    }

    /**
     *
     * */
    public static boolean setNote(long placeId, String text) {
        if (StrUtils.isEmpty(text)) return false;
        ContentValues cv = new ContentValues();
        cv.put(COLUMN_TEXT, text);
        final long ret;
        final String note = getNote(placeId); // TODO Need to use "hasNote()"
        if (note == null) {
            cv.put(DBContract.TableNotes.COLUMN_PLACE_ID, placeId);
            ret = BeerHubApp.getInstance().getDataBase().getWritableDatabase().insert(TABLE_NAME,
                    null, cv);
        } else {
            ret = BeerHubApp.getInstance().getDataBase().getWritableDatabase().update(TABLE_NAME, cv,
                    COLUMN_PLACE_ID + " = ?", new String[]{String.valueOf(placeId)});
        }
        return ret > 0;
    }

    private void updateContent() {

    }

}
