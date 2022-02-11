package com.devlear.app.beerhub.mapengine;

import static android.Manifest.permission.ACCESS_FINE_LOCATION;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.Resources;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.map.MapMarker;
import com.devlear.app.beerhub.model.LatLon;
import com.devlear.app.beerhub.util.PermUtils;

import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.UiSettings;
import com.google.android.gms.maps.model.MapStyleOptions;

import com.malakhv.util.LogCat;

/**
 * @author Mikhail.Malakhov
 */
public final class GoogleMapEngine extends AbstractMapEngine<GoogleMap>
        implements OnMapReadyCallback {

    private static final String TAG = "GoogleMapEngine";

    /** The real map fragment. */
    MapFragment mMapFragment = null;

    private Context mContext = null;

    /** {@inheritDoc} */
    GoogleMapEngine(Context context, MapConfig config) {
        super(config);
        mContext = context;
    }

    /** {@inheritDoc} */
    @Override
    public void initMap(MapCallbacks callbacks) {
        super.initMap(callbacks);
        if (mMapFragment != null) {
            mMapFragment.getMapAsync(this);
        }
    }

    /** {@inheritDoc} */
    @Override
    protected Object addRawMarker(MapMarker marker) {
        return null;
    }

    /** {@inheritDoc} */
    @Override
    protected void removeRawMarker(MapMarker marker) {

    }

    /** {@inheritDoc} */
    @Override
    protected void updateRawMarker(MapMarker marker) {

    }

    /**
     * Moves camera to specified position.
     *
     * @param position
     */
    @Override
    public void moveCamera(LatLon position) {

    }

    /**
     * Moves camera to specified position and settings up zoom level.
     *
     * @param position
     * @param zoom
     */
    @Override
    public void moveCamera(LatLon position, int zoom) {

    }

    /**
     * Moves camera to specified position and settings up zoom level and animation.
     *
     * @param position
     * @param zoom
     * @param animation
     */
    @Override
    public void moveCamera(LatLon position, int zoom, boolean animation) {

    }

    @SuppressLint("MissingPermission")
    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;
        //TODO Configure map

        try {
            // Customise the styling of the base map using a JSON object defined
            // in a raw resource file.
            boolean success = googleMap.setMapStyle(
                    MapStyleOptions.loadRawResourceStyle(
                            mContext, R.raw.google_map_style_def));
            if (!success) {
                LogCat.e(TAG, "Style parsing failed.");
            }
        } catch (Resources.NotFoundException e) {
            LogCat.e(TAG, "Can't find style. Error: ", e);
        }

        configureMap();

        performMapReady();
    }

    @SuppressLint("MissingPermission")
    protected void configureMap() {
        if (!hasMap()) return;
        final GoogleMap map = getMap();
        if (PermUtils.has(mContext, ACCESS_FINE_LOCATION)) {
            map.setMyLocationEnabled(true);
        }
        map.setBuildingsEnabled(true);
        map.setTrafficEnabled(false);
        map.setMapType(GoogleMap.MAP_TYPE_NORMAL);
        final UiSettings settings = map.getUiSettings();
        settings.setMapToolbarEnabled(false);
        settings.setZoomControlsEnabled(false);
        settings.setMyLocationButtonEnabled(false);
        settings.setRotateGesturesEnabled(false);
    }
}
