package com.devlear.tolang.core;

import android.content.Context;
import android.content.Intent;
import android.widget.ShareActionProvider;

/**
 * This is a provider for a text share action.
 * @author Mikhail.Malakhov
 * */
public class ShareTextProvider extends ShareActionProvider {

    /** The main "share" intent. */
    private final Intent mIntent;

    /**
     * Creates a new {@link ShareTextProvider} instance.
     * @param context Context for accessing resources.
     * */
    public ShareTextProvider(Context context) {
        super(context);
        mIntent = new Intent(Intent.ACTION_SEND);
        mIntent.setType("text/plain");
        updateIntent();
    }

    public void setText(String text) {
        mIntent.putExtra(Intent.EXTRA_TEXT, text);
        updateIntent();
    }

    /**
     * Update the current share intent.
     * */
    private void updateIntent() { setShareIntent(mIntent); }
}