package com.vectordigital.commonlibs.ui;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Bitmap;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.Shader;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.widget.TextView;

import com.vectordigital.commonlibs.R;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by a.karmanov on 06.09.13.
 */
public class TextureTextView extends TextView {
    private Drawable texture;
    private static final Map<String, Typeface> typefaces = new HashMap<String, Typeface>();

    public TextureTextView(Context context) {
        super(context);
    }

    public TextureTextView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    public TextureTextView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(context, attrs);
    }

    private void init(Context context, AttributeSet attrs) {
        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.TextureTextView);
        String fontTtf = typedArray.getString(R.styleable.TextureTextView_font_ttf);
        if (!isInEditMode() && fontTtf != null && fontTtf.length() > 0) {
            if (typefaces.get(fontTtf) == null) {
                typefaces.put(fontTtf, Typeface.createFromAsset(getResources().getAssets(), "fonts/" + fontTtf + ".ttf"));
            }
            setTypeface(typefaces.get(fontTtf));
        }
        texture = typedArray.getDrawable(R.styleable.TextureTextView_texture);
        typedArray.recycle();
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        if (texture != null) {
            Bitmap bitmap = Bitmap.createBitmap(getWidth(), getHeight(), Bitmap.Config.ARGB_8888);

            texture.setBounds(0, 0, getWidth(), getHeight());
            texture.draw(new Canvas(bitmap));

            getPaint().setShader(new BitmapShader(bitmap, Shader.TileMode.REPEAT, Shader.TileMode.REPEAT));
        }
    }
}
