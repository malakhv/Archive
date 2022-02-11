/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.model;

import android.database.Cursor;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.devlear.beerhub.data.RowObject;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Mikhail.Malakhov
 */
public abstract class DataAdapter<T extends RowObject, V extends DataViewHolder<T>>
        extends RecyclerView.Adapter<V> {

    private List<T> mData = new ArrayList<>();

    private Class<T> clazz = null;

    public DataAdapter(Class<T> itemClass) {
        clazz = itemClass;
    }

    private DataViewHolder.OnItemClickListener mOnItemClickListener = null;

    public void setOnItemClickListener(DataViewHolder.OnItemClickListener l) {
        mOnItemClickListener = l;
    }

    protected void performItemClick(int position, long id) {
        if (mOnItemClickListener != null) mOnItemClickListener.onItemClick(position, id);
    }

    private DataViewHolder.OnItemClickListener mInternalOnItemClickListener =
            new DataViewHolder.OnItemClickListener() {
        @Override
        public void onItemClick(int position, long id) {
            performItemClick(position, id);
        }
    };

    @Override
    public void onBindViewHolder(@NonNull V holder, int position) {
        holder.setOnItemClickListener(mInternalOnItemClickListener);
        holder.obtain(position, getItem(position));
    }

    @Override
    public long getItemId(int position) {
        return mData.get(position).getId();
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public T getItem(int position) {
        return mData.get(position);
    }

    protected void update(Cursor cursor) {
        if (cursor == null) return;
        mData.clear();
        if (!cursor.moveToFirst()) {
            this.notifyDataSetChanged();
            return;
        }
        do {
            final RowObject item = makeItem();
            item.load(cursor);
            onAddDataItem((T) item);
            mData.add((T) item);
        } while (cursor.moveToNext());
        this.notifyDataSetChanged();
    }

    protected void onAddDataItem(T item) {

    }

    protected T makeItem() {
        try {
            return clazz.newInstance();
        } catch (IllegalAccessException | InstantiationException e) {
            return null;
        }
    }
}
