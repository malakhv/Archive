package com.devlear.app.beerhub.ui.city;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.graphics.drawable.VectorDrawable;
import android.location.Location;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import androidx.recyclerview.widget.DefaultItemAnimator;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.devlear.app.beerhub.R;
import com.devlear.app.beerhub.billing.Billing;
import com.devlear.app.beerhub.data.DBContract;
import com.devlear.app.beerhub.data.FavHelper;
import com.devlear.app.beerhub.data.LocaleHelper;
import com.devlear.app.beerhub.map.GoogleMapActivity;
import com.devlear.app.beerhub.model.DataViewHolder;
import com.devlear.app.beerhub.model.place.PlaceCardController;
import com.devlear.app.beerhub.model.place.PlaceList;
import com.devlear.app.beerhub.model.place.PlaceObject;
import com.devlear.app.beerhub.model.poi.PoiObject;
import com.devlear.app.beerhub.model.poi.PoiType;
import com.devlear.app.beerhub.ui.place.PlaceAdapter;
import com.devlear.app.beerhub.util.StrUtils;
import com.devlear.app.beerhub.widget.PoiCard;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;

import java.util.HashMap;
import java.util.Map;

/**
 * // CityMap, CityGuide, CityInfo
 * @author Mikhail.Malakhov
 */
