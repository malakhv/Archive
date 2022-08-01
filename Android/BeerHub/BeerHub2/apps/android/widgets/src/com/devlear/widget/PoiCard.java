/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.os.Build;
import android.util.AttributeSet;
import android.view.LayoutInflater;

/**
 * The widget represents some information card with icon, title, summary, additional text block
 * and panel with actions.
 * @author Mikhail.Malakhov
 **/
// InfoCard + CardActions
public class PoiCard extends InfoCard {

    /** The default layout with actions for this view. */
    private static final int DEF_ACTIONS_LAYOUT = R.layout.view_poi_actions;

    private CardActions mPoiActions = null;

    private boolean mShowActions = true;

    /** {@inheritDoc} */
    public PoiCard(Context context) {
        this(context, null);
    }

    /** {@inheritDoc} */
    public PoiCard(Context context, AttributeSet attrs) {
        this(context, attrs, R.attr.infoCardStyle);
    }

    /** {@inheritDoc} */
    public PoiCard(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, R.style.Widget_InfoCard);
    }

    /** {@inheritDoc} */
    public PoiCard(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);

        // Read view attributes
        final TypedArray a = this.getContext().getTheme().obtainStyledAttributes(attrs,
                R.styleable.PoiCard, defStyleAttr, defStyleRes);

        // Stores debugging information about attributes (for layout inspector)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            saveAttributeDataForStyleable(context, R.styleable.PoiCard, attrs, a, defStyleAttr,
                    defStyleRes);
        }

        mShowActions = a.getBoolean(R.styleable.PoiCard_showActions, mShowActions);
        if (mShowActions) {
            initActions();
        }
    }

    /**
     * Initializes this view. This is a first point where we can access to internal views.
     * */
    protected void initActions() {
        final LayoutInflater inflater = LayoutInflater.from(this.getContext());
        inflater.inflate(DEF_ACTIONS_LAYOUT, this, true);
    }

    /** {@inheritDoc} */
    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        mPoiActions = findViewById(R.id.card_actions);
    }

    public void setOnActionListener(CardActions.OnActionListener l) {
        if (mPoiActions != null) {
            mPoiActions.setOnActionListener(l);
        }
    }

    /**
     * Changes visibility state of this view to {@link #VISIBLE}.
     * */
    public void show() {
        this.setVisibility(VISIBLE);
    }

    /**
     * Changes visibility state of this view to {@link #GONE}.
     * */
    public void hide() {
        setVisibility(GONE);
    }

    public void setFavStatus(boolean favOn) {
        if (mPoiActions != null) {
            mPoiActions.setFavStatus(favOn);
        }
    }

}
