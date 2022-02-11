/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.app;

/**
 * The interface describes some common methods for each app component.
 * @author Mikhail.Malakhov
 * */
public interface AppComponent {

    /**
     * Gets the name of app component.
     * @return The name of app component.
     * */
    String getName();

    /**
     * Gets the version of app component.
     * @return The version of app component, or {@code null}.
     * */
    String getVersion();

    /**
     * Checks this app component has version or not.
     * @return True, if this app component has version, otherwise false.
     * */
    boolean hasVersion();

    /**
     * Prints all debug information to log.
     * */
    void dump();
}