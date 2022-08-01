package com.devlear.app.beerhub.ui.place;

import android.annotation.SuppressLint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.data.FavHelper;
import com.devlear.app.beerhub.model.RowAdapter;
import com.devlear.app.beerhub.model.place.PlaceList;
import com.devlear.app.beerhub.model.place.PlaceObject;

/**
 * @author Mikhail.Malakhov
 */
public class PlaceAdapter extends RowAdapter<PlaceObject, PlaceList, PlaceViewHolder> {

    private boolean mFavOnly = false;

    public void setFavOnly(boolean favOnly) {
        if (mFavOnly == favOnly) return;
        mFavOnly = favOnly;
        update();
    }

    public boolean isFavOnly() {
        return mFavOnly;
    }

    /** {@inheritDoc} */
    @Override
    protected void updateInternal() {
        super.updateInternal();
        final int size = getItemCount();
        if (size <= 0 || !mFavOnly) return;
        final PlaceList items = getItems();
        PlaceObject poi = null;
        for (int i = size - 1; i >= 0; i--) {
            poi = items.getItem(i);
            if (poi == null) continue;
            if (!FavHelper.isFavPlace(poi)) items.remove(i);
        }
    }

    /**
     * Construct a new {@link RowAdapter} instance with default parameters.
     */
    public PlaceAdapter() {
        super(PlaceList.class);
    }

    public void setCityId(long cityId) {
        getItems().setCityId(cityId);
    }

    @NonNull
    @Override
    @SuppressLint("InflateParams")
    public PlaceViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.place_list_item,
                null);
        return new PlaceViewHolder(v);
    }

}