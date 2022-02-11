package com.devlear.beerhub.user.city;

import android.annotation.SuppressLint;
import android.database.Cursor;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;

import com.devlear.beerhub.BeerHubApp;
import com.devlear.beerhub.R;
import com.devlear.beerhub.data.DBContract;
import com.devlear.beerhub.data.LocaleHelper;
import com.devlear.beerhub.model.DataAdapter;
import com.devlear.beerhub.model.poi.PoiObject;

/**
 * @author Mikhail.Malakhov
 */
public class CityAdapter extends DataAdapter<PoiObject, CityViewHolder> {

    public CityAdapter() {
        super(PoiObject.class);
    }

    @NonNull
    @Override
    @SuppressLint("InflateParams")
    public CityViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.city_list_item,
                null);
        return new CityViewHolder(v);
    }

    public void update() {
        final Cursor cursor = BeerHubApp.getInstance().getDataBase().getReadableCursor(
                DBContract.ViewCity.VIEW_NAME, LocaleHelper.getCurrentLocale());
        if (cursor != null) {
            this.update(cursor);
            cursor.close();
        }
    }
}
