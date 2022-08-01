package com.vectordigital.commonlibs.ui.floatingfocus;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.TypedArray;
import android.database.DataSetObserver;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.Build;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.Scroller;

import com.vectordigital.commonlibs.R;

import java.util.LinkedList;

/**
 * Created by a.karmanov on 24.06.14.
 */
@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
public abstract class FloatingFocusAdapterView<T extends ListAdapter> extends AdapterView<T> {
    protected static final LayoutParams DEFAULT_LAYOUT_PARAMS = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
    protected static final int SERVICE_VIEWS_COUNT = 1;
    private static final int MAX_VIEW_CACHE_SIZE = 20;
    private static final int SCAN_ID_WINDOW_PREV = 2;
    private static final int SCAN_ID_WINDOW_AFTER = 30;
    private static final int SCROLL_DURATION_DEFAULT = 300;

    private OnScrollListener onScrollListener;

    protected SparseArray<LinkedList<View>> cache = new SparseArray<LinkedList<View>>();
    protected LinkedList<Integer> viewTypes = new LinkedList<Integer>();

    private LoadersAdapter adapter;
    private LayoutStrategy layoutStrategy;
    private FocusStrategy focusStrategy;
    private ScrollStrategy scrollStrategy;
    private int selectedIndex = 0;
    private View focusView;
    private int adapterCount = -1;
    private long selectedId;

    private boolean dataSetChanged = true;

    private int targetSelection;
    private Scroller focusScroller;
    private Scroller viewScrollScroller;
    private Runnable viewUpdater = new ViewUpdateRunnable();

    private View headerLoader;
    private View footerLoader;
    private boolean headerLoaderEnabled;
    private boolean footerLoaderEnabled;
    private DataSetObserver listObserver = new InternalDataSetObserver();
    private OnChangedRunnable onChangeAction = new OnChangedRunnable();
    private OnInvalidateRunnable onInvalidateAction = new OnInvalidateRunnable();

    private int scrollDuration = SCROLL_DURATION_DEFAULT;

    public FloatingFocusAdapterView(Context context) {
        super(context);
        init(null, 0);
    }

