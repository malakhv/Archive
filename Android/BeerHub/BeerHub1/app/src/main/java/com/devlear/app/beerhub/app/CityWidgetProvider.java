package com.devlear.app.beerhub.app;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.RemoteViews;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.data.DBContract;
import com.devlear.app.beerhub.model.DataActivity;
import com.devlear.app.beerhub.model.poi.PoiHelper;
import com.devlear.app.beerhub.ui.city.ActCityMap;

import java.io.File;

/**
 * @author Mikhail.Malakhov
 */
public class CityWidgetProvider extends AppWidgetProvider {

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        final int count = appWidgetIds.length;

        // Perform this loop procedure for each App Widget that belongs to this provider
        for (int i = 0; i < count; i++) {
            int appWidgetId = appWidgetIds[i];

            // Create an Intent to launch ExampleActivity
            final Intent intent = DataActivity.makeLaunchIntent(context, ActCityMap.class,
                    DBContract.ViewCity.VIEW_NAME, 4);
            PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, intent, 0);

            // Get the layout for the App Widget and attach an on-click listener
            // to the button
            RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_city);
            views.setOnClickPendingIntent(R.id.logo, pendingIntent);
            views.setTextViewText(R.id.name,"Прага");
            views.setViewVisibility(R.id.name, View.VISIBLE);

            File icon = new File(PoiHelper.getCityIconPath(4));
            if (icon.exists() && icon.canRead()) {
                //views.setImageViewUri(R.id.logo, Uri.fromFile(icon));
            } else {
                //views.setImageViewResource(R.id.logo, R.drawable.city_no_icon);
            }

            // Tell the AppWidgetManager to perform an update on the current app widget
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
    }
}