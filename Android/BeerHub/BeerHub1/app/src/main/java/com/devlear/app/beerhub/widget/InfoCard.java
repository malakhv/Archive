/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Build;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.devlear.app.beerhub.R;

/**
 * The widget represents some information card with icon, title, summary and additional text block.
 * @author Mikhail.Malakhov
 **/
@SuppressWarnings("unused")
public class InfoCard extends LinearLayout {

    /** The default layout that we want to use in this view. */
    private static final int DEF_LAYOUT = R.layout.view_info_card;

    //------------------------------------------------------------------------------------------
    // Internal views
    //------------------------------------------------------------------------------------------

    /** The internal view: icon. */
    private ImageView mViewIcon = null;

    /** The internal view: title. */
    private TextView mViewTitle = null;

    /** The internal view: summary. */
    private TextView mViewSummary = null;

    /** The internal view: text. */
    private TextView mViewText = null;

    //------------------------------------------------------------------------------------------
    // Configurations/Attributes
    //------------------------------------------------------------------------------------------

    /**
     * The configuration: Internal layout for of this view.
     * */
    private int mInternalLayout = DEF_LAYOUT;

    /**
     * The configuration: Should display text block, or not. It can be changed via
     * xml attribute, {@code true}, by default.
     * */
    private boolean mShowText = true;

    //------------------------------------------------------------------------------------------
    // Constructors and initialization
    //------------------------------------------------------------------------------------------

    /** The data from XML: title. */
    private final String mXmlTitle;

    /** The data from XML: summary. */
    private final String mXmlSummary;

    /** The data from XML: text. */
    private final String mXmlText;

    /**
     * Makes instance of this view with default parameters. This constructor used for create
     * view from code.
     * */
    public InfoCard(Context context) {
        this(context, null);
    }

    /**
     * Makes instance of this view with parameters from xml.
     * */
    public InfoCard(Context context, AttributeSet attrs) {
        this(context, attrs, R.attr.infoCardStyle);
    }

    /**
     * Makes instance of this view with parameters from xml.
     * */
    public InfoCard(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, R.style.Widget_InfoCard);
    }

    /**
     * Makes instance of this view with parameters from xml.
     * */
    public InfoCard(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);

        // Read view attributes
        final TypedArray a = this.getContext().getTheme().obtainStyledAttributes(attrs,
                R.styleable.InfoCard, defStyleAttr, defStyleRes);

        // Stores debugging information about attributes (for layout inspector)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            saveAttributeDataForStyleable(context, R.styleable.InfoCard, attrs, a, defStyleAttr,
                    defStyleRes);
        }

        // Apply custom attributes
        mShowText = a.getBoolean(R.styleable.InfoCard_showText, mShowText);
        mInternalLayout = a.getResourceId(R.styleable.InfoCard_internalLayout, mInternalLayout);

        CharSequence text = a.getText(R.styleable.InfoCard_android_title);
        mXmlTitle = text != null ? text.toString() : null;

        text = a.getText(R.styleable.InfoCard_android_summary);
        mXmlSummary = text != null ? text.toString() : null;

        text = a.getText(R.styleable.InfoCard_android_text);
        mXmlText = text != null ? text.toString() : null;

        a.recycle();

        // Initialize/inflate this view
        initView();
    }

    /**
     * Initializes this view. This is a first point where we can access to internal views.
     * */
    protected void initView() {
        final LayoutInflater inflater = LayoutInflater.from(this.getContext());
        inflater.inflate(mInternalLayout, this, true);
    }

    /** {@inheritDoc} */
    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        mViewIcon = findViewById(R.id.info_card_icon);
        mViewTitle = findViewById(R.id.info_card_title);
        mViewSummary = findViewById(R.id.info_card_summary);
        mViewText = findViewById(R.id.info_card_text);
        InfoCard.setVisible(mViewText, mShowText);

        setTitle(mXmlTitle);
        setSummary(mXmlSummary);
        setText(mXmlText);
    }

    //------------------------------------------------------------------------------------------
    // Setters for internal fields
    //------------------------------------------------------------------------------------------

    /**
     * Sets the title text to be displayed in this view.
     * */
    public void setTitle(String title) {
        InfoCard.applyTextToView(mViewTitle, title);
    }

    /**
     * Sets the title text to be displayed in this view.
     * */
    public void setTitle(int resId) {
        applyTextToView(mViewTitle, resId);
    }

    /**
     * Sets the summary text to be displayed in this view.
     * */
    public void setSummary(String summary) {
        InfoCard.applyTextToView(mViewSummary, summary);
    }

    /**
     * Sets the summary text to be displayed in this view.
     * */
    public void setSummary(int resId) {
        applyTextToView(mViewSummary, resId);
    }

    /**
     * Sets the text to be displayed in this view.
     * */
    public void setText(String text) {
        if (mShowText) {
            InfoCard.applyTextToView(mViewText, text);
        } else {
            // In this case, we don't want to change view visibility
            mViewText.setText(text);
        }
    }

    /**
     * Sets the text to be displayed in this view.
     * */
    public void setText(int resId) {
        if (mShowText) {
            applyTextToView(mViewText, resId);
        } else {
            // In this case, we don't want to change view visibility
            mViewText.setText(resId);
        }
    }

    /**
     * Sets the icon to be displayed in this view.
     * */
    public void setIcon(Uri uri) {
        mViewIcon.setImageURI(uri);
        InfoCard.setVisible(mViewIcon, uri != null);
    }

    /**
     * Sets the icon to be displayed in this view.
     * */
    public void setIcon(int resId) {
        mViewIcon.setImageResource(resId);
    }

    /**
     * Sets the icon to be displayed in this view.
     * */
    public void setIcon(Drawable drawable) {
        mViewIcon.setImageDrawable(drawable);
    }

    //------------------------------------------------------------------------------------------
    // Some utils
    //------------------------------------------------------------------------------------------

    /** Just check text. */
    protected boolean isEmpty(String text) {
        return TextUtils.isEmpty(text);
    }

    /**
     * Apply specified text to view.
     * */
    private void applyTextToView(TextView view, int resId) {
        final String value = loadText(resId);
        InfoCard.applyTextToView(view, value);
    }

    /**
     * Loads text from resources.
     * */
    protected String loadText(int resId) {
        return getContext().getResources().getText(resId).toString();
    }

    /**
     * Apply specified text to view and hide view, if text empty.
     * */
    public static void applyTextToView(TextView view, String text) {
        view.setText(text);
        setVisible(view, !TextUtils.isEmpty(text));
    }

    /**
     * Sets visible state to specified view.
     * */
    public static void setVisible(View view, boolean visible) {
        view.setVisibility(visible ? VISIBLE : GONE);
    }
}
