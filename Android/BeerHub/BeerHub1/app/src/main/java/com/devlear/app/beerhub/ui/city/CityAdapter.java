package com.devlear.app.beerhub.ui.city;

import android.annotation.SuppressLint;
import android.database.Cursor;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;

import com.devlear.app.beerhub.BeerHubApp;
import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.data.DBContract;
import com.devlear.app.beerhub.data.LocaleHelper;
import com.devlear.app.beerhub.model.DataAdapter;
import com.devlear.app.beerhub.model.poi.PoiObject;

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
