/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.user;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.DefaultItemAnimator;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.devlear.beerhub.R;
import com.devlear.beerhub.data.DBContract;
import com.devlear.beerhub.model.DataActivity;
import com.devlear.beerhub.model.DataViewHolder;
import com.devlear.beerhub.user.city.ActCityMap;
import com.devlear.beerhub.user.city.CityAdapter;
import com.malakhv.app.PermUtils;
import com.malakhv.util.LogCat;

/**
 * The default main activity in this app.
 * @author Mikhail.Malakhov
 * */
public class ActHub extends Activity implements DataViewHolder.OnItemClickListener {

    private static int PERM_LOCATION_REQUEST = 1;

    /** Only one request per user session. */
    boolean mHasPermRequested = false;

    /** The list of available cities. */
    private RecyclerView mList = null;

    /**
     * Initializes all UI component in this activity.
     * */
    private void initUI() {
        mList = this.findViewById(R.id.list);
        mList.setLayoutManager(new GridLayoutManager(this, 3));
        mList.setItemAnimator(new DefaultItemAnimator());
        mList.setHasFixedSize(true);
        CityAdapter adapter = new CityAdapter();
        adapter.setOnItemClickListener(this);
        adapter.update();
        mList.setAdapter(adapter);

        /* mList = this.findViewById(R.id.list);
        mList.setLayoutManager(new LinearLayoutManager(this));
        mList.setItemAnimator(new DefaultItemAnimator());
        mList.setHasFixedSize(true);
        CityCardAdapter adapter = new CityCardAdapter();
        adapter.setOnItemClickListener(this);
        adapter.update();
        mList.setAdapter(adapter); */
    }

    /** {@inheritDoc} */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_hub);
        initUI();
    }

    /** {@inheritDoc} */
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions,
            @NonNull int[] grantResults) {
        if (requestCode != PERM_LOCATION_REQUEST) return;
        // TODO Show toast
        LogCat.w("User not grant app permissions");
    }

    /** {@inheritDoc} */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.act_hub, menu);
        return true;
    }

    /** {@inheritDoc} */
    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        final int id = item != null ? item.getItemId() : 0;

        // The "About" activity
        if (id == R.id.about) {
            startAbout();
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * Starts "About" activity.
     * */
    private void startAbout() {
        final Intent intent = new Intent(this, ActAbout.class);
        this.startActivity(intent);
    }

    /** {@inheritDoc} */
    @Override
    protected void onResume() {
        super.onResume();
        if (!mHasPermRequested) {
            PermUtils.check(this, PERM_LOCATION_REQUEST);
        }
        mHasPermRequested = true;
    }

    /** {@inheritDoc} */
    @Override
    public void onItemClick(int position, long id) {
        this.startActivity(DataActivity.makeLaunchIntent(this, ActCityMap.class,
                DBContract.ViewCity.VIEW_NAME, id));
        /* this.startActivity(DataActivity.makeLaunchIntent(this, ActOsm.class,
                DBContract.ViewCity.VIEW_NAME, id)); */
        /* this.startActivity(DataActivity.makeLaunchIntent(this, TestMapEngineActivity.class,
                DBContract.ViewCity.VIEW_NAME, id)); */
    }
}
