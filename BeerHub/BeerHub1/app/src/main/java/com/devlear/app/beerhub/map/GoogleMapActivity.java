package com.devlear.app.beerhub.map;

import static android.Manifest.permission.ACCESS_FINE_LOCATION;

import android.annotation.SuppressLint;
import android.app.FragmentTransaction;
import android.content.res.Resources;
import android.os.Bundle;

import androidx.annotation.Nullable;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.model.poi.PoiObject;
import com.devlear.app.beerhub.util.PermUtils;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.UiSettings;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MapStyleOptions;
import com.malakhv.util.LogCat;

/**
 * @author Mikhail.Malakhov
 */
public abstract class GoogleMapActivity extends MapActivity<PoiObject, GoogleMap>
        implements OnMapReadyCallback {

    private static final String TAG = "GoogleMapActivity";

    // TODO Move to MapEngineImpl
    public static float ZOOM_LEVEL_ME = 17;
    public static float ZOOM_LEVEL_CITY = 11;
    public static float ZOOM_LEVEL_OFF = -1;

    private MapFragment mMapFragment = null;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    protected void onStart() {
        super.onStart();
        if (mMapFragment == null) initMapFragment();
    }

    /** {@inheritDoc} */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        setMap(googleMap);

        try {
            // Customise the styling of the base map using a JSON object defined
            // in a raw resource file.
            boolean success = googleMap.setMapStyle(
                    MapStyleOptions.loadRawResourceStyle(
                            this, R.raw.google_map_style_def));
            if (!success) {
                LogCat.e(TAG, "Style parsing failed.");
            }
        } catch (Resources.NotFoundException e) {
            LogCat.e(TAG, "Can't find style. Error: ", e);
        }

        initMap();
    }

    /** {@inheritDoc} */
    @Override
    protected void moveCamera(double lat, double lon, float zoom, boolean animation) {
        final LatLng location = new LatLng(lat, lon);
        moveCamera(location, zoom, animation);
    }

    /**
     * Moves map camera to specified point with specified zoom level.
     * */
    protected void moveCamera(LatLng location, float zoom, boolean animation) {
        final GoogleMap map = getMap();
        if (map == null || location == null) return;
        final CameraUpdate camera;
        if (zoom > 0) {
            camera = CameraUpdateFactory.newLatLngZoom(location, zoom);
        } else {
            camera = CameraUpdateFactory.newLatLng(location);
        }
        if (animation) {
            map.animateCamera(camera);
        } else {
            map.moveCamera(camera);
        }
    }

    /**
     * Moves map camera to specified point with specified zoom level.
     * */
    protected void moveCamera(LatLng location, boolean animation) {
        moveCamera(location, -1, animation);
    }

    protected void initMapFragment() {
        mMapFragment = MapFragment.newInstance();
        FragmentTransaction fragmentTransaction =
                getFragmentManager().beginTransaction();
        fragmentTransaction.add(getMapContainerId(), mMapFragment);
        fragmentTransaction.commit();
        mMapFragment.getMapAsync(this);
    }

    protected int getMapContainerId() {
        return R.id.map_container;
    }

    @SuppressLint("MissingPermission")
    @Override
    protected void initMap() {
        if (!hasMap()) return;
        final GoogleMap map = getMap();
        if (PermUtils.has(this, ACCESS_FINE_LOCATION)) {
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