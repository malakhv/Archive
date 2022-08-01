/*
 * Copyright (c) 2013.
 * This file is part of Wild Swift Solutions For Android library.
 *
 * Wild Swift Solutions For Android is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * Wild Swift Solutions For Android is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with Android Interface Toolkit.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.vectordigital.commonlibs.ui;


import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.util.AttributeSet;
import android.widget.ImageView;

import com.vectordigital.commonlibs.R;

import java.util.Arrays;

/**
 * @author Wild Swift 1:14 28.03.11
 */
public class OwerlayImageView extends ImageView {
    private Bitmap alphaMask;
    private Bitmap cache;
    private Drawable owerlay;
    private int oldHeight = -1;
    private int oldWidth = -1;
    private Rect paintDstRect = new Rect();
    private Rect paintSrcRect = new Rect();


    public OwerlayImageView(Context context) {
        super(context);
    }

    public OwerlayImageView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    public OwerlayImageView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(context, attrs);
    }

    private void init(Context context, AttributeSet attrs) {
        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.OwerlayImageView);
        owerlay = typedArray.getDrawable(R.styleable.OwerlayImageView_owerlay);
        typedArray.recycle();
    }

    @SuppressLint("DrawAllocation")
    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        double wScale = oldWidth != 0 ? getWidth() / (double) oldWidth : Double.MAX_VALUE;
        double hScale = oldHeight != 0 ? getHeight() / (double) oldHeight : Double.MAX_VALUE;
        if (wScale < 0.9 || wScale > 1.1 || hScale < 0.9 || hScale > 1.1) {
            clearCaches();
            oldWidth = getWidth();
            oldHeight = getHeight();
        }
        paintDstRect.set(0, 0, getWidth(), getHeight());
    }


    @Override
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        if (owerlay != null && owerlay.isStateful() && !Arrays.equals(owerlay.getState(), getDrawableState())) {
            owerlay.setState(getDrawableState());
            clearCaches();
            invalidate();
        }
    }

    private void clearCaches() {
        if (alphaMask != null) {
            alphaMask.recycle();
            alphaMask = null;
        }
        if (cache != null) {
            cache.recycle();
            cache = null;
        }
    }

    @Override
    public void setImageDrawable(Drawable drawable) {
        super.setImageDrawable(drawable);
        clearCaches();
    }

    @Override
    public void setImageURI(Uri uri) {
        super.setImageURI(uri);
        clearCaches();
    }

    @Override
    public void setImageResource(int resId) {
        super.setImageResource(resId);
        clearCaches();
    }

    @Override
    public void draw(Canvas canvas2) {
        if (owerlay == null) {
            super.draw(canvas2);
            return;
        }

        if (cache == null) {
            Bitmap bitmap = Bitmap.createBitmap(getWidth(), getHeight(), Bitmap.Config.ARGB_8888);
            super.draw(new Canvas(bitmap));
            alphaMask = bitmap.extractAlpha();
            bitmap.recycle();

            // Invert bitmap
            cache = Bitmap.createBitmap(getWidth(), getHeight(), Bitmap.Config.ARGB_8888);
            Canvas canvas1 = new Canvas(cache);
            Paint paint = new Paint();
            paint.setColor(Color.WHITE);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.XOR));
            canvas1.drawColor(Color.WHITE, PorterDuff.Mode.SRC);
            canvas1.drawBitmap(alphaMask, 0, 0, paint);
            alphaMask.recycle();
            alphaMask = cache.extractAlpha();
            cache.recycle();

            cache = Bitmap.createBitmap(getWidth(), getHeight(), Bitmap.Config.ARGB_8888);

            canvas1 = new Canvas(cache);
            canvas1.drawColor(0x00000000, PorterDuff.Mode.SRC);
            owerlay.setBounds(0, 0, getWidth(), getHeight());
            owerlay.draw(canvas1);

            paint = new Paint();
            paint.setColor(Color.WHITE);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.DST_OUT));
            canvas1.drawBitmap(alphaMask, 0, 0, paint);
            alphaMask.recycle();
            alphaMask = null;

            paintSrcRect.set(0, 0, cache.getWidth(), cache.getWidth());
        }


        super.draw(canvas2);
        canvas2.drawBitmap(cache, paintSrcRect, paintDstRect, null);
    }


}
