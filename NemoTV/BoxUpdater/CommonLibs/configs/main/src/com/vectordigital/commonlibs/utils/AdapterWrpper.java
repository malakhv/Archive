package com.vectordigital.commonlibs.utils;

import android.database.DataSetObserver;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Adapter;
import android.widget.ListAdapter;
import android.widget.SpinnerAdapter;

/**
 * Created by a.karmanov on 27.06.14.
 */
public class AdapterWrpper implements ListAdapter, SpinnerAdapter {
    protected ListAdapter intListAdapter;
    protected SpinnerAdapter intSpinnerAdapter;
    protected Adapter intAdapter;

    public AdapterWrpper(Adapter wrapped) {
        if (wrapped == null) throw new NullPointerException();
        intAdapter = wrapped;
        if (wrapped instanceof ListAdapter) {
            intListAdapter = (ListAdapter) wrapped;
        }
        if (wrapped instanceof SpinnerAdapter) {
            intListAdapter = (ListAdapter) wrapped;
        }
    }

    @Override
    public boolean isEnabled(int position) {
        if (intListAdapter == null) throw new IllegalArgumentException("Internal adapter not instance of ListAdapter");
        return intListAdapter.isEnabled(position);
    }

    @Override
    public boolean areAllItemsEnabled() {
        if (intListAdapter == null) throw new IllegalArgumentException("Internal adapter not instance of ListAdapter");
        return intListAdapter.areAllItemsEnabled();
    }

    @Override
    public View getDropDownView(int position, View convertView, ViewGroup parent) {
        if (intListAdapter == null) throw new IllegalArgumentException("Internal adapter not instance of SpinnerAdapter");
        return intSpinnerAdapter.getDropDownView(position, convertView, parent);
    }

    @Override
    public void registerDataSetObserver(DataSetObserver observer) {
        intAdapter.registerDataSetObserver(observer);
    }

    @Override
    public void unregisterDataSetObserver(DataSetObserver observer) {
        intAdapter.unregisterDataSetObserver(observer);
    }

    @Override
    public int getCount() {
        return intAdapter.getCount();
    }

    @Override
    public Object getItem(int position) {
        return intAdapter.getItem(position);
    }

    @Override
    public long getItemId(int position) {
        return intAdapter.getItemId(position);
    }

    @Override
    public boolean hasStableIds() {
        return intAdapter.hasStableIds();
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        return intAdapter.getView(position, convertView, parent);
    }

    @Override
    public int getItemViewType(int position) {
        return intAdapter.getItemViewType(position);
    }

    @Override
    public int getViewTypeCount() {
        return intAdapter.getViewTypeCount();
    }

    @Override
    public boolean isEmpty() {
        return intAdapter.isEmpty();
    }
}
