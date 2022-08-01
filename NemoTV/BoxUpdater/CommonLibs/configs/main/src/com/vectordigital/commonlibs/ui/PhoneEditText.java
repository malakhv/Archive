package com.vectordigital.commonlibs.ui;

import android.content.Context;
import android.text.Editable;
import android.text.SpannableString;
import android.text.TextWatcher;
import android.text.style.ForegroundColorSpan;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.widget.EditText;

/**
 * Created by a.karmanov on 28.08.13.
 */
public class PhoneEditText extends EditText {
    public static final int MASK_COLOR = 0xFFAAAAAA;
    private String lastNumbers;

    public PhoneEditText(Context context) {
        super(context);
        InternalTextWatcher watcher = new InternalTextWatcher();
        addTextChangedListener(watcher);
        watcher.afterTextChanged(getEditableText());
    }

    public PhoneEditText(Context context, AttributeSet attrs) {
        super(context, attrs);
        InternalTextWatcher watcher = new InternalTextWatcher();
        addTextChangedListener(watcher);
        watcher.afterTextChanged(getEditableText());
    }

    public PhoneEditText(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        InternalTextWatcher watcher = new InternalTextWatcher();
        addTextChangedListener(watcher);
        watcher.afterTextChanged(getEditableText());
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        boolean b = super.onKeyUp(keyCode, event);
        setSelection(getMaxSelect(extractNumbers(getText().toString())));
        return b;
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        boolean b = super.onTouchEvent(event);
        setSelection(getMaxSelect(extractNumbers(getText().toString())));
        return b;
    }

    public String getTextRaw() {
        return extractNumbers(super.getText().toString()).substring(1);
    }

    protected class InternalTextWatcher implements TextWatcher {

        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {

        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {

        }

        @Override
        public void afterTextChanged(Editable s) {
            String in = s.toString();
            String outStr = extractNumbers(in);
            if (outStr.length() <= 11) {
                lastNumbers = outStr;
            } else {
                outStr = lastNumbers;
            }
            SpannableString format = format(outStr);
            if (in.equals(format.toString())) return;
            int selectionStart = getSelectionStart();
            selectionStart = verifySelection(outStr, selectionStart);
            setText(format);
            setSelection(selectionStart);
        }

    }

    private int verifySelection(String outStr, int selectionStart) {
        if (selectionStart < 4) selectionStart = 4;
        if (selectionStart > 7 && selectionStart < 9) selectionStart = selectionStart + 2;
        if (selectionStart == 13) selectionStart = selectionStart + 1;
        if (selectionStart == 16) selectionStart = selectionStart + 1;
        if (selectionStart > getMaxSelect(outStr)) selectionStart = getMaxSelect(outStr);
        return selectionStart;
    }

    private int getMaxSelect(String outStr) {
        if (outStr.length() < 2)
            return 4;
        if (outStr.length() < 5)
            return outStr.length() + 3;
        if (outStr.length() < 8)
            return outStr.length() + 5;
        if (outStr.length() < 10)
            return outStr.length() + 6;
        if (outStr.length() < 12)
            return outStr.length() + 7;
        return 18;
    }

    private SpannableString format(String out) {
        if (out.length() == 0) {
            SpannableString result = new SpannableString("+7 (xxx) xxx-xx-xx");
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 4, 7, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 9, 12, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 13, 15, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 16, 18, 0);
            return result;
        } else if (out.length() < 2) {
            SpannableString result = new SpannableString("+" + out + " (xxx) xxx-xx-xx");
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 4, 7, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 9, 12, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 13, 15, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 16, 18, 0);
            return result;
        } else if (out.length() < 5) {
            SpannableString result = new SpannableString("+" + out.substring(0, 1) + " (" + (out + "xxx").substring(1, 4) + ") xxx-xx-xx");
            if (out.length() < 4) {
                result.setSpan(new ForegroundColorSpan(MASK_COLOR), 4 + out.length() - 1, 7, 0);
            }
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 9, 12, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 13, 15, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 16, 18, 0);
            return result;
        } else if (out.length() < 8) {
            SpannableString result = new SpannableString("+" + out.substring(0, 1) + " (" + out.substring(1, 4) + ") " + (out + "xxx").substring(4, 7) + "-xx-xx");
            if (out.length() < 7) {
                result.setSpan(new ForegroundColorSpan(MASK_COLOR), 9 + out.length() - 4, 12, 0);
            }
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 13, 15, 0);
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 16, 18, 0);
            return result;
        } else if (out.length() < 10) {
            SpannableString result = new SpannableString("+" + out.substring(0, 1) + " (" + out.substring(1, 4) + ") " + out.substring(4, 7) + "-" + (out + "xxx").substring(7, 9) + "-xx");
            if (out.length() < 9) {
                result.setSpan(new ForegroundColorSpan(MASK_COLOR), 13 + out.length() - 7, 15, 0);
            }
            result.setSpan(new ForegroundColorSpan(MASK_COLOR), 16, 18, 0);
            return result;
        } else if (out.length() < 12) {
            SpannableString result = new SpannableString("+" + out.substring(0, 1) + " (" + out.substring(1, 4) + ") " + out.substring(4, 7) + "-" + out.substring(7, 9) + "-" + (out + "xxx").substring(9, 11));
            if (out.length() < 11) {
                result.setSpan(new ForegroundColorSpan(MASK_COLOR), 16 + out.length() - 9, 18, 0);
            }
            return result;
        } else {
            return new SpannableString("+" + out.substring(0, 1) + " (" + out.substring(1, 4) + ") " + out.substring(4, 7) + "-" + out.substring(7, 9) + "-" + out.substring(9, 11));
        }
    }

    private String extractNumbers(String in) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < in.length(); i++) {
            char c = in.charAt(i);
            if (Character.isDigit(c)) {
                builder.append(c);
            }
        }
        return builder.toString();
    }

}
