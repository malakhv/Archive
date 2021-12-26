package com.malakhv.libs.preference.test;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.util.AttributeSet;

import com.malakhv.preference.DialogFragmentPref;

/**
 * Created by malakhv on 16.06.2016.
 */
public class TestDialogFragmentPref extends DialogFragmentPref {


    /**
     * Simple constructor to use when creating a preference from code.
     *
     * @param context
     */
    public TestDialogFragmentPref(Context context) {
        super(context);
    }

    /**
     * Constructor that is called when inflating a preference from XML.
     *
     * @param context
     * @param attrs
     */
    public TestDialogFragmentPref(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    /**
     * Perform inflation from XML and apply a class-specific base style from a theme attribute.
     *
     * @param context
     * @param attrs
     * @param defStyleAttr
     */
    public TestDialogFragmentPref(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    /**
     * Perform inflation from XML and apply a class-specific base style from a theme attribute or
     * style resource.
     *
     * @param context
     * @param attrs
     * @param defStyleAttr
     * @param defStyleRes
     */
    public TestDialogFragmentPref(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
    }


    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
        builder.setMessage("TestDialog");
        return builder.create();
    }
}
