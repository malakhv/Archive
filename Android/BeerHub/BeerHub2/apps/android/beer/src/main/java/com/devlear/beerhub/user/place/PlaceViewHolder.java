package com.devlear.beerhub.user.place;

import android.view.View;

import androidx.annotation.NonNull;

import com.devlear.beerhub.R;
import com.devlear.beerhub.model.DataViewHolder;
import com.devlear.beerhub.model.place.PlaceCardController;
import com.devlear.beerhub.model.place.PlaceObject;
import com.devlear.widget.PoiCard;

/**
 * @author Mikhail.Malakhov
 * */
public class PlaceViewHolder extends DataViewHolder<PlaceObject> {

    private final PlaceCardController mCardController;

    /**
     * Construct a new {@link DataViewHolder} instance.
     * */
    public PlaceViewHolder(@NonNull View itemView) {
        super(itemView);
        final PoiCard card = itemView.findViewById(R.id.place_card);
        mCardController = new PlaceCardController();
        mCardController.setCard(card);
    }

    /** {@inheritDoc} */
    @Override
    public void obtain(PlaceObject data) {
        super.obtain(data);
        mCardController.setData(data);
    }
}