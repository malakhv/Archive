package com.vectordigital.commonlibs.utils;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;

import java.io.InputStream;

/**
 * Освобождает память как только количество ссылок на bitmap падает до 0. Позволяет таким образом контролллировать момент освобождения памяти.
 * Created by a.karmanov on 15.10.13.
 */
public class RefCountingBitmapDrawable extends BitmapDrawable {
    private int refCounter = 1;
    private boolean recycled = false;

    public RefCountingBitmapDrawable(Resources res, Bitmap bitmap) {
        super(res, bitmap);
    }

    public RefCountingBitmapDrawable(Resources res, String filepath) {
        super(res, filepath);
    }

    public RefCountingBitmapDrawable(Resources res, InputStream is) {
        super(res, is);
    }

    public void retain() {
        refCounter++;
    }

    public void release() {
        refCounter--;
        if (refCounter <= 0 && getBitmap() != null) {
            getBitmap().recycle();
            recycled = true;
        }
    }

    @Override
    public void draw(Canvas canvas) {
        if (recycled) return;
        super.draw(canvas);
    }

}
