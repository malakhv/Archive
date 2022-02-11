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
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.devlear.beerhub.BuildConfig;
import com.devlear.beerhub.R;
import com.malakhv.util.LogCat;

/**
 * The "About" activity in this app.
 * @author Mikhail.Malakhov
 * */
public class ActAbout extends Activity implements View.OnClickListener {

    /** {@inheritDoc} */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_about);
        final TextView version = this.findViewById(R.id.app_version);
        if (version != null) {
            String ver = BuildConfig.VERSION_NAME + " (" + BuildConfig.VERSION_CODE + ")";
            version.setText(ver);
        }
        final View market = this.findViewById(R.id.play_market);
        market.setOnClickListener(this);
        final View beer = this.findViewById(R.id.beer_for_dev);
        beer.setOnClickListener(this);
    }

    /**
     * {@inheritDoc}
     * */
    @Override
    public void onClick(View v) {
        final int id = v != null ? v.getId() : 0;
        if (id == R.id.play_market) {
            toPlayMarket(); return;
        }
        if (id == R.id.beer_for_dev) {
            LogCat.i("Thanks for beer!");
        }
    }

    /**
     * Opens app's page in Google Play Market.
     * */
    private void toPlayMarket() {
        final String app = this.getPackageName();
        final Intent market = new Intent(Intent.ACTION_VIEW, Uri.parse(
                "market://details?id=" + app));
        if (market.resolveActivity(getPackageManager()) != null) {
            this.startActivity(market);
        } else { // Go to web
            final Intent web = new Intent(Intent.ACTION_VIEW,
                    Uri.parse("https://play.google.com/store/apps/details?id=" + app));
            this.startActivity(web);
        }
    }

}