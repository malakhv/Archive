/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.data;

import android.database.Cursor;

import com.devlear.app.beerhub.BeerHubApp;
import com.devlear.app.beerhub.data.RowObject;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * The abstract class represents the list of rows in database table.
 * @see RowObject
 * @author Mikhail.Malakhov
 * */
public abstract class RowList<E extends RowObject> implements Iterable<E> {

    /**
     * The collection of items into this object. By default, we user {@link ArrayList}, but
     * child class can change it in {@link #makeItems(int)}.
     * @see #makeItems(int)
     * */
    private final List<E> mItems;

    /**
     * The class for item of this list. This will used to construct an item.
     * */
    private final Class<E> mItemClass;

    public RowList(Class<E> itemClass) {
        this(itemClass, 0);
    }

    public RowList(Class<E> itemClass, int capacity) {
        mItems = makeItems(capacity);
        mItemClass = itemClass;
    }

    /**
     * Makes a collection of items for this object.
     * @param capacity The initial capacity of the collection, or 0, for default capacity.
     * */
    protected List<E> makeItems(int capacity) {
        if (capacity > 0) {
            return new ArrayList<>(capacity);
        } else {
            return new ArrayList<>();
        }
    }

    /**
     * Loads data to this list from database.
     * */
    protected void load(String table, String locale, String sel, String[] selArgs, int max) {
        final Cursor cursor = BeerHubApp.getInstance().getDataBase().getReadableCursor(
                table, locale, sel, selArgs);
        mItems.clear();
        if (cursor == null || !cursor.moveToFirst()) return;
        if (max <= 0) max = Integer.MAX_VALUE;
        do {
            final E item = makeItem();
            item.load(cursor);
            if (onItemAdd(item)) mItems.add(item);
        } while (cursor.moveToNext() && --max > 0);
        cursor.close();
    }

    /**
     * Loads data to this list from database.
     * */
    protected void load(String table, String locale, String sel, String[] selArgs) {
        load(table, locale, sel, selArgs, 0);
    }

    /**
     * Loads data to this list from database.
     * */
    protected void load(String table, String locale, int max) {
        load(table, locale, null, null, max);
    }

    /**
     * Loads data to this list from database.
     * */
    protected void load(String table, String locale) {
        load(table, locale, null, null);
    }

    /**
     * Makes the item instance for this list.
     * */
    protected E makeItem() {
        try {
            return mItemClass.newInstance();
        } catch (IllegalAccessException | InstantiationException e) {
            return null;
        }
    }

    /**
     * @return The element at the specified index (position) in this list.
     * */
    public E getItem(int index) {
        return mItems.get(index);
    }

    /**
     * Called before an {@code item} will be added to this list. This method can used to manage
     * adding operation during data loading.
     * @return True (by default), if you want to have specified item in this list, otherwise false.
     * */
    protected boolean onItemAdd(E item) {
        return true;
    }

    /**
     * @return The number of elements in this object (its cardinality).
     * */
    public int size() {
        return mItems.size();
    }

    public void remove(int index) {
        mItems.remove(index);
    }

    /**
     * @return True if this object contains no elements.
     * */
    public boolean isEmpty() {
        return mItems.isEmpty();
    }

    public void update() {

    }

    /** {@inheritDoc} */
    @Override
    public Iterator<E> iterator() {
        return mItems.iterator();
    }

}
