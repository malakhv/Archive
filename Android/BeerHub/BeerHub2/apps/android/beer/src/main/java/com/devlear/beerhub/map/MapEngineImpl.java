package com.devlear.beerhub.map;

import android.text.TextUtils;

import com.devlear.beerhub.model.LatLon;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

/**
 * @author Mikhail.Malakhov
 */
abstract class MapEngineImpl implements MapEngine, Iterable<MapMarker> {

    private Set<MapMarker> mMarkers = new HashSet<>();

    public MapEngineImpl() {
        mMarkers.iterator().remove();
    }


    /** {@inheritDoc} */
    @Override
    public boolean hasMarker(MapMarker marker) {
        return marker != null && mMarkers.contains(marker);
    }

    /** {@inheritDoc} */
    @Override
    public final boolean addMarker(MapMarker marker) {
        if (hasMarker(marker)) return false;
        final Object origin = addMarkerInternal(marker);
        if (origin != null) {
            marker.link(origin);
            mMarkers.add(marker);
            marker.setMarkerCallbacks(mMarkerCallbacks);
            return true;
        } else {
            return false;
        }
    }

    /** {@inheritDoc} */
    @Override
    public MapMarker addMarker(String title, LatLon position, boolean visible) {
        if (TextUtils.isEmpty(title) || position == null || position.isEmpty()) return null;
        final MapMarker marker = new MapMarker(title, position);
        marker.setVisibility(visible);
        return addMarker(marker) ? marker : null;
    }

    /** {@inheritDoc} */
    @Override
    public MapMarker addMarker(String title, LatLon position) {
        return addMarker(title, position, true);
    }

    public final void removeMarker(MapMarker marker) {
        if (marker == null) return;
        removeMarkerInternal(marker);
        mMarkers.remove(marker);
        marker.setMarkerCallbacks(null);
        marker.unlink();
    }

    @Override
    public Iterator<MapMarker> iterator() {
        return mMarkers.iterator();
    }

    private class MarkerIterator implements Iterator<MapMarker> {

        private Collection<MapMarker> mCollection = null;


        public MarkerIterator(Collection<MapMarker> collection) {
            mCollection = collection;
        }

        @Override
        public boolean hasNext() {
            return mCollection.iterator().hasNext();
        }

        @Override
        public MapMarker next() {
            return mCollection.iterator().next();
        }

        @Override
        public void remove() {

        }
    }

    private MarkerCallbacks mMarkerCallbacks = new MarkerCallbacks() {

        @Override
        public void onMarkerDataChanged(MapMarker marker) {
            updateMarkerInternal(marker);
        }

        @Override
        public void onMarkerRemoved(MapMarker marker) {
            removeMarker(marker);
        }

        @Override
        public void onMarkerVisibilityChanged(MapMarker marker, boolean visible) {
            updateMarkerInternal(marker);
        }
    };

    protected abstract Object addMarkerInternal(MapMarker marker);
    protected abstract void removeMarkerInternal(MapMarker marker);
    protected abstract void updateMarkerInternal(MapMarker marker);

    interface MarkerCallbacks {
        void onMarkerDataChanged(MapMarker marker);
        void onMarkerRemoved(MapMarker marker);
        void onMarkerVisibilityChanged(MapMarker marker, boolean visible);
    }
}
