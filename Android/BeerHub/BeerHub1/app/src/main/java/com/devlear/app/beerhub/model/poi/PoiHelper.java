package com.devlear.app.beerhub.model.poi;

import android.content.Context;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.content.FileResources;
import com.devlear.app.beerhub.content.AppContent;
import com.malakhv.util.LogCat;

import java.io.File;

/**
 * @author Mikhail.Malakhov
 */
public final class PoiHelper {

    private static File getContentDir(Context context, PoiType type, long id) {
        return AppContent.getContentDirForRow(context, type.getContentPath(), id);
    }

    public static File getIconFile(Context context, PoiType type, long id) {
        final File root = getContentDir(context, type, id);
        return new File(root, "logo_128.png");
    }

    public static String getIconPath(PoiType type, long id) {
        // /data/user/0/com.devlear.app.beerhub/files/content + /media/ + place + / +
        // /data/user/0/com.devlear.app.beerhub/files/content/media/place/3/icon_128.png
        return AppContent.DATA_DIR + "/media/" + type.getContentPath() + "/" + id + "/logo_128.png";
    }

    public static String getIconPath(Context context, PoiType type, long id) {
        FileResources resManager = AppContent.getResources();
        if (resManager != null) {
            return resManager.getResPath(type.getContentPath(), id, R.id.logo);
        } else {
            return null;
        }
    }

    private static String resIdToStr(int resId) {
        if (resId == R.id.content_icon) {
            return "icon";
        } else {
            return null;
        }
    }

    public static String getPlaceIconPath(long id) {
        return getIconPath(PoiType.PLACE, id);
    }

    public static String getPlaceIconPath(Context context, long id) {
        final String path = getIconPath(context, PoiType.PLACE, id);
        LogCat.d("POI", path);
        return path;
    }

    public static String getCityIconPath(long id) {
        return getIconPath(PoiType.CITY, id);
    }

    public static String getCityIconPath(Context context, long id) {
        return getIconPath(PoiType.CITY, id);
    }


}
