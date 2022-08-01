package com.devlear.app.beerhub.ui.city;

import android.net.Uri;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.data.DBContract;
import com.devlear.app.beerhub.model.DataViewHolder;
import com.devlear.app.beerhub.model.poi.PoiHelper;
import com.devlear.app.beerhub.model.poi.PoiObject;

import java.io.File;

/**
 * @author Mikhail.Malakhov
 */
public class CityViewHolder extends DataViewHolder<PoiObject> {

    private TextView mViewName = null;
    private TextView mViewCountry = null;
    private ImageView mViewLogo = null;

    public CityViewHolder(@NonNull View itemView) {
        super(itemView);
        mViewLogo = itemView.findViewById(R.id.logo);
        mViewName = itemView.findViewById(R.id.name);
        mViewCountry = itemView.findViewById(R.id.country);
    }

    public void setName(String name) {
        mViewName.setText(name);
    }

    public void setCountry(String country) {
        mViewCountry.setText(country);
    }

    @Override
    public void obtain(PoiObject data) {
        super.obtain(data);
        setName(data.getName());
        setCountry(data.getString(DBContract.ViewCity.COLUMN_COUNTRY));

        File icon = new File(PoiHelper.getCityIconPath(data.getId()));
        if (icon.exists() && icon.canRead()) {
            mViewLogo.setImageURI(Uri.fromFile(icon));
        } else {
            mViewLogo.setImageResource(R.drawable.city_no_icon);
        }

    }

}
