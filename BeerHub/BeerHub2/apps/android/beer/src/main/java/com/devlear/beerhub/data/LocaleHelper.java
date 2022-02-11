package com.devlear.beerhub.data;

import android.database.Cursor;

import com.devlear.beerhub.BeerHubApp;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * @author Mikhail.Malakhov
 */
public final class LocaleHelper {

    /** The instance of this class. */
    private static LocaleHelper sInstance = null;

    /**
     * The internal data that represent the supported list of locales as a map where key is
     * locale code and value is {@link LocaleObject}.
     * */
    private Map<String, LocaleObject> mData = new HashMap<>();

    private static String DEFAULT_LOCALE = "en_US";

    private static String mCurrentLocale = DEFAULT_LOCALE;

    /**
     * Clears all cached data in this object.
     * */
    private void clear() {
        mData.clear();
    }

    /**
     * Initialize {@link LocaleHelper} singleton.
     * */
    static void init() {
        sInstance = new LocaleHelper();
        sInstance.load();
        // Check that current system locale is available in database
        // TODO Need to check settings here?
        final String locale = getSystemLocale();
        if (sInstance.mData.containsKey(locale)) {
            mCurrentLocale = locale;
        }
    }

    /**
     * Loads data from database
     * */
    private void load() {
        clear();
        final BeerHubDB db = BeerHubApp.getInstance().getDataBase();
        final Cursor cursor = db.getReadableCursor(DBContract.ViewLocale.VIEW_NAME);
        if (!cursor.moveToFirst()) return;
        do {
            final LocaleObject locale = new LocaleObject();
            locale.load(cursor);
            if (locale.hasCode()) {
                mData.put(locale.getCode(), locale);
            }
        } while (cursor.moveToNext());
    }

    /**
     * @return The current system locale.
     * */
    public static String getSystemLocale() {
        // TODO Need to refactoring
        final Locale locale = Locale.getDefault();
        // TODO May be we need use only language ('en', 'ru', etc)?
        return locale.getLanguage() + "_" + locale.getCountry();
    }

    public static String getCurrentLocale() {
        return mCurrentLocale;
    }

    /**
     * Class represents a row in database's table as object with information about locale.
     * */
    public static class LocaleObject extends RowObject {

        public String getCode() {
            return getString(DBContract.TableLocale.COLUMN_CODE);
        }

        public String getName() {
            return getString(DBContract.TableLocale.COLUMN_NAME);
        }

        public boolean hasCode() {
            return hasData(DBContract.TableLocale.COLUMN_CODE);
        }
    }
}