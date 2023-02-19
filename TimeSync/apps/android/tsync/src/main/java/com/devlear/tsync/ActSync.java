/* *
 * Copyright (C) 2022 DevLear - All Rights Reserved.
 *
 * This file is a part of TimeSync project.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.tsync;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.widget.TextClock;

import java.util.Date;
import java.util.Locale;

/**
 * The main activity in this app.
 * @author Mikhail.Malakhov
 * */
public class ActSync extends Activity {

    /** The time value to sync with external watch. */
    private Date mTimeToSync = null;

    /** UI item: Phone time label. */
    private TextClock mTextClock = null;

    /**
     * Initialize UI items.
     * */
    private void initUi() {
        mTextClock = findViewById(R.id.text_clock);
        mTextClock.setFormat24Hour(getDateTimeFormat(true));
        mTextClock.setFormat12Hour(getDateTimeFormat(false));
    }

    /** {@inheritDoc} */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_sync);
        mTimeToSync = new Date();
        // Initialize UI
        initUi();
    }

    private String getDateTimeFormat(boolean is24h) {
        final Locale locale = this.getResources().getConfiguration().locale;
        final int format = is24h ? R.string.time_24h_format : R.string.time_12h_format;
        return DateFormat.getBestDateTimePattern(locale, getString(format));
    }

    private class SyncTask extends AsyncTask<Date, Integer, Void> {

        /** {@inheritDoc} */
        @Override
        protected Void doInBackground(Date... strings) {
            return null;
        }
    }

}
