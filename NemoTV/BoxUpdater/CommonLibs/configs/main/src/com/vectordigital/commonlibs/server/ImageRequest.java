package com.vectordigital.commonlibs.server;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.util.Log;

import com.vectordigital.commonlibs.application.ApplicationUtils;
import com.vectordigital.commonlibs.exceptions.ServerApiException;

import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Wild Swift
 */
public class ImageRequest extends ServerRequest<BitmapDrawable> {
    private final Logger log = Logger.getLogger(getClass().getName());
    private Context context;

    public ImageRequest(String url, Context context) {
        super(url);
        this.context = context;
    }

    @Override
    public BitmapDrawable processRequest(InputStream content) throws ServerApiException, IOException {
        BitmapDrawable bitmapDrawable;
        try {
            bitmapDrawable = new BitmapDrawable(context.getResources(), content);
        } catch (Throwable e) {
            log.severe(ApplicationUtils.getErrorReport(e.getMessage(), e));
            throw new ServerApiException(e);
        }
        if (log.isLoggable(Level.CONFIG)) {
            log.config("BitmapDrawable create " + getUrl());
            if (bitmapDrawable.getBitmap() != null) {
                log.config("BitmapDrawable " + bitmapDrawable.getBitmap().getWidth() + "x" + bitmapDrawable.getBitmap().getHeight());
                log.config("BitmapDrawable " + bitmapDrawable.getBitmap().getConfig());
            }
        }
        if(bitmapDrawable.getBitmap() == null)
            throw new ServerApiException("Cannot decode bitmap for url: "+getUrl());

        return bitmapDrawable;
    }
}
