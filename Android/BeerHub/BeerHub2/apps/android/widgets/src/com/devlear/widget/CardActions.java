/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub project.
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
import android.view.View;
import android.widget.ImageButton;
import android.widget.LinearLayout;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Mikhail.Malakhov
 */
public class CardActions extends LinearLayout {

    /** The default layout that we want to use in this view. */
    private static final int DEF_LAYOUT = R.layout.view_card_actions;

    //------------------------------------------------------------------------------------------
    // Actions
    //------------------------------------------------------------------------------------------

    /** The action: Add to favorite list or remove from them. */
    public static final int ACTION_FAV = 1;

    /** The action: Open external map app. */
    public static final int ACTION_MAP = 2;

    /** The action: Open related web site. */
    public static final int ACTION_WEB = 4;

    /** The action: Open related wiki page. */
    public static final int ACTION_WIKI = 8;

    /** The action: Share information. */
    public static final int ACTION_SHARE = 16;

    /** The action: Call the related phone number. */
    public static final int ACTION_CALL = 32;
    
    /** The action: Create or open a note. */
    public static final int ACTION_NOTE = 64;

    /** The action: More info about object. */
    public static final int ACTION_MORE = 1024;

    /**
     * The default available actions.
     * */
    private int mActions = ACTION_FAV | ACTION_MAP | ACTION_WEB | ACTION_SHARE;

    /** The internal map between views and their actions. */
    private static final Map<Integer, Integer> mActionsMap = new HashMap<Integer, Integer>();
    static {
        mActionsMap.put(R.id.card_actions_fav, ACTION_FAV);
        mActionsMap.put(R.id.card_actions_map, ACTION_MAP);
        mActionsMap.put(R.id.card_actions_web, ACTION_WEB);
        mActionsMap.put(R.id.card_actions_wiki, ACTION_WIKI);
        mActionsMap.put(R.id.card_actions_share, ACTION_SHARE);
        mActionsMap.put(R.id.card_actions_call, ACTION_CALL);
        mActionsMap.put(R.id.card_actions_note, ACTION_NOTE);
        mActionsMap.put(R.id.card_actions_more, ACTION_MORE);
    }

    //------------------------------------------------------------------------------------------
    // Internal views
    //------------------------------------------------------------------------------------------

    private ImageButton mViewActFav = null;
    private ImageButton mViewActMap = null;
    private ImageButton mViewActWeb = null;
    private ImageButton mViewActWiki = null;
    private ImageButton mViewActShare = null;
    private ImageButton mViewActCall = null;

    private OnActionListener mActionListener = null;

    private boolean mIsFavInternal = false;


    public CardActions(Context context) {
        this(context, null);
    }

    public CardActions(Context context, AttributeSet attrs) {
        this(context, attrs, R.attr.cardActionsStyle);
    }

    public CardActions(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, R.style.Widget_CardActions);
    }

    public CardActions(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);

        // Read view attributes
        final TypedArray a = this.getContext().getTheme().obtainStyledAttributes(attrs,
                R.styleable.CardActions, defStyleAttr, defStyleRes);

        // Stores debugging information about attributes (for layout inspector)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            saveAttributeDataForStyleable(context, R.styleable.CardActions, attrs, a, defStyleAttr,
                    defStyleRes);
        }

        // Read values from view attributes
        mActions = a.getInt(R.styleable.CardActions_actions, mActions);
        a.recycle();

        initView();
    }

    /** {@inheritDoc} */
    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        mViewActFav = findViewById(R.id.card_actions_fav);
        initActionView(mViewActFav, ACTION_FAV);
        mViewActMap = findViewById(R.id.card_actions_map);
        initActionView(mViewActMap, ACTION_MAP);
        mViewActWeb = findViewById(R.id.card_actions_web);
        initActionView(mViewActWeb, ACTION_WEB);
        mViewActWiki = findViewById(R.id.card_actions_wiki);
        initActionView(mViewActWiki, ACTION_WIKI);
        mViewActShare = findViewById(R.id.card_actions_share);
        initActionView(mViewActShare, ACTION_SHARE);
        mViewActCall = findViewById(R.id.card_actions_call);
        initActionView(mViewActCall, ACTION_CALL);
    }

    protected void initActionView(View view, int action) {
        if (view == null) return;
        view.setOnClickListener(mInternalClickListener);
        setVisible(view, hasAction(action));
    }

    /**
     * Initializes this view. This is a first point where we can access to internal views.
     * */
    protected void initView() {
        final LayoutInflater inflater = LayoutInflater.from(this.getContext());
        inflater.inflate(DEF_LAYOUT, this, true);
    }

    protected void updateFavStatus() {
        if (mViewActFav == null) return;
        mViewActFav.setImageResource(mIsFavInternal
                ? R.drawable.ic_act_fav_on : R.drawable.ic_act_fav_off);
    }

    private final OnClickListener mInternalClickListener = new OnClickListener() {
        @Override
        public void onClick(View v) {
            int id = v != null ? v.getId() : 0;
            Integer act = mActionsMap.get(id);
            if (act != null) {
                performAction(act);
            }
        }
    };

    public boolean hasAction(int action) {
        return (mActions & action) > 0;
    }

    public void setFavStatus(boolean favOn) {
        mIsFavInternal = favOn;
        updateFavStatus();
    }

    void performAction(int action) {
        if (mActionListener != null) mActionListener.onAction(action);
    }

    /**
     * Sets visible state to specified view.
     * */
    public static void setVisible(View view, boolean visible) {
        view.setVisibility(visible ? VISIBLE : GONE);
    }

    public void setOnActionListener(OnActionListener l) {
        mActionListener = l;
    }

    /**
     * Interface definition for a callback to be invoked when an action is performed.
     */
    public interface OnActionListener {
        /**
         * Called when an action has been performed.
         * @param action The action that was performed.
         * */
        void onAction(int action);
    }

}
