package com.vectordigital.commonlibs.ui.cyclelayers;

import android.content.Context;
import android.content.res.TypedArray;
import android.database.DataSetObserver;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Scroller;

import com.vectordigital.commonlibs.R;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;

/**
 * User: a.karmanov
 * Date: 18.07.13
 * Time: 12:54
 */
public class HorizontalCycleLayersView extends AdapterView<CycleLayersAdapter> implements GestureDetector.OnGestureListener {

    private CycleLayersAdapter adapter;
    private DataSetObserver observer = new DataSetObserver() {
        @Override
        public void onChanged() {
            super.onChanged();
            onDataSetChanged();
        }

        @Override
        public void onInvalidated() {
            super.onInvalidated();
        }
    };

    private ArrayList<LayerView> layers = new ArrayList<LayerView>(15);
    private int mainLayerIndex;
    private int selectedPosition;

    private GestureDetector detector;
    private Scroller scroller;
    private Runnable updateScrollTask = new ScrollUpdater();
    private boolean aborted;

    private int gravity = Gravity.TOP;

    public HorizontalCycleLayersView(Context context) {
        super(context);
        detector = new GestureDetector(context, this);
        scroller = new Scroller(context);
    }

    public HorizontalCycleLayersView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    public HorizontalCycleLayersView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(context, attrs);
    }

    private void init(Context context, AttributeSet attrs) {
        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.HorizontalCycleLayersView);
        mainLayerIndex = typedArray.getInt(R.styleable.HorizontalCycleLayersView_mainLayer, 0);
        typedArray.recycle();
        switch (typedArray.getInt(R.styleable.HorizontalCycleLayersView_gravity, 0)) {
            case 0:
                gravity = Gravity.TOP;
                break;
            case 1:
                gravity = Gravity.CENTER_VERTICAL;
                break;
            case 2:
                gravity = Gravity.BOTTOM;
                break;
        }
        detector = new GestureDetector(context, this);
        scroller = new Scroller(context);
    }

    public void setGravity(int gravity) {
        this.gravity = gravity;
    }

    private void onDataSetChanged() {
        if (adapter != null) {
            while (layers.size() < adapter.getLayersCount()) {
                LayerView layer = new LayerView(getContext());
                layers.add(layer);
                this.addViewInLayout(layer, 0, new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));
            }
            while (layers.size() > adapter.getLayersCount()) {
                this.removeViewInLayout(layers.get(layers.size() - 1));
                layers.remove(layers.size() - 1);
            }
            for (int i = 0; i < layers.size(); i++) {
                LayerView layer = layers.get(i);
                layer.layerIndex = i;
                layer.cache.clear();
                layer.removeAllViews();
                layer.scrollTo(0, 0);
                layer.firstChildIndex = 0;
                layer.firstChildLeft = 0;
            }
            requestLayout();
        } else {
            layers.clear();
            removeAllViews();
        }
    }

    @Override
    public CycleLayersAdapter getAdapter() {
        return adapter;
    }

    @Override
    public void setAdapter(CycleLayersAdapter adapter) {
        if (this.adapter != null) {
            this.adapter.unregisterDataSetObserver(observer);
        }
        this.adapter = adapter;
        if (this.adapter != null) {
            this.adapter.registerDataSetObserver(observer);
        }
        onDataSetChanged();
    }

    @Override
    public View getSelectedView() {
        if (adapter == null) return null;
        return getView(mainLayerIndex, selectedPosition);
    }

    @Override
    public void setSelection(int position) {
        selectedPosition = position;
    }

    public int getMainLayerIndex() {
        return mainLayerIndex;
    }

    public void setMainLayerIndex(int mainLayerIndex) {
        this.mainLayerIndex = mainLayerIndex;
    }

    private View getView(int mainLayerIndex, int selectedPosition) {
        return adapter.getView(mainLayerIndex, selectedPosition, null, null);
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        for (int i = 0; i < getChildCount(); i++) {
            getChildAt(i).measure(MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.EXACTLY), MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.EXACTLY));
            getChildAt(i).layout(0, 0, getWidth(), getHeight());
        }
        scrollCenter(true);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        boolean b = detector.onTouchEvent(event);
        if (event.getAction() == MotionEvent.ACTION_UP && !scroller.computeScrollOffset()) {
            scrollCenter(false);
        }
        return b;
    }

    @Override
    public boolean onDown(MotionEvent e) {
        scroller.abortAnimation();
        aborted = true;
        return true;
    }

    @Override
    public void onShowPress(MotionEvent e) {
    }

    @Override
    public boolean onSingleTapUp(MotionEvent e) {
        return false;
    }

    @Override
    public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
        scrollByInner((int) distanceX, 0);
        return true;
    }

    @Override
    public void onLongPress(MotionEvent e) {

    }

    @Override
    public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
        int mainLayer = getMainLayer();
        scroller.fling(layers.get(mainLayer).getScrollX(), 0, (int) -velocityX, 0, Integer.MIN_VALUE, Integer.MAX_VALUE, 0, 0);
        aborted = false;
        post(updateScrollTask);
        return true;
    }

    private void scrollCenter(boolean immediate) {
        if (adapter == null || adapter.getLayersCount() == 0) return;
        LayerView layerView = layers.get(getMainLayer());
        int distance = Integer.MAX_VALUE;
        int viewCenter = layerView.getWidth() / 2 + layerView.getScrollX();
        for (int i = 0; i < layerView.getChildCount(); i++) {
            View childAt = layerView.getChildAt(i);
            int childCenter = (childAt.getLeft() + childAt.getRight()) / 2;
            if (Math.abs(distance) > Math.abs(viewCenter - childCenter)) {
                distance = childCenter - viewCenter;
            }

        }
        if (distance != 0) {
            if (!immediate) {
                scroller.startScroll(layerView.getScrollX(), layerView.getScrollY(), distance, 0, 600);
                aborted = false;
                post(updateScrollTask);
            } else {
                scrollToInner(layerView.getScrollX() + distance, layerView.getScrollY());
            }
        }
    }

    protected void scrollByInner(int dx, int dy) {
        if (adapter == null || adapter.getLayersCount() == 0) return;
        int layersCount = adapter.getLayersCount();
        int mainLayer = getMainLayer();
        for (int i = 0; i < layers.size(); i++) {
            LayerView next = layers.get(i);
            double scale = ((double) layersCount - i) / (layersCount - mainLayer);
            next.scrollBy((int) (dx * scale), (int) (dy * scale));
        }
    }

    protected void scrollToInner(int dx, int dy) {
        if (adapter == null || adapter.getLayersCount() == 0) return;
        int layersCount = adapter.getLayersCount();
        int mainLayer = getMainLayer();
        for (int i = 0; i < layers.size(); i++) {
            LayerView next = layers.get(i);
            double scale = ((double) layersCount - i) / (layersCount - mainLayer);
            next.scrollTo((int) (dx * scale), (int) (dy * scale));
        }
    }

    private int getMainLayer() {
        int layersCount = adapter != null ? adapter.getLayersCount() : 0;
        return mainLayerIndex < layersCount ? mainLayerIndex : 0;
    }

    private class LayerView extends ViewGroup {

        private int firstChildLeft = 0;
        private int firstChildIndex = 0;
        private int layerIndex;

        public LayerView(Context context) {
            super(context);
        }

        private LinkedHashSet<View> cache = new LinkedHashSet<View>(10);

        @Override
        protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
            super.onMeasure(widthMeasureSpec, heightMeasureSpec);
            for (int i = 0; i < getChildCount(); i++) {
                getChildAt(i).measure(MeasureSpec.makeMeasureSpec(MeasureSpec.getSize(widthMeasureSpec), MeasureSpec.UNSPECIFIED), MeasureSpec.makeMeasureSpec(MeasureSpec.getSize(heightMeasureSpec), MeasureSpec.AT_MOST));
            }
        }

        @Override
        protected void onLayout(boolean changed, int l, int t, int r, int b) {
            int count = adapter.getCount(layerIndex);
            if (count <= 0) return;
            int left = firstChildLeft;
            int right = getChildCount() > 0 ? firstChildLeft + getChildAt(0).getMeasuredWidth() : firstChildLeft;
            while (right > getScrollX()) {
                firstChildIndex -= 1;
                if (firstChildIndex < 0) {
                    firstChildIndex += count;
                }
                View newChild = getView(layerIndex, firstChildIndex);
                addViewInLayout(newChild, 0, new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
                newChild.measure(MeasureSpec.makeMeasureSpec(r - l, MeasureSpec.UNSPECIFIED), MeasureSpec.makeMeasureSpec(b - t, MeasureSpec.AT_MOST));
                right = left;
                left -= newChild.getMeasuredWidth();
                firstChildLeft -= newChild.getMeasuredWidth();
            }
            for (int i = 0; i < getChildCount(); i++) {
                View childAt = getChildAt(i);
                if (left + childAt.getMeasuredWidth() < getScrollX()) {
                    removeViewInLayout(childAt);
                    cache.add(childAt);
                    Iterator<View> iterator = cache.iterator();
                    while (cache.size() > 7) {
                        iterator.next();
                        iterator.remove();
                    }
                    left += childAt.getMeasuredWidth();
                    firstChildLeft = left;
                    firstChildIndex += 1;
                    if (firstChildIndex >= count) firstChildIndex -= count;
                    i--;
                } else if (left > getScrollX() + r - l) {
                    removeViewInLayout(childAt);
                    cache.add(childAt);
                    Iterator<View> iterator = cache.iterator();
                    while (cache.size() > 7) {
                        iterator.next();
                        iterator.remove();
                    }
                    i--;
                } else {
                    Rect outRect = new Rect();
                    Gravity.apply(gravity, childAt.getMeasuredWidth(), childAt.getMeasuredHeight(), new Rect(left, 0, left + childAt.getMeasuredWidth(), getHeight()), outRect);
                    childAt.layout(outRect.left, outRect.top, outRect.right, outRect.bottom);
                    left += childAt.getMeasuredWidth();
                }
            }
            while (left < getScrollX() + getWidth()) {
                View newChild = getView(layerIndex, (firstChildIndex + getChildCount()) % count);
                addViewInLayout(newChild, getChildCount(), new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
                newChild.measure(MeasureSpec.makeMeasureSpec(r - l, MeasureSpec.UNSPECIFIED), MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.AT_MOST));
                Rect outRect = new Rect();
                Gravity.apply(gravity, newChild.getMeasuredWidth(), newChild.getMeasuredHeight(), new Rect(left, 0, left + newChild.getMeasuredWidth(), getHeight()), outRect);
                newChild.layout(outRect.left, outRect.top, outRect.right, outRect.bottom);
                left += newChild.getMeasuredWidth();
            }
        }

        @Override
        protected void onScrollChanged(int l, int t, int oldl, int oldt) {
            super.onScrollChanged(l, t, oldl, oldt);
            int count = adapter.getCount(layerIndex);
            if (count <= 0) return;
            int left = firstChildLeft;
            int right = getChildCount() > 0 ? firstChildLeft + getChildAt(0).getMeasuredWidth() : firstChildLeft;
            while (right > getScrollX()) {
                firstChildIndex -= 1;
                if (firstChildIndex < 0) {
                    firstChildIndex += count;
                }
                View newChild = getView(layerIndex, firstChildIndex);
                addViewInLayout(newChild, 0, new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
                newChild.measure(MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.UNSPECIFIED), MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.AT_MOST));
                Rect outRect = new Rect();
                Gravity.apply(gravity, newChild.getMeasuredWidth(), newChild.getMeasuredHeight(), new Rect(left - newChild.getMeasuredWidth(), 0, left, getHeight()), outRect);
                newChild.layout(outRect.left, outRect.top, outRect.right, outRect.bottom);
                right = left;
                left -= newChild.getMeasuredWidth();
                firstChildLeft -= newChild.getMeasuredWidth();
            }

            for (int i = 0; i < getChildCount(); i++) {
                View childAt = getChildAt(i);
                if (left + childAt.getMeasuredWidth() < getScrollX()) {
                    removeViewInLayout(childAt);
                    cache.add(childAt);
                    Iterator<View> iterator = cache.iterator();
                    while (cache.size() > 7) {
                        iterator.next();
                        iterator.remove();
                    }
                    left += childAt.getMeasuredWidth();
                    firstChildLeft = left;
                    firstChildIndex += 1;
                    if (firstChildIndex >= count) firstChildIndex -= count;
                    i--;
                } else if (left > getScrollX() + getWidth()) {
                    removeViewInLayout(childAt);
                    cache.add(childAt);
                    Iterator<View> iterator = cache.iterator();
                    while (cache.size() > 7) {
                        iterator.next();
                        iterator.remove();
                    }
                    i--;
                } else {
                    left += childAt.getMeasuredWidth();
                }
            }
            while (left < getScrollX() + getWidth()) {
                View newChild = getView(layerIndex, (firstChildIndex + getChildCount()) % count);
                addViewInLayout(newChild, getChildCount(), new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
                newChild.measure(MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.UNSPECIFIED), MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.AT_MOST));
                Rect outRect = new Rect();
                Gravity.apply(gravity, newChild.getMeasuredWidth(), newChild.getMeasuredHeight(), new Rect(left, 0, left + newChild.getMeasuredWidth(), getHeight()), outRect);
                newChild.layout(outRect.left, outRect.top, outRect.right, outRect.bottom);
                left += newChild.getMeasuredWidth();
            }
        }
    }

    private class ScrollUpdater implements Runnable {
        @Override
        public void run() {
            if (!scroller.computeScrollOffset()) {
                if (!aborted) {
                    scrollCenter(false);
                }
            } else {
                scrollToInner(scroller.getCurrX(), scroller.getCurrY());
                post(this);
            }
        }
    }

}
