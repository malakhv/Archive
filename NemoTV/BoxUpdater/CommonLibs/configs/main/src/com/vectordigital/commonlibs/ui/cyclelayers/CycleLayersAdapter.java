package com.vectordigital.commonlibs.ui.cyclelayers;

import android.view.View;
import android.view.ViewGroup;
import android.widget.Adapter;

/**
 * User: a.karmanov
 * Date: 18.07.13
 * Time: 12:55
 */
public interface CycleLayersAdapter extends Adapter {
    public int getLayersCount();

    public int getCount(int layer);

    public Object getItem(int layer, int position);

    public long getItemId(int layer, int position);

    public View getView(int layer, int position, View convertView, ViewGroup parent);
}
