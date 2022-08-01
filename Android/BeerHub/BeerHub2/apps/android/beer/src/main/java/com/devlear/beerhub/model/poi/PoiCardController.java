package com.devlear.beerhub.model.poi;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.text.TextUtils;

import com.devlear.beerhub.R;
import com.devlear.widget.CardActions;
import com.devlear.widget.PoiCard;
import com.malakhv.util.StrUtils;

import java.io.File;

/**
 * @author Mikhail.Malakhov
 */
public class PoiCardController<T extends PoiObject> {

    private Context mContext;

    private T mData = null;

    private PoiCard mViewPoiCard = null;
    private PoiActions mPoiActions = null;

    /**
     * The current expanded state.
     * */
    private boolean mExpanded = false;


    private CardActions.OnActionListener mActionListener = new CardActions.OnActionListener() {
        @Override
        public void onAction(int action) {
            if (mPoiActions == null) return;
            switch (action) {
                case CardActions.ACTION_FAV: mPoiActions.onFav(); updateFav(); break;
                case CardActions.ACTION_MAP: mPoiActions.onMap(mContext);break;
                case CardActions.ACTION_WEB: mPoiActions.onWeb(mContext); break;
                case CardActions.ACTION_SHARE: mPoiActions.onShare(mContext); break;
                case CardActions.ACTION_CALL: mPoiActions.onCall(mContext); break;
            }
        }
    };

    public PoiCardController() {
        this(null, new PoiActionsImpl());
    }

    public PoiCardController(Context context, PoiActions actions) {
        mPoiActions = actions;
    }

    public void setCard(PoiCard card) {
        mViewPoiCard = card;
        if (mViewPoiCard != null) {
            mContext = mViewPoiCard.getContext();
            mViewPoiCard.setOnActionListener(mActionListener);
        }
    }

    public void setData(T data) {
        mData = data;
        if (mPoiActions != null) {
            mPoiActions.setPoi(data);
        }
        mExpanded = false;
        updateView();
    }

    public T getData() {
        return mData;
    }

    protected void updateView() {
        if (mViewPoiCard == null) return;
        final T data = getData();
        if (data == null) {
            clearView(); return;
        }
        mViewPoiCard.setTitle(data.getName());
        mViewPoiCard.setSummary(mData.getComments());

        File icon = new File(PoiHelper.getPlaceIconPath(mContext, data.getId()));
        if (icon.exists() && icon.canRead()) {
            mViewPoiCard.setIcon(Uri.fromFile(icon));
            //setVisible(mViewIcon, true);
        } else {
            //mViewPoiCard.setIcon((Uri) null);
            mViewPoiCard.setIcon(R.drawable.ic_no_logo);
            //setVisible(mViewIcon, false);
        }

        updateFav();

        if (mExpanded) {
            mViewPoiCard.setText(prepareLongText(data));
        } else {
            mViewPoiCard.setText(prepareShortText(data));
        }
    }

    protected void updateFav() {
        if (mViewPoiCard == null) return;
        final T data = getData();
        mViewPoiCard.setFavStatus(data.isFav());
    }

    protected void clearView() {
        if (mViewPoiCard == null) return;
        mViewPoiCard.setIcon((Drawable) null);
        mViewPoiCard.setText(null);
        mViewPoiCard.setSummary(null);
        mViewPoiCard.setText(null);
    }

    public void expand() {
        mExpanded = true;
        updateView();
    }

    public void collapse() {
        mExpanded = false;
        updateView();
    }

    public void toggleExpand() {
        if (mExpanded) {
            collapse();
        } else {
            expand();
        }
    }

    public void hideView() {
        if (mViewPoiCard != null) {
            mViewPoiCard.hide();
        }
        mExpanded = false;
    }

    public void showView() {
        if (mViewPoiCard != null) {
            mViewPoiCard.show();
            /* TranslateAnimation animate = new TranslateAnimation(
                    0,                 // fromXDelta
                    0,                 // toXDelta
                    mViewPoiCard.getHeight(),  // fromYDelta
                    0);                // toYDelta
            animate.setDuration(300);
            animate.setFillAfter(true);
            mViewPoiCard.startAnimation(animate); */
        }
    }

    public boolean isViewShown() {
        return mViewPoiCard != null && mViewPoiCard.isShown();
    }

    /**
     * Prepares the test that display when this view has normal (collapse) state.
     * */
    protected String prepareShortText(T data) {
        // We assume that "about" is always available
        return data.getAbout();
    }

    /**
     * Prepares the test that display when this view has expanded state.
     * */
    protected String prepareLongText(T data) {
        // TODO Can we use existing instance of StringBuilder?
        final StringBuilder builder = new StringBuilder();
        String tmp = null;

        // POI About. We assume this is always available
        builder.append(data.getAbout());

        // POI Info, can be null
        tmp = data.getInfo();
        if (!TextUtils.isEmpty(tmp)) {
            builder.append(StrUtils.CHAR_EMPTY_LINE).append(tmp);
        }

        // Make final text
        return builder.toString();
    }

}
