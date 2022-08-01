/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.model.poi;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.text.TextUtils;

import com.devlear.beerhub.data.FavHelper;
import com.malakhv.util.StrUtils;

/**
 * Helper class to perform POI actions (default implementation).
 * @author Mikhail.Malakhov
 * */
class PoiActionsImpl implements PoiActions {

    /** The POI object for this actions. */
    private PoiObject mPoi = null;

    /** {@inheritDoc} */
    @Override
    public void setPoi(PoiObject poi) {
        mPoi = poi;
    }

    /** {@inheritDoc} */
    @Override
    public boolean hasPoi() {
        return mPoi != null;
    }

    /** {@inheritDoc} */
    @Override
    public void onMap(Context context) {
        if (hasPoi()) {
            actView(context, mPoi.getGoogle());
        }
    }

    /** {@inheritDoc} */
    @Override
    public void onWeb(Context context) {
        if (hasPoi()) {
            actView(context, mPoi.getWeb());
        }
    }

    /** {@inheritDoc} */
    @Override
    public void onShare(Context context) {
        share(context, mPoi);
    }

    /** {@inheritDoc} */
    @Override
    public void onCall(Context context) {
        if (!hasPoi()) return;
        final String phone = mPoi.getPhone();
        if (!TextUtils.isEmpty(phone)) {
            final Intent intent = new Intent(Intent.ACTION_DIAL);
            intent.setData(Uri.parse("tel:" + phone));
            if (intent.resolveActivity(context.getPackageManager()) != null) {
                context.startActivity(intent);
            }
        }
    }

    /** {@inheritDoc} */
    @Override
    public void onFav() {
        if (hasPoi()) {
            FavHelper.toggleFavPlace(mPoi.getId());
        }
    }

    /** {@inheritDoc} */
    @Override
    public void onWiki(Context context) {
        if (hasPoi()) {
            actView(context, mPoi.getWiki());
        }
    }

    /**
     * Shares POI data to another apps.
     * */
    private static void share(Context context, PoiObject poi) {
        if (context == null || poi == null) return;
        final Intent sendIntent = new Intent();
        sendIntent.setAction(Intent.ACTION_SEND);
        final String data = makeSharingData(poi);
        sendIntent.putExtra(Intent.EXTRA_TEXT, data);
        sendIntent.setType("text/plain");
        final Intent shareIntent = Intent.createChooser(sendIntent, null);
        context.startActivity(shareIntent);
    }

    private static String makeSharingData(PoiObject poi) {
        /* return poi.getName() + StrUtils.CHAR_NEW_LINE + poi.getAddress()
                + StrUtils.CHAR_NEW_LINE
                + "https://beerhub.app/?id=" + poi.getId(); */

        return poi.getName() + StrUtils.CHAR_NEW_LINE + poi.getAddress()
                + StrUtils.CHAR_NEW_LINE
                + "https://beerhub.app/place/" + poi.getId();

        /* return poi.getName() + StrUtils.CHAR_NEW_LINE + poi.getAddress()
                + StrUtils.CHAR_NEW_LINE
                + "beerhub://place/" + poi.getId(); */
    }

    /**
     * Performs {@link Intent#ACTION_VIEW} for specified {@code uri}.
     * */
    private static void actView(Context context, String uri) {
        if (context == null || TextUtils.isEmpty(uri)) return;
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse(uri));
        if (intent.resolveActivity(context.getPackageManager()) != null) {
            context.startActivity(intent);
        }
    }
}