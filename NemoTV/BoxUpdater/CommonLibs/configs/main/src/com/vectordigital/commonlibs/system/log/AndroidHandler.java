/*
 * Copyright (c) 2013.
 * This file is part of Wild Swift Solutions For Android library.
 *
 * Wild Swift Solutions For Android is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * Wild Swift Solutions For Android is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with Android Interface Toolkit.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.vectordigital.commonlibs.system.log;

import android.util.Log;
import android.view.ScaleGestureDetector;

import java.util.logging.Formatter;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.LogRecord;

/**
 * Wild Swift
 * Android Libraries
 *
 * @author Wild Swift
 */
public class AndroidHandler extends Handler {
    /**
     * Holds the formatter for all Android log handlers.
     */
    private static final Formatter formatter = new Formatter() {
        @Override
        public String format(LogRecord logRecord) {
            return logRecord.getMessage();
        }
    };

    private volatile boolean gotSettings = false;
    private volatile boolean logThreadName = false;

    /**
     * Constructs a new instance of the Android log handler.
     */
    public AndroidHandler() {
        setFormatter(formatter);
    }

    @Override
    public void close() {
        // No need to close, but must implement abstract method.
    }

    @Override
    public void flush() {
        // No need to flush, but must implement abstract method.
    }

    private void readSettings(){
        LogManager manager = LogManager.getLogManager();
        if(manager != null){
            logThreadName = "true".equals(manager.getProperty(getClass().getName()+".logThreadName"));
        }
    }

    @Override
    public void publish(LogRecord record) {
        try {
            if(!gotSettings){
                gotSettings = true;
                readSettings();
            }
            int level = getAndroidLevel(record.getLevel());
            String tag = record.getLoggerName();

            if (tag == null) {
                // Anonymous logger.
                tag = "null";
            } else {
                // Tags must be <= 23 characters.
                int length = tag.length();
                // Most loggers use the full class name. Try dropping the
                // package.
                int lastPeriod = tag.lastIndexOf(".");
                if (length - lastPeriod - 1 <= 23) {
                    tag = tag.substring(lastPeriod + 1);
                } else {
                    // Use last 23 chars.
                    tag = tag.substring(tag.length() - 23);
                }
            }

            String message = getFormatter().format(record);
            Log.println(level, tag, (logThreadName?Thread.currentThread().getName()+" ":"")+message);
        } catch (RuntimeException e) {
            Log.e("AndroidHandler", "Error logging message.", e);
        }
    }

    private static int getAndroidLevel(Level level) {
        int value = level.intValue();
        if (value >= 1000) { // SEVERE
            return Log.ERROR;
        } else if (value >= 900) { // WARNING
            return Log.WARN;
        } else if (value >= 800) { // INFO
            return Log.INFO;
        } else if (value >= 700) { // CONFIG
            return Log.DEBUG;
        } else {
            return Log.VERBOSE;
        }
    }

}

