package com.devlear.beerhub.user.city;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;

import com.devlear.beerhub.R;
import com.devlear.beerhub.model.RowAdapter;
import com.devlear.beerhub.model.city.CityList;
import com.devlear.beerhub.model.city.CityObject;

/**
 * @author Mikhail.Malakhov
 */
public class CityCardAdapter extends RowAdapter<CityObject, CityList, CityCardViewHolder> {

    /**
     * Construct a new {@link RowAdapter} instance with default parameters.
     */
    public CityCardAdapter() {
        super(CityList.class);
    }

    /** {@inheritDoc} */
    @Override
    protected void updateInternal() {
        super.updateInternal();
    }

    /** {@inheritDoc} */
    @NonNull
    @Override
    public CityCardViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.city_list_item_card,
                null);
        return new CityCardViewHolder(v);
    }
}