    public FloatingFocusAdapterView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(attrs, 0);
    }

    public FloatingFocusAdapterView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(attrs, defStyle);
    }

    public void setScrollDuration(int scrollDuration) {
        this.scrollDuration = scrollDuration;
    }

    private void init(AttributeSet attributeSet, int defStyle) {
        focusView = new View(getContext());
        focusView.setDuplicateParentStateEnabled(true);
        focusScroller = new Scroller(getContext());
        viewScrollScroller = new Scroller(getContext());

        LayoutInflater inflater = (LayoutInflater) getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        if (attributeSet != null) {
            TypedArray typedArray = getContext().obtainStyledAttributes(attributeSet, R.styleable.FloatingFocusAdapterView, 0, 0);
            int selectorBg = typedArray.getResourceId(R.styleable.FloatingFocusAdapterView_selector, 0);
            if (selectorBg != 0) {
                focusView.setBackgroundDrawable(getResources().getDrawable(selectorBg));
            } else {
                focusView.setBackgroundColor(0xff237A3C);
            }
            int headerLoader = typedArray.getResourceId(R.styleable.FloatingFocusAdapterView_headerLoader, 0);
            if (headerLoader != 0) {
                this.headerLoader = inflater.inflate(headerLoader, this, false);
            }
            int footerLoader = typedArray.getResourceId(R.styleable.FloatingFocusAdapterView_footerLoader, 0);
            if (footerLoader != 0) {
                this.footerLoader = inflater.inflate(footerLoader, this, false);
            }
            this.headerLoaderEnabled = typedArray.getBoolean(R.styleable.FloatingFocusAdapterView_headerLoaderEnabled, false);
            this.footerLoaderEnabled = typedArray.getBoolean(R.styleable.FloatingFocusAdapterView_footerLoaderEnabled, false);
            typedArray.recycle();
        } else {
            focusView.setBackgroundColor(0xff237A3C);
            headerLoader = footerLoader = null;
            footerLoaderEnabled = headerLoaderEnabled = false;
        }

    }

    protected void setup(LayoutStrategy layoutStrategy, FocusStrategy focusStrategy, ScrollStrategy scrollStrategy) {
        this.layoutStrategy = layoutStrategy;
        this.focusStrategy = focusStrategy;
        this.scrollStrategy = scrollStrategy;
    }

    public void setOnScrollListener(OnScrollListener onScrollListener) {
        this.onScrollListener = onScrollListener;
    }

    @Override
    public T getAdapter() {
        return (T) adapter;
    }

    @Override
    public void setAdapter(T adapter) {
        if (this.adapter != null) {
            this.adapter.unregisterDataSetObserver(this.listObserver);
        }
        if (adapter != null) {
            this.adapter = new LoadersAdapter(adapter, headerLoader, footerLoader);
            this.adapter.setFooterLoaderEnabled(footerLoaderEnabled);
            this.adapter.setHeaderLoaderEnabled(headerLoaderEnabled);
        } else {
            this.adapter = null;
        }
        if (this.adapter != null) {
            this.adapter.registerDataSetObserver(listObserver);
        }

        resetView();
    }

    @Override
    public int getSelectedItemPosition() {
        return selectedIndex;
    }

    @Override
    public long getSelectedItemId() {
        return selectedId;
    }

    @Override
    public Object getSelectedItem() {
        if (selectedIndex < 0 || selectedIndex >= getAdapterCount()) return null;
        return adapter.getItem(selectedIndex);
    }

    public View getHeaderLoader() {
        return headerLoader;
    }

    public void setHeaderLoader(View headerLoader) {
        this.headerLoader = headerLoader;
        if (adapter != null) {
            adapter.setHeaderLoader(headerLoader);
        }
    }

    public View getFooterLoader() {
        return footerLoader;
    }

    public void setFooterLoader(View footerLoader) {
        this.footerLoader = footerLoader;
        if (adapter != null) {
            adapter.setFooterLoader(footerLoader);
        }
    }

    public boolean isHeaderLoaderEnabled() {
        return headerLoaderEnabled;
    }

    public void setHeaderLoaderEnabled(boolean headerLoaderEnabled) {
        if (this.headerLoaderEnabled == headerLoaderEnabled) return;
        this.headerLoaderEnabled = headerLoaderEnabled;
        if (adapter != null) {
            adapter.setHeaderLoaderEnabled(headerLoaderEnabled);
        }
    }

    public boolean isFooterLoaderEnabled() {
        return footerLoaderEnabled;
    }

    public void setFooterLoaderEnabled(boolean footerLoaderEnabled) {
        if (this.footerLoaderEnabled == footerLoaderEnabled) return;
        this.footerLoaderEnabled = footerLoaderEnabled;
        if (adapter != null) {
            adapter.setFooterLoaderEnabled(footerLoaderEnabled);
        }
    }

    private void resetView() {
//        log.fine("resetView()");
        removeAllViewsInLayout();
        setFocusable(true);
        cache.clear();
        selectedIndex = -1;
        selectedId = -1;
        adapterCount = -1;
        if (adapter != null) {
            for (int i = 0; i < adapter.getViewTypeCount(); i++) {
                cache.put(i, new LinkedList<View>());
            }
        }
        dataSetChanged = true;
        viewScrollScroller.abortAnimation();
        focusScroller.abortAnimation();
        requestLayout();
    }

    int getViewTypeAt(int index) {
        if (index < 0) {
            return Adapter.IGNORE_ITEM_VIEW_TYPE;
        }
        if (index >= getChildCount()) {
            return Adapter.IGNORE_ITEM_VIEW_TYPE;
        }
        return viewTypes.get(index);
    }

    boolean verifyViewAt(int childIndex, int adapterPos) {
        View childAt = getChildAt(childIndex);
        detachViewFromParent(childIndex);
        View view = adapter.getView(adapterPos, childAt, this);
        if (view != childAt) {
            removeViewInLayout(childAt);
            addViewInLayout(view, childIndex, view.getLayoutParams() != null?view.getLayoutParams():DEFAULT_LAYOUT_PARAMS);
            return false;
        } else {
            attachViewToParent(childAt, childIndex, childAt.getLayoutParams() != null?childAt.getLayoutParams():DEFAULT_LAYOUT_PARAMS);
            return true;
        }
    }

    @Override
    public View getSelectedView() {
        return focusScroller.isFinished() ? layoutStrategy.getViewByAdapterIndex(this, selectedIndex) : null;
    }

    @Override
    public void setSelection(int position) {
//        log.fine("setSelection() position: "+position);
        if (selectedIndex == position) return;
        selectedIndex = position;
        selectedId = adapter.getItemId(selectedIndex);
        dataSetChanged = true;
        focusScroller.abortAnimation();
        viewScrollScroller.abortAnimation();
        if (layoutStrategy.getViewByAdapterIndex(this, position) == null) {
//            log.fine("setSelection()= removeAllViewsInLayout");
            removeAllViewsInLayout();
        }
        requestLayout();
    }

    protected View makeView(int index) {
        int itemViewType = adapter.getItemViewType(index);
        View cachedView = null;
        if (itemViewType != Adapter.IGNORE_ITEM_VIEW_TYPE) {
            LinkedList<View> cacheList = cache.get(itemViewType);
            if (cacheList.size() > 0) {
                cachedView = cacheList.get(0);
                cacheList.remove(0);
            }
        }
        View result = adapter.getView(index, cachedView, this);
        result.setSelected(false);
        result.setActivated(false);
        result.setDuplicateParentStateEnabled(true);
        return result;
    }

    @Override
    public int getCount() {
        return getAdapterCount();
    }

    private int getAdapterCount() {
        if (adapterCount < 0) {
            adapterCount = adapter != null ? adapter.getCount() : 0;
            if (adapterCount == 0) {
                selectedIndex = -1;
                selectedId = -1;
            } else if (selectedIndex >= adapterCount || selectedIndex < 0) {
                selectedIndex = 0;
                selectedId = adapter.getItemId(0);
            }
        }
        return adapterCount;
    }

    @Override
    public int getFirstVisiblePosition() {
        return layoutStrategy.getFirstVisiblePosition(this);
    }

    @Override
    public int getLastVisiblePosition() {
        return layoutStrategy.getFirstVisiblePosition(this) + layoutStrategy.getVisibleItemsCount(this);
    }

    public int getVisibleItemsCount(){
        return layoutStrategy.getVisibleItemsCount(this);
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
//        log.fine("onLayout() changed: "+changed+", dataSetChanged: "+dataSetChanged);
        if (!changed && !dataSetChanged) {
//            log.fine("onLayout()= fast relayout");
            for (int i = 0; i < getChildCount(); i++) {
                View child = getChildAt(i);
                child.layout(child.getLeft(), child.getTop(), child.getRight(), child.getBottom());
            }
            return;
        }
        dataSetChanged = false;
        if (getAdapterCount() == 0) {
//            log.fine("onLayout()= adapter count = 0");
            return;
        }
        if (!viewScrollScroller.isFinished() || !focusScroller.isFinished()) {
//            log.fine("onLayout()= scrollers is not finished");
            return;
        }

        if (selectedIndex < 0) {
            selectedIndex = 0;
            selectedId = adapter.getItemId(selectedIndex);
        }
//        log.fine("onLayout()= selectedId: "+selectedId+", selectedIndex: "+selectedIndex);

        if ((getSelectedView() == null && getChildCount() != 0) || changed) {
//            log.fine("onLayout()= removeAllViewsInLayout");
            removeAllViewsInLayout();
        }

        if (getChildCount() == 0) {
            addViewInLayout(focusView, 0, DEFAULT_LAYOUT_PARAMS);
        }

        if (getChildCount() == SERVICE_VIEWS_COUNT) {
            Point initialScroll = scrollStrategy.getInitialScroll(this, selectedIndex);
            if (initialScroll != null) {
                scrollTo(initialScroll.x, initialScroll.y);
            }
            LayoutTask[] layoutTasks = layoutStrategy.initialLayoutPrepare(this, selectedIndex, getAdapterCount());
            applyLayout(layoutTasks);
        } else {
            Point newScroll = scrollStrategy.onTargetSelectionChanged(this, getSelectedView(), selectedIndex);
            if (newScroll.x != getScrollX() || newScroll.y != getScrollY()) {
                scrollTo(newScroll.x, newScroll.y);
            }
            LayoutTask[] layoutTasks = layoutStrategy.updateLayout(this, selectedIndex, getAdapterCount(), true);
            applyLayout(layoutTasks);

            boolean focusUpdated = false;
            for (LayoutTask layoutTask : layoutTasks) {
                if (layoutTask.adapterIndex == selectedIndex) {
                    focusUpdated = true;
                }
            }
            if (!focusUpdated) {
                View selectedView = getSelectedView();
                focusStrategy.applyFocus(selectedView, focusView, new Rect(selectedView.getLeft(), selectedView.getTop(), selectedView.getRight(), selectedView.getBottom()));
            }
        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        return processScrollKey(keyCode, event.getEventTime()) || processSubmitKey(keyCode) || super.onKeyDown(keyCode, event);
    }

    @Override
    public boolean onKeyMultiple(int keyCode, int repeatCount, KeyEvent event) {
        return processScrollKey(keyCode, event.getEventTime()) || super.onKeyMultiple(keyCode, repeatCount, event);
    }

    public View getViewByAdapterIndex(int index){
        return layoutStrategy.getViewByAdapterIndex(this, index);
    }

    private boolean processScrollKey(int keyCode, long eventTime) {
        if (getAdapterCount() == 0) return false;
        boolean scrolled = focusScroller.isFinished() && viewScrollScroller.isFinished();

        int tSelection;
        if (scrolled) {
            tSelection = selectedIndex;
        } else {
            tSelection = targetSelection;
        }
        int targetSelection = -1;
        switch (keyCode) {
            case KeyEvent.KEYCODE_DPAD_UP:
                targetSelection = layoutStrategy.calculateNextFocus(this, tSelection, LayoutStrategy.UP, getAdapterCount());
                break;
            case KeyEvent.KEYCODE_DPAD_DOWN:
                targetSelection = layoutStrategy.calculateNextFocus(this, tSelection, LayoutStrategy.DOWN, getAdapterCount());
                break;
            case KeyEvent.KEYCODE_DPAD_LEFT:
                targetSelection = layoutStrategy.calculateNextFocus(this, tSelection, LayoutStrategy.LEFT, getAdapterCount());
                break;
            case KeyEvent.KEYCODE_DPAD_RIGHT:
                targetSelection = layoutStrategy.calculateNextFocus(this, tSelection, LayoutStrategy.RIGHT, getAdapterCount());
                break;
        }
//        log.fine("processScrollKey()= targetSelection: "+targetSelection+", isLayoutRequested() "+isLayoutRequested());
        if (targetSelection < 0) {
            return false;
        }

        if (isLayoutRequested()) return true;

        focusScroller.abortAnimation();
        viewScrollScroller.abortAnimation();

        LayoutTask[] layoutTasks = layoutStrategy.fillToIndex(this, targetSelection, getAdapterCount());
        for (LayoutTask layoutTask : layoutTasks) {
            getChildAt(layoutTask.childIndex).layout(layoutTask.childPosition.left, layoutTask.childPosition.top, layoutTask.childPosition.right, layoutTask.childPosition.bottom);
        }
        View targetFocus = layoutStrategy.getViewByAdapterIndex(this, targetSelection);
        View currentFocus = layoutStrategy.getViewByAdapterIndex(this, selectedIndex);

        if (getAdapter().isEnabled(targetSelection)) {
            focusStrategy.initMove(scrolled ? currentFocus : null, targetFocus, scrolled ? selectedIndex : -1, targetSelection);
            focusScroller.startScroll(0, 0, 1000, 0, scrollDuration);
            this.targetSelection = targetSelection;
            if (scrolled && onScrollListener != null) {
                onScrollListener.onSelectorScrollStart(this, selectedIndex);
            }
        }

        Point newScroll = scrollStrategy.onTargetSelectionChanged(this, targetFocus, targetSelection);

        if (newScroll.x != getScrollX() || newScroll.y != getScrollY()) {
            viewScrollScroller.startScroll(getScrollX(), getScrollY(), newScroll.x - getScrollX(), newScroll.y - getScrollY(), scrollDuration);
        }

        View selectedView = layoutStrategy.getViewByAdapterIndex(this, selectedIndex);

        if (selectedView != null) {
            selectedView.setSelected(false);
            selectedView.setActivated(false);
        }


        if (scrolled) {
            post(viewUpdater);
        }

        return true;
    }



    private boolean processSubmitKey(int keycode) {
        if (keycode != KeyEvent.KEYCODE_ENTER && keycode != KeyEvent.KEYCODE_NUMPAD_ENTER && keycode != KeyEvent.KEYCODE_DPAD_CENTER)
            return false;
        if (!focusScroller.isFinished()) return false;
        if (getOnItemClickListener() == null) return false;
        getOnItemClickListener().onItemClick(this, layoutStrategy.getViewByAdapterIndex(this, selectedIndex), selectedIndex, selectedId);
        return true;
    }

    @Override
    protected boolean addViewInLayout(View child, int index, LayoutParams params) {
        viewTypes.add(index, layoutStrategy.getChildViewType(this, index));
        return super.addViewInLayout(child, index, params);
    }

    @Override
    protected void onScrollChanged(int l, int t, int oldl, int oldt) {
        super.onScrollChanged(l, t, oldl, oldt);
        if (isLayoutRequested()) return;
        LayoutTask[] layoutTasks = layoutStrategy.updateLayout(this, focusScroller.isFinished() ? selectedIndex : targetSelection, getAdapterCount(), false);
        applyLayout(layoutTasks);
        if (onScrollListener != null) {
            int firstVisible = -1;
            int lastVisible = -2;
            for (int i = SERVICE_VIEWS_COUNT; i < getChildCount(); i++) {
                View child = getChildAt(i);
                boolean leftInBounds = child.getLeft() >= getScrollX() && child.getLeft() <= getScrollX() + getWidth();
                boolean rightInBounds = child.getRight() >= getScrollX() && child.getRight() <= getScrollX() + getWidth();
                boolean viewHorizontalInBounds = child.getLeft() < getScrollX() && child.getRight() > getScrollX() + getWidth();
                boolean topInBounds = child.getTop() >= getScrollY() && child.getTop() <= getScrollY() + getHeight();
                boolean bottomInBounds = child.getBottom() >= getScrollY() && child.getBottom() <= getScrollY() + getHeight();
                boolean viewVerticalInBounds = child.getTop() < getScrollY() && child.getBottom() > getScrollY() + getHeight();

                if ((leftInBounds || rightInBounds || viewHorizontalInBounds) && (topInBounds || bottomInBounds || viewVerticalInBounds)) {
                    if (firstVisible == -1) {
                        firstVisible = i;
                    }
                    lastVisible = i;
                }
            }
            onScrollListener.onScroll(this, layoutStrategy.getAdapterIndex(firstVisible), lastVisible - firstVisible + 1, getAdapterCount());
        }
    }

    private void applyLayout(LayoutTask[] layoutTasks) {
        for (LayoutTask layoutTask : layoutTasks) {
            View childAt = getChildAt(layoutTask.childIndex);
            if (layoutTask.adapterIndex == selectedIndex && focusScroller.isFinished()) {
                focusStrategy.applyFocus(childAt, focusView, layoutTask.childPosition);
                if (hasFocus()) {
                    childAt.setSelected(true);
                    childAt.setActivated(true);
                }
            } else {
                childAt.layout(layoutTask.childPosition.left, layoutTask.childPosition.top, layoutTask.childPosition.right, layoutTask.childPosition.bottom);
            }
        }
    }

    @Override
    public void removeViewInLayout(View view) {
        int index = indexOfChild(view);
        if (index >= 0 && index < getChildCount()) {
            int viewType = viewTypes.get(index);
            if (viewType != Adapter.IGNORE_ITEM_VIEW_TYPE) {
                LinkedList<View> views = cache.get(viewType);
                if (views.size() < MAX_VIEW_CACHE_SIZE) {
                    views.add(view);
                }
            }
        }
        super.removeViewInLayout(view);
        viewTypes.remove(index);
    }

    @Override
    public void removeViewsInLayout(int start, int count) {
        if (start < SERVICE_VIEWS_COUNT)
            throw new IllegalArgumentException("Can't remove service views");
        for (int i = 0; i < count; i++) {
            if (i + start >= 0 && i + start < getChildCount()) {
                int viewType = viewTypes.get(i + start);
                if (viewType != Adapter.IGNORE_ITEM_VIEW_TYPE) {
                    LinkedList<View> views = cache.get(viewType);
                    if (views.size() < MAX_VIEW_CACHE_SIZE) {
                        views.add(getChildAt(i + start));
                    }
                }
            }
        }
        for (int i = count - 1; i >= 0; i--) {
            if (i + start >= 0 && i + start < getChildCount()) {
                viewTypes.remove(i + start);
            }
        }
        super.removeViewsInLayout(start, count);
    }

    @Override
    public void removeAllViewsInLayout() {
        for (int i = 1; i < getChildCount(); i++) {
            int viewType = viewTypes.get(i);
            if (viewType != Adapter.IGNORE_ITEM_VIEW_TYPE) {
                LinkedList<View> views = cache.get(viewType);
                if (views.size() < MAX_VIEW_CACHE_SIZE) {
                    views.add(getChildAt(i));
                }
            }
        }
        viewTypes.clear();
        super.removeAllViewsInLayout();
    }

    protected void onInvalidate() {
        resetView();
    }

    protected void onChange() {
//        log.fine("onChange() [selectedId: "+selectedId+"]");
        if (selectedId < 0) {
            resetView();
            return;
        }

        int newSelectedIndex = -1;
        for (int i = Math.max(selectedIndex - SCAN_ID_WINDOW_PREV, 0); i < Math.min(selectedIndex + SCAN_ID_WINDOW_AFTER, getAdapterCount()); i++) {
            if (adapter.getItemId(i) == selectedId) {
                newSelectedIndex = i;
                break;
            }
        }

        if (newSelectedIndex == -1) {
//            log.fine("onChange()= reset view()");
            resetView();
            return;
        }

        layoutStrategy.offsetSelectionWithoutLayout(this, newSelectedIndex - selectedIndex);
        targetSelection += newSelectedIndex - selectedIndex;
        selectedIndex = newSelectedIndex;
//        log.fine("isLayoutRequested() "+isLayoutRequested());
        if (isLayoutRequested()) return;
        LayoutTask[] layoutTasks = layoutStrategy.updateLayout(this, selectedIndex, getAdapterCount(), true);
        applyLayout(layoutTasks);
    }

    public static interface OnScrollListener {

        public void onSelectorScrollStart(FloatingFocusAdapterView<?> owner, int position);

        public void onSelectorScrollEnd(FloatingFocusAdapterView<?> owner, int position);

        public void onScroll(FloatingFocusAdapterView<?> owner, int firstVisibleItem, int visibleItemCount, int totalItemCount);
    }

    @Override
    protected void onFocusChanged(boolean gainFocus, int direction, Rect previouslyFocusedRect) {
        super.onFocusChanged(gainFocus, direction, previouslyFocusedRect);
//        if(!gainFocus){
            for(int i = 0; i < getChildCount(); i++){
                View childAt = getChildAt(i);
                childAt.setActivated(gainFocus && childAt.isSelected());
            }
//        }
    }

    private class ViewUpdateRunnable implements Runnable {

        @Override
        public void run() {
            boolean posted = false;
            if (focusScroller.computeScrollOffset()) {
                focusStrategy.updateFocusState(FloatingFocusAdapterView.this, focusView, focusScroller.getCurrX() / 1000d);
            }
            if (!focusScroller.isFinished()) {
                post(this);
                posted = true;
            } else {
                if (selectedIndex != targetSelection) {
                    selectedIndex = targetSelection;
                    selectedId = adapter.getItemId(selectedIndex);
                    if (onScrollListener != null) {
                        onScrollListener.onSelectorScrollEnd(FloatingFocusAdapterView.this, selectedIndex);
                    }
                    View selectedView = layoutStrategy.getViewByAdapterIndex(FloatingFocusAdapterView.this, selectedIndex);
                    if (selectedView != null) {
                        selectedView.setSelected(true);
                        selectedView.setActivated(true);
                        focusStrategy.applyFocus(selectedView, focusView, new Rect(selectedView.getLeft(), selectedView.getTop(), selectedView.getRight(), selectedView.getBottom()));
                    }
                }
            }
            if (viewScrollScroller.computeScrollOffset()) {
                scrollTo(viewScrollScroller.getCurrX(), viewScrollScroller.getCurrY());
            }
            if (!viewScrollScroller.isFinished()) {
                if (!posted) {
                    post(this);
                }
            }
        }
    }

    private class OnChangedRunnable implements Runnable {

        @Override
        public void run() {
            adapterCount = -1;
            onChange();
        }
    }

    private class OnInvalidateRunnable implements Runnable {

        @Override
        public void run() {
            adapterCount = -1;
            onInvalidate();
        }
    }

    private class InternalDataSetObserver extends DataSetObserver {
        @Override
        public void onChanged() {
            onChangeAction.run();
        }

        @Override
        public void onInvalidated() {
            onInvalidateAction.run();
        }
    }
}
