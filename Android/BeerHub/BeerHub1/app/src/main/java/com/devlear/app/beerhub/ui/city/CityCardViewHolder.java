package com.devlear.app.beerhub.ui.city;

import android.net.Uri;
import android.view.View;

import androidx.annotation.NonNull;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.model.DataViewHolder;
import com.devlear.app.beerhub.model.city.CityObject;
import com.devlear.app.beerhub.model.poi.PoiHelper;
import com.devlear.app.beerhub.widget.InfoCard;

import java.io.File;

/**
 * @author Mikhail.Malakhov
 */
class CityCardViewHolder extends DataViewHolder<CityObject> {

    private InfoCard mInfoCard = null;

    /**
     * Construct a new {@link DataViewHolder} instance.
     * */
    public CityCardViewHolder(@NonNull View itemView) {
        super(itemView);
        mInfoCard = itemView.findViewById(R.id.city_card);
    }

    /** {@inheritDoc} */
    @Override
    public void obtain(CityObject data) {
        super.obtain(data);
        mInfoCard.setTitle(data.getName());
        mInfoCard.setSummary(data.getCountry());

        File icon = new File(PoiHelper.getCityIconPath(data.getId()));
        if (icon.exists() && icon.canRead()) {
            mInfoCard.setIcon(Uri.fromFile(icon));
        } else {
            mInfoCard.setIcon(R.drawable.ic_no_logo);
        }

    }
}
