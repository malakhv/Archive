/* *
 * Copyright (C) 2020 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub project.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.app;

import androidx.annotation.NonNull;

import com.malakhv.util.LogCat;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

/**
 * The list of app components.
 * @author Mikhail.Malakhov
 * */
public class AppCompList implements Iterable<AppComp> {

    /** The list of registered app components. */
    private final List<AppComp> mComponents = new LinkedList<>();

    /**
     * Registers app component.
     * */
    public void register(AppComp component) {
        if (component != null) mComponents.add(component);
    }

    /**
     * Unregisters app component.
     * */
    public void unregister(AppComp component) {
        if (component != null) mComponents.remove(component);
    }

    /**
     * Generates debug information and prints it to log.
     * */
    public void dump() {
        final int count = mComponents.size();
        LogCat.d("App components count: " + count);
        for (AppComp component: mComponents) {
            if (component == null) continue;
            LogCat.d("=== " + component.getName() + " (" + component.getVersion() + ")");
            component.dump();
        }
    }

    /** {@inheritDoc} */
    @NonNull
    @Override
    public Iterator<AppComp> iterator() {
        return mComponents.iterator();
    }
}
