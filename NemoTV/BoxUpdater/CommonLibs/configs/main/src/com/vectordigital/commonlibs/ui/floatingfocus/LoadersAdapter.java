package com.vectordigital.commonlibs.ui.floatingfocus;

import android.database.DataSetObserver;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Adapter;

import com.vectordigital.commonlibs.utils.AdapterWrpper;

/**
* Created by a.karmanov on 27.06.14.
*/
class LoadersAdapter extends AdapterWrpper {

    private boolean headerLoaderEnabled;
    private boolean footerLoaderEnabled;
    private View headerLoader;
    private View footerLoader;
    private DataSetObserver observer;

    public LoadersAdapter(Adapter wrapped, View headerLoader, View footerLoader) {
        super(wrapped);
        this.headerLoader = headerLoader;
        this.footerLoader = footerLoader;
    }


    public void setHeaderLoaderEnabled(boolean headerLoaderEnabled) {
        this.headerLoaderEnabled = headerLoaderEnabled;
        if (observer != null) {
            observer.onChanged();
        }
    }

    public void setFooterLoaderEnabled(boolean footerLoaderEnabled) {
        this.footerLoaderEnabled = footerLoaderEnabled;
        if (observer != null) {
            observer.onChanged();
        }
    }

    public void setHeaderLoader(View headerLoader) {
        this.headerLoader = headerLoader;
        if (headerLoaderEnabled && observer != null) {
            observer.onChanged();
        }
    }

    public void setFooterLoader(View footerLoader) {
        this.footerLoader = footerLoader;
        if (footerLoaderEnabled && observer != null) {
            observer.onChanged();
        }
    }

    @Override
    public int getCount() {
        int result = super.getCount();
        if (headerLoaderEnabled && footerLoaderEnabled && result == 0) {
            return 1;
        }
        if (headerLoaderEnabled) result++;
        if (footerLoaderEnabled) result++;
        return result;
    }

    @Override
    public boolean isEnabled(int position) {
        if (position == 0 && headerLoaderEnabled) return false;
        if (position == getCount() - 1 && footerLoaderEnabled) return false;
        return super.isEnabled(headerLoaderEnabled?position - 1:position);
    }

    @Override
    public boolean areAllItemsEnabled() {
        return false;
    }

    @Override
    public int getItemViewType(int position) {
        if (position == 0 && headerLoaderEnabled) return Adapter.IGNORE_ITEM_VIEW_TYPE;
        if (position == getCount() - 1 && footerLoaderEnabled) return Adapter.IGNORE_ITEM_VIEW_TYPE;
        return super.getItemViewType(headerLoaderEnabled?position - 1:position);
    }

    @Override
    public boolean isEmpty() {
        return false;
    }

    @Override
    public Object getItem(int position) {
        if (position == 0 && headerLoaderEnabled) return null;
        if (position == getCount() - 1 && footerLoaderEnabled) return null;
        return super.getItem(headerLoaderEnabled?position - 1:position);
    }

    @Override
    public long getItemId(int position) {
        if (position == 0 && headerLoaderEnabled) return Long.MIN_VALUE;
        if (position == getCount() - 1 && footerLoaderEnabled) return Long.MAX_VALUE;
        return super.getItemId(headerLoaderEnabled?position - 1:position);
    }

    @Override
    public void registerDataSetObserver(DataSetObserver observer) {
        super.registerDataSetObserver(observer);
        this.observer = observer;
    }

    @Override
    public void unregisterDataSetObserver(DataSetObserver observer) {
        super.unregisterDataSetObserver(observer);
        if (this.observer == observer) {
            this.observer = null;
        }
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (position == 0 && headerLoaderEnabled) return headerLoader;
        if (position == getCount() - 1 && footerLoaderEnabled) return footerLoader;
        return super.getView(headerLoaderEnabled?position - 1:position, convertView, parent);
    }
}
