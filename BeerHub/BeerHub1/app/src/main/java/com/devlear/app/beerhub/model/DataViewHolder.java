/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.model;

import android.view.View;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.devlear.app.beerhub.data.RowObject;

/**
 * A ViewHolder describes an item view and metadata about its place within the RecyclerView.
 * @author Mikhail.Malakhov
 * */
public abstract class DataViewHolder<T extends RowObject> extends RecyclerView.ViewHolder {

    /**
     * The position of the item within the adapter's data set. We want to store it to quick
     * access in {@link #mInternalClickListener}.
     * @see #setPosition(int)
     * */
    private int mPosition;

    /**
     * The id of a row object. In general, we receive it from {@link RowObject} in
     * {@link #obtain(RowObject)}.
     * @see RowObject
     * @see #setId(long)
     * @see #obtain(RowObject)
     * @see #obtain(int, RowObject)
     * */
    private long mId;

    /**
     * The listener to process "on item click" event.
     * @see #setOnItemClickListener(OnItemClickListener)
     * */
    private OnItemClickListener mOnItemClickListener = null;

    /**
     * Construct a new {@link DataViewHolder} instance.
     * */
    public DataViewHolder(@NonNull View itemView) {
        super(itemView);
        itemView.setOnClickListener(mInternalClickListener);
    }

    /**
     * Sets a {@link OnItemClickListener} for this object.
     * */
    public void setOnItemClickListener(OnItemClickListener l) {
        mOnItemClickListener = l;
    }

    /**
     * Obtains data from {@link RowObject}.
     * */
    public void obtain(T data) {
        mId = data.getId();
    }

    /**
     * Obtains data from {@link RowObject}.
     * */
    public void obtain(int position, T data) {
        obtain(data);
        setPosition(position);
    }

    /**
     * Sets the current position.
     * */
    public void setPosition(int position) {
        mPosition = position;
    }

    /**
     * Sets the current id.
     * */
    public void setId(long id) {
        mId = id;
    }

    /**
     * Process external {@link OnItemClickListener}.
     * */
    protected void performItemClick(int position, long id) {
        if (mOnItemClickListener != null) mOnItemClickListener.onItemClick(position, id);
    }

    /**
     * Real internal click listener.
     * */
    private View.OnClickListener mInternalClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            performItemClick(mPosition, mId);
        }
    };

    /**
     * Interface definition for a callback to be invoked when an item has been clicked.
     * @author Mikhail.Malakhov
     * */
    public interface OnItemClickListener {

        /**
         * Callback method to be invoked when an item has been clicked.
         * */
        void onItemClick(int position, long id);

    }
}