// TODO Need to big refactoring
public class ActCityMap extends GoogleMapActivity implements GoogleMap.OnMapClickListener,
        GoogleMap.OnMarkerClickListener, View.OnClickListener, DataViewHolder.OnItemClickListener,
        CompoundButton.OnCheckedChangeListener, FavHelper.OnFavChangedListener {

    /** The marker layer (z-index): Default value. */
    private static final float MARKER_LAYER_DEF = 0f;

    /** The marker layer (z-index): Favorite place. */
    private static final float MARKER_LAYER_FAV = 1f;

    /** The marker layer (z-index): Selected place. */
    private static final float MARKER_LAYER_SEL = 2f;

    private PlaceCardController mCardController = null;

    /** The current selected marker on the map. */
    private Marker mSelectedMarker = null;

    private BitmapDescriptor MARKER_DEF = null;
    private BitmapDescriptor MARKER_FAV = null;
    private BitmapDescriptor MARKER_SEL = null;

    private RecyclerView mPlaceList = null;
    private PlaceAdapter mPlaceListAdapter = null;

    private Map<Long, Marker> mMarkers = new HashMap<>();

    private FavEmptyToast mFavEmptyToast = new FavEmptyToast();

    private long mOpenForId = DBContract.NO_ID;
    private PoiObject mOpenForPlace = null;

    /** {@inheritDoc} */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_city_map);

        // Process deep link
        final Intent intent = getIntent();
        if (intent != null && Intent.ACTION_VIEW.equals(intent.getAction())) {
            loadDeepLink(intent);
        }

        // The name of the city
        final TextView cityName = findViewById(R.id.city_name);
        cityName.setText(getData().getName());

        // Init POI card
        final PoiCard card = findViewById(R.id.place_card);
        mCardController = new PlaceCardController();
        mCardController.setCard(card);
        card.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mCardController.toggleExpand();
            }
        });

        // The list of places
        initPlaceList();

        // The controls on the map
        initMapControls();
    }

    /** {@inheritDoc} */
    @Override
    protected void onStart() {
        super.onStart();
        FavHelper.addOnFavChangedListener(this);
    }

    /** {@inheritDoc} */
    @Override
    protected void onStop() {
        super.onStop();
        FavHelper.removeOnFavChangedListener(this);
    }

    /** {@inheritDoc} */
    @Override
    public void onBackPressed() {
        // Closing list of places, if needed
        if (mPlaceList.isShown()) {
            mPlaceList.setVisibility(View.GONE);
            return;
        }
        // Closing place card, if needed
        if (mCardController.isViewShown()) {
            mCardController.hideView();
            selectMarker(null);
            return;
        }
        super.onBackPressed();
    }

    protected void loadDeepLink(Intent intent) {
        long id = DBContract.NO_ID;
        final Uri uri = intent.getData();
        if (uri != null) {
            id = StrUtils.toLong(uri.getLastPathSegment(), id);
        }
        if (id > DBContract.NO_ID) {
            final PoiObject poi = new PoiObject(PoiType.PLACE);
            loadDataItem(poi.getType().getTable(), id, poi);
            if (!poi.isEmpty()) {
                loadDataItem(DBContract.ViewCity.VIEW_NAME,poi.getLong(DBContract.ViewPlace.COLUMN_CITY_ID));
                mOpenForId = poi.getId();
            }
        }
    }

    private void initMapControls() {
        View control = null;

        // The location of current city
        control = findViewById(R.id.act_city_location);
        control.setOnClickListener(this);

        // The current location
        control = findViewById(R.id.act_my_location);
        control.setOnClickListener(this);

        // The list of places
        control = findViewById(R.id.act_show_list);
        control.setOnClickListener(this);

        // The favorite only action
        final ToggleButton favOnly = findViewById(R.id.act_fav_only);
        favOnly.setOnCheckedChangeListener(this);
    }

    private void initPlaceList() {
        mPlaceListAdapter = new PlaceAdapter();
        mPlaceListAdapter.setCityId(getId());
        mPlaceListAdapter.update();
        mPlaceList = findViewById(R.id.place_list);
        mPlaceList.setLayoutManager(new LinearLayoutManager(this));
        mPlaceList.setItemAnimator(new DefaultItemAnimator());
        mPlaceList.addItemDecoration(new DividerItemDecoration(this, 1));
        mPlaceList.setAdapter(mPlaceListAdapter);
        mPlaceListAdapter.setOnItemClickListener(this);
    }



    @Override
    protected PoiObject makeDataItem() {
        return new PoiObject(PoiType.CITY);
    }

    /** {@inheritDoc} */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        super.onMapReady(googleMap);

        /* MARKER_DEF = BitmapDescriptorFactory.defaultMarker();
        MARKER_FAV = BitmapDescriptorFactory.defaultMarker(
                BitmapDescriptorFactory.HUE_GREEN);
        MARKER_SEL = BitmapDescriptorFactory.defaultMarker(
                BitmapDescriptorFactory.HUE_AZURE); */

        Bitmap b = null;
        b = getBitmap(R.drawable.map_marker_def);
        MARKER_DEF = BitmapDescriptorFactory.fromBitmap(b);
        b = getBitmap(R.drawable.map_marker_fav);
        MARKER_FAV = BitmapDescriptorFactory.fromBitmap(b);
        b = getBitmap(R.drawable.map_marker_sel);
        MARKER_SEL = BitmapDescriptorFactory.fromBitmap(b);

        fillMap();
        getMap().setOnMarkerClickListener(this);
        getMap().setOnMapClickListener(this);

        if (mOpenForId > DBContract.NO_ID) {
            final Marker marker = mMarkers.get(mOpenForId);
            if (marker != null && marker.getTag() != null) {
                PlaceObject tag = (PlaceObject) marker.getTag();
                mCardController.setData(tag);
                mCardController.showView();
                selectMarker(marker, ZOOM_LEVEL_CITY);
            }
        } else {
            moveCamera(getData().getLatitude(), getData().getLongitude(),
                    ZOOM_LEVEL_CITY, false);
        }
    }

    //private Runnable mSelectRunnable

    private static Bitmap getBitmap(VectorDrawable vectorDrawable) {
        //vectorDrawable.setTint(Color.RED);
        Bitmap bitmap = Bitmap.createBitmap(vectorDrawable.getIntrinsicWidth(),
                vectorDrawable.getIntrinsicHeight(), Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        vectorDrawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        vectorDrawable.draw(canvas);
        return bitmap;
    }

    private static Bitmap getBitmap(LayerDrawable drawable, int width, int height) {
        Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        drawable.draw(canvas);
        return bitmap;
    }

    private Bitmap getBitmap(int drawableId) {
        Drawable drawable = this.getDrawable(drawableId);
        if (drawable instanceof BitmapDrawable) {
            return ((BitmapDrawable) drawable).getBitmap();
        } else if (drawable instanceof VectorDrawable) {
            return getBitmap((VectorDrawable) drawable);
        } else if (drawable instanceof LayerDrawable) {
            int size = this.getResources().getDimensionPixelSize(R.dimen.map_marker_size);
            return getBitmap((LayerDrawable) drawable, size, size);
        } else {
            throw new IllegalArgumentException("unsupported drawable type");
        }
    }

    private void fillMap() {
        final PlaceList list = new PlaceList();
        mMarkers.clear();
        int maxPoi = 0;
        if (!Billing.hasPurchase(this, getData().getString(DBContract.SkuTable.COLUMN_SKU))) {
            maxPoi = Billing.FREE_PLACE_COUNT;
        }
        list.load(getId(), LocaleHelper.getCurrentLocale(), maxPoi);

        for (PoiObject poi: list) {
            if (!poi.hasLocation()) continue;
            LatLng position = new LatLng(poi.getLatitude(), poi.getLongitude());
            MarkerOptions options = new MarkerOptions();
            options.position(position);
            options.title(poi.getName());
            //options.icon(BitmapDescriptorFactory.fromResource(R.drawable.marker_blue));
            if (poi.isFav()) {
                options.icon(MARKER_FAV);
                options.zIndex(MARKER_LAYER_FAV);
            } else {
                options.icon(MARKER_DEF);
            }
            options.anchor(0.5F,0.5F);
            Marker marker = getMap().addMarker(options);
            marker.setTag(poi);
            mMarkers.put(poi.getId(), marker);
        }

    }

    @Override
    public void onMapClick(LatLng latLng) {
        mCardController.hideView();
        mPlaceList.setVisibility(View.GONE);
        selectMarker(null);
    }

    /** {@inheritDoc} */
    @Override
    public boolean onMarkerClick(Marker marker) {
        //PoiObject tag = (PoiObject) marker.getTag();
        PlaceObject tag = (PlaceObject) marker.getTag();
        if (tag != null) {
            //mPlaceCard.show(tag);
            mCardController.setData(tag);
            mCardController.showView();
            selectMarker(marker);
            return true;
        }
        selectMarker(null);
        return true;
    }

    private void selectMarker(Marker marker) {
        selectMarker(marker, ZOOM_LEVEL_OFF);
    }

    /**
     * Selects the specified marker.
     * */
    private void selectMarker(Marker marker, float zoom) {
        // Set default icon for current selected marker
        float z = MARKER_LAYER_DEF;
        if (mSelectedMarker != null) {
            final PoiObject poi = (PlaceObject) mSelectedMarker.getTag();
            if (poi != null) {
                final boolean fav = poi.isFav();
                mSelectedMarker.setIcon(fav ? MARKER_FAV: MARKER_DEF);
                mSelectedMarker.setVisible(!mFavOnly || fav);
                z = fav ? MARKER_LAYER_FAV : z;
            }
            mSelectedMarker.setZIndex(z);
        }
        // Marks marker as selected
        if (marker != null) {
            marker.setIcon(MARKER_SEL);
            marker.setVisible(true); // Selected marker should visible in any cases
            mSelectedMarker = marker;
            moveCamera(marker.getPosition(), zoom, true);
            marker.setZIndex(MARKER_LAYER_SEL);
        } else {
            mSelectedMarker = null;
        }
    }

    @Override
    public void onClick(View v) {
        final int id = v != null ? v.getId() : 0;

        // List of places
        if (id == R.id.act_show_list && mPlaceList != null) {
            if (mPlaceListAdapter.getItemCount() <= 0) return;
            if (mPlaceList.getVisibility() != View.VISIBLE) {
                mCardController.hideView();
                selectMarker(null);
                mPlaceList.setVisibility(View.VISIBLE);
            } else {
                mPlaceList.setVisibility(View.GONE);
            }
            return;
        }

        if (id == R.id.act_city_location) {
            final PoiObject poi = getData();
            if (poi != null && poi.hasLocation()) {
                moveCamera(poi.getLatitude(), poi.getLongitude(), ZOOM_LEVEL_CITY, true);
            }
            return;
        }

        if (id == R.id.act_my_location) {
            Location location = getMap().getMyLocation();
            if (location != null) {
                moveCamera(location.getLatitude(), location.getLongitude(), ZOOM_LEVEL_ME,
                        true);
            }
        }

    }

    @Override
    public void onItemClick(int position, long id) {
        final Marker marker = mMarkers.get(id);
        if (marker != null) {
            PlaceObject tag = (PlaceObject) marker.getTag();
            mCardController.setData(tag);
            mCardController.showView();
            mPlaceList.setVisibility(View.GONE);
            selectMarker(marker, ZOOM_LEVEL_ME);
        }
    }

    private boolean mFavOnly = false;

    private boolean isSelected(Marker marker) {
        if (mSelectedMarker == null || mSelectedMarker.getTag() == null) return false;
        final PoiObject poi = (PoiObject) marker.getTag();
        if (poi == null) return false;
        return poi.getId() == ( (PoiObject) mSelectedMarker.getTag()).getId();
    }

    @Override
    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

        // When we turn off this filter, we should close toast, if it exists
        if (!isChecked && mFavEmptyToast != null) {
            mFavEmptyToast.cancel();
        }

        int favCount = 0;
        Marker marker = null;
        PoiObject poi = null;
        mFavOnly = isChecked;
        for (Long key : mMarkers.keySet()) {
            marker = mMarkers.get(key);
            if (marker == null) continue;
            poi = (PoiObject) marker.getTag();
            if (poi == null) continue;
            marker.setVisible(!isChecked || poi.isFav() || isSelected(marker));
            favCount += poi.isFav() ? 1 : 0;
        }
        // Update list of places
        // TODO Do we want to have special settings to change this logic and show all places always?
        if (mPlaceListAdapter != null) {
            mPlaceListAdapter.setFavOnly(mFavOnly);
        }

        // When we turn on this filter, but list of places is empty, we should show
        // message about it
        if (isChecked && favCount == 0) {
            mFavEmptyToast.show();
        }
    }

    /** {@inheritDoc} */
    @Override
    public void OnFavChanged(PoiType type) {
        // If we should show only favorite places in list, we should update list in this point
        if (type == PoiType.PLACE && mPlaceListAdapter.isFavOnly()) {
            mPlaceListAdapter.update();
        }
    }

    private class FavEmptyToast {
        private Toast mToast;

        @SuppressLint("ShowToast")
        public void show() {
            if (mToast == null) {
                mToast = Toast.makeText(ActCityMap.this, R.string.msg_fav_empty,
                        Toast.LENGTH_LONG);
            }
            mToast.show();
        }

        public void cancel() {
            if (mToast != null) mToast.cancel();
        }
    }

}
