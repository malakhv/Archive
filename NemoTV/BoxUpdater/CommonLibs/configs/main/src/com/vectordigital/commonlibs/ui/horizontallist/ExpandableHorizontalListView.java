package com.vectordigital.commonlibs.ui.horizontallist;

import android.content.Context;
import android.content.res.TypedArray;
import android.database.DataSetObserver;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.AnimationUtils;
import android.view.animation.Transformation;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.Scroller;

import com.vectordigital.commonlibs.R;
import com.vectordigital.commonlibs.animation.CountdownAnimationListener;

import java.util.Iterator;
import java.util.LinkedHashSet;

/**
 * Created by Александр on 30.08.13.
 */
public class ExpandableHorizontalListView extends AdapterView<ListAdapter> implements GestureDetector.OnGestureListener {
    private static final int CACHE_SIZE = 15;
    private ListAdapter adapter;
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
    private LinkedHashSet<View> cache = new LinkedHashSet<View>(CACHE_SIZE * 2);
    private int selection = -1;

    private GestureDetector detector;
    private Scroller scroller;
    private Runnable updateScrollTask = new ScrollUpdater();
    private int firstChildIndex = 0;

    private View preLoader = null;
    private View postLoader = null;
    private boolean preLoaderEnabled = false;
    private boolean postLoaderEnabled = false;
    private int childWidth;
    private int openChildWidth;
    private int gravity = Gravity.CENTER;
    private int minScroll;
    private int maxScroll;

    private Animation openInAnimation;
    private Animation openOutAnimation;
    private Animation closeInAnimation;
    private Animation closeOutAnimation;

    private OnScrollListener scrollListener;
    private int scrollToAfterLayout = -1;
    private Runnable finalRunnable = new Runnable() {
        @Override
        public void run() {
            animationStart = false;
            if (!scroller.computeScrollOffset()) {
                scrollCenter(false);
            }
        }
    };
    private boolean animationStart = false;
    private boolean aborted;


    public ExpandableHorizontalListView(Context context) {
        super(context);
        detector = new GestureDetector(context, this);
        scroller = new Scroller(context);
    }

    public ExpandableHorizontalListView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    public ExpandableHorizontalListView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(context, attrs);
    }

    private void init(Context context, AttributeSet attrs) {
        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.ExpandableHorizontalListView);

        int outAnimation = typedArray.getResourceId(R.styleable.ExpandableHorizontalListView_outAnimation, 0);
        if (outAnimation != 0) {
            closeOutAnimation = AnimationUtils.loadAnimation(context, outAnimation);
            openOutAnimation = AnimationUtils.loadAnimation(context, outAnimation);
        }
        int inAnimation = typedArray.getResourceId(R.styleable.ExpandableHorizontalListView_inAnimation, 0);
        if (inAnimation != 0) {
            openInAnimation = AnimationUtils.loadAnimation(context, inAnimation);
            openOutAnimation = AnimationUtils.loadAnimation(context, inAnimation);
        }
        int closeOutAnimation = typedArray.getResourceId(R.styleable.ExpandableHorizontalListView_closeOutAnimation, this.closeOutAnimation != null ? 0 : R.anim.expandable_horizontal_list_close_out_default);
        if (closeOutAnimation != 0) {
            this.closeInAnimation = AnimationUtils.loadAnimation(context, closeOutAnimation);
        }
        int closeInAnimation = typedArray.getResourceId(R.styleable.ExpandableHorizontalListView_closeInAnimation, this.closeOutAnimation != null ? 0 : R.anim.expandable_horizontal_list_close_in_default);
        if (closeInAnimation != 0) {
            this.closeInAnimation = AnimationUtils.loadAnimation(context, closeInAnimation);
        }
        int openOutAnimation = typedArray.getResourceId(R.styleable.ExpandableHorizontalListView_openOutAnimation, this.closeOutAnimation != null ? 0 : R.anim.expandable_horizontal_list_open_out_default);
        if (openOutAnimation != 0) {
            this.openOutAnimation = AnimationUtils.loadAnimation(context, openOutAnimation);
        }
        int openInAnimation = typedArray.getResourceId(R.styleable.ExpandableHorizontalListView_openInAnimation, this.closeOutAnimation != null ? 0 : R.anim.expandable_horizontal_list_open_in_default);
        if (openInAnimation != 0) {
            this.openInAnimation = AnimationUtils.loadAnimation(context, openInAnimation);
        }

        switch (typedArray.getInt(R.styleable.ExpandableHorizontalListView_gravity, 0)) {
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
        switch (typedArray.getInt(R.styleable.ExpandableHorizontalListView_animationGravity, 0)) {
            case 0:
                gravity |= Gravity.LEFT;
                break;
            case 1:
                gravity = Gravity.CENTER_HORIZONTAL;
                break;
            case 2:
                gravity = Gravity.RIGHT;
                break;
        }
        typedArray.recycle();
        detector = new GestureDetector(context, this);
        scroller = new Scroller(context);
    }

    public void setOpenInAnimation(Animation openInAnimation) {
        this.openInAnimation = openInAnimation;
    }

    public void setOpenOutAnimation(Animation openOutAnimation) {
        this.openOutAnimation = openOutAnimation;
    }

    public void setCloseInAnimation(Animation closeInAnimation) {
        this.closeInAnimation = closeInAnimation;
    }

    public void setCloseOutAnimation(Animation closeOutAnimation) {
        this.closeOutAnimation = closeOutAnimation;
    }

    public void setOnScrollListener(OnScrollListener scrollListener) {
        this.scrollListener = scrollListener;
    }

    @Override
    public ListAdapter getAdapter() {
        return adapter;
    }

    @Override
    public void setAdapter(ListAdapter adapter) {
        if (this.adapter != null) {
            this.adapter.unregisterDataSetObserver(observer);
        }
        this.adapter = adapter;
        selection = -1;
        if (this.adapter != null) {
            this.adapter.registerDataSetObserver(observer);
        }
        onDataSetChanged();
    }

    public void setPreLoader(View preLoader) {
        this.preLoader = preLoader;
        onDataSetChanged();
    }

    public void setPostLoader(View postLoader) {
        this.postLoader = postLoader;
        onDataSetChanged();
    }

    @Override
    public View getSelectedView() {
        return getView(selection);
    }

    @Override
    public void setSelection(int position) {
        selection = position;
    }

    private View getView(int selectedPosition) {
        View view = null;
        if (cache.size() > 0) {
            Iterator<View> iterator = cache.iterator();
            view = iterator.next();
            iterator.remove();
        }
        view = adapter.getView(selectedPosition, view, this);
        if (selectedPosition == selection) {
            view.findViewById(R.id.front).setVisibility(GONE);
            view.findViewById(R.id.backside).setVisibility(VISIBLE);
        } else {
            view.findViewById(R.id.front).setVisibility(VISIBLE);
            view.findViewById(R.id.backside).setVisibility(GONE);
        }
        return view;
    }

    private void onDataSetChanged() {
//        for (int i = 0; i < getChildCount(); i++){
//            cache.add(getChildAt(i));
//        }
//        while (cache.size() > CACHE_SIZE) {
//            Iterator<View> iterator = cache.iterator();
//            iterator.next();
//            iterator.remove();
//        }
        cache.clear();
        removeAllViewsInLayout();
        requestLayout();
        postInvalidate();
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        boolean b = detector.onTouchEvent(event);
        if ((event.getAction() == MotionEvent.ACTION_UP || event.getAction() == MotionEvent.ACTION_CANCEL) && !scroller.computeScrollOffset()) {
            scrollCenter(false);
        }
        return true;
    }

    @Override
    public boolean onInterceptTouchEvent(MotionEvent ev) {
        return detector.onTouchEvent(ev);
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        if (animationStart) return;
        if (adapter == null || adapter.getCount() == 0) {
            minScroll = preLoaderEnabled ? -preLoader.getMeasuredWidth() : 0;
            maxScroll = Math.max((postLoaderEnabled ? postLoader.getMeasuredWidth() : 0) - getWidth(), minScroll);
            if (getScrollX() < minScroll) scrollTo(minScroll, 0);
            if (getScrollX() > maxScroll) scrollTo(maxScroll, 0);
            return;
        }

        if (preLoaderEnabled) {
            measureChild(preLoader);
        }
        if (postLoaderEnabled) {
            measureChild(preLoader);
        }

        View testView = getView(0);
        childWidth = getChildWidth(testView);
        testView.findViewById(R.id.front).setVisibility(GONE);
        testView.findViewById(R.id.backside).setVisibility(VISIBLE);
        openChildWidth = getChildWidth(testView);

        cache.add(testView);

        Iterator<View> iterator = cache.iterator();
        while (cache.size() > CACHE_SIZE) {
            iterator.next();
            iterator.remove();
        }
        minScroll = preLoaderEnabled ? -preLoader.getMeasuredWidth() : 0 - getWidth() / 2;
        maxScroll = Math.max((postLoaderEnabled ? postLoader.getMeasuredWidth() : 0) + (selection < 0 ? adapter.getCount() * childWidth : adapter.getCount() * childWidth - childWidth + openChildWidth) - getWidth(), minScroll) + getWidth() / 2;
        if (scrollToAfterLayout >= 0) {
            scrollTo(Math.max(Math.min(scrollToAfterLayout * childWidth - (getWidth() / 2 - (scrollToAfterLayout == selection ? openChildWidth : childWidth) / 2) + (selection >= 0 && selection < scrollToAfterLayout ? openChildWidth - childWidth : 0), maxScroll), minScroll), 0);
            scrollToAfterLayout = -1;
        }
        if (getScrollX() < minScroll) scrollTo(minScroll, 0);
        if (getScrollX() > maxScroll) scrollTo(maxScroll, 0);

        removeViews();

        int firstLeft = 0;
        int lastRight = 0;

        if (getChildCount() == 0) {
            int centerX = getScrollX() + getWidth() / 2 - 10;
            int index = centerX / childWidth;
            View centerView = getView(index);
            int viewLeft = (centerX / childWidth) * childWidth + (selection >= 0 && selection < index ? -childWidth + openChildWidth : 0);

            layoutChild(centerView, viewLeft, true);

            firstLeft = centerView.getLeft();
            lastRight = centerView.getRight();

            firstChildIndex = index;
        } else {
            for (int i = 0; i < getChildCount(); i++) {
                View child = getChildAt(i);
                layoutChild(child, i > 0 ? getChildAt(i - 1).getRight() : firstChildIndex * childWidth + (selection >= 0 && selection < firstChildIndex ? openChildWidth - childWidth : 0), true);
                if (i == 0) {
                    firstLeft = child.getLeft();
                }
                lastRight = child.getRight();
            }
        }

        fillLeft(firstLeft);
        fillRight(lastRight);
    }

    public View getViewAt(int index) {
        return getChildAt(index - firstChildIndex);
    }

    public void scrollToIndexPosition(final int position) {
        scroller.abortAnimation();
        if (isLayoutRequested()) {
            scrollToAfterLayout = position;
        } else {
            scrollTo(Math.max(Math.min(position * childWidth - (getWidth() / 2 - (position == selection ? openChildWidth : childWidth) / 2) + (selection >= 0 && selection < position ? openChildWidth - childWidth : 0), maxScroll), minScroll), 0);
        }
        postInvalidate();
    }

    @Override
    protected void onScrollChanged(int l, int t, int oldl, int oldt) {
        super.onScrollChanged(l, t, oldl, oldt);
        if (animationStart) return;
        if (isLayoutRequested()) return;
        removeViews();

        int firstLeft;
        int lastRight;


        if (getChildCount() == 0) {
            int centerX = getScrollX() + getWidth() / 2;
            int index = centerX / childWidth;
            Iterator<View> iterator = cache.iterator();
            while (cache.size() > 7) {
                iterator.next();
                iterator.remove();
            }
            View centerView = getView(index);
            int viewLeft = (centerX / childWidth) * childWidth + (selection >= 0 && selection < index ? -childWidth + openChildWidth : 0);

            layoutChild(centerView, viewLeft, true);

            firstLeft = centerView.getLeft();
            lastRight = centerView.getRight();

            firstChildIndex = index;
        } else {
            firstLeft = getChildAt(0).getLeft();
            lastRight = getChildAt(getChildCount() - 1).getRight();
        }

        fillLeft(firstLeft);
        fillRight(lastRight);
        if (scrollListener != null) {
            int firstVisiblePosition = getChildCount();
            int lastVisiblePosition = 0;
            for (int i = 0; i < getChildCount(); i++) {
                if (i < firstVisiblePosition && getChildAt(i).getRight() > getScrollX()) {
                    firstVisiblePosition = i;
                }
                if (i > lastVisiblePosition && getChildAt(i).getLeft() < getScrollX() + getWidth()) {
                    lastVisiblePosition = i;
                }
            }
            scrollListener.onScroll(this, firstVisiblePosition + firstChildIndex, lastVisiblePosition - firstVisiblePosition, adapter.getCount());
        }
    }

    private void layoutChild(View centerView, int left, boolean measure) {
        if (measure) {
            measureChild(centerView);
        }
        Rect outRect = new Rect();
        Gravity.apply(gravity, centerView.getMeasuredWidth(), centerView.getMeasuredHeight(), new Rect(left, 0, centerView.getMeasuredWidth() + left, getHeight()), outRect);
        if (centerView.getLeft() == outRect.left && centerView.getRight() == outRect.right && centerView.getTop() == outRect.top && centerView.getBottom() == outRect.bottom)
            return;
        centerView.layout(outRect.left, outRect.top, outRect.right, outRect.bottom);
    }

    private void fillRight(int lastRight) {
        int count = adapter.getCount();
        int right = lastRight;
        while (right < getScrollX() + (getWidth() * 2) && ((firstChildIndex + getChildCount() < count + 1 && postLoaderEnabled) || firstChildIndex + getChildCount() < count)) {
            View newChild;
            if (firstChildIndex + getChildCount() < count) {
                newChild = getView(firstChildIndex + getChildCount());
            } else {
                newChild = postLoader;
            }
            addViewInLayout(newChild, getChildCount(), newChild.getLayoutParams() != null ? newChild.getLayoutParams() : new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
            layoutChild(newChild, right, true);
            right = newChild.getRight();
        }
    }

    private void fillLeft(int firstLeft) {
        int left = firstLeft;
        while (left > getScrollX() - getWidth() && ((firstChildIndex > -1 && preLoaderEnabled) || firstChildIndex > 0)) {
            firstChildIndex -= 1;
            View newChild;
            if (firstChildIndex < 0) {
                newChild = preLoader;
            } else {
                newChild = getView(firstChildIndex);
            }
            int childWidth = getChildWidth(newChild);
            addViewInLayout(newChild, 0, newChild.getLayoutParams() != null ? newChild.getLayoutParams() : new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
            layoutChild(newChild, left - childWidth, newChild.getLayoutParams() != null && newChild.getLayoutParams().width != LayoutParams.WRAP_CONTENT);
            left = newChild.getLeft();
        }
    }

    private void measureChild(View centerView) {
        LayoutParams layoutParams;

        layoutParams = centerView.getLayoutParams();
        if (layoutParams == null)
            layoutParams = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);

        int widthMeasureSpec = 0;
        int heightMeasureSpec = 0;
        if (layoutParams.width == LayoutParams.MATCH_PARENT) {
            widthMeasureSpec = MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.EXACTLY);
        }
        if (layoutParams.width >= 0) {
            widthMeasureSpec = MeasureSpec.makeMeasureSpec(layoutParams.width, MeasureSpec.EXACTLY);
        }
        if (layoutParams.width == LayoutParams.WRAP_CONTENT) {
            widthMeasureSpec = MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.UNSPECIFIED);
        }
        if (layoutParams.height == LayoutParams.MATCH_PARENT) {
            heightMeasureSpec = MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.EXACTLY);
        }
        if (layoutParams.height >= 0) {
            heightMeasureSpec = MeasureSpec.makeMeasureSpec(layoutParams.height, MeasureSpec.EXACTLY);
        }
        if (layoutParams.height == LayoutParams.WRAP_CONTENT) {
            heightMeasureSpec = MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.AT_MOST);
        }
        if (centerView.getParent() == null) {
            addViewInLayout(centerView, 0, layoutParams);
        }
        centerView.measure(widthMeasureSpec, heightMeasureSpec);
    }

    private int getChildWidth(View testView) {
        LayoutParams layoutParams = testView.getLayoutParams();
        if (layoutParams == null)
            layoutParams = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        int childWidth = 1;
        if (layoutParams.width == LayoutParams.MATCH_PARENT) childWidth = getWidth();
        if (layoutParams.width > 0) childWidth = layoutParams.width;
        if (layoutParams.width == LayoutParams.WRAP_CONTENT) {
            testView.measure(MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.AT_MOST), MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.AT_MOST));
            childWidth = testView.getMeasuredWidth();
        }
        return childWidth;
    }

    private void scrollCenter(boolean immediate) {
        if (adapter == null || adapter.getCount() == 0) return;
        int distance = Integer.MAX_VALUE;
        int viewCenter = getWidth() / 2 + getScrollX();
        for (int i = 0; i < getChildCount(); i++) {
            View childAt = getChildAt(i);
            int childCenter = (childAt.getLeft() + childAt.getRight()) / 2;
            if (Math.abs(distance) > Math.abs(viewCenter - childCenter)) {
                distance = childCenter - viewCenter;
            }
        }
        if (distance != 0) {
            if (!immediate) {
                scroller.startScroll(getScrollX(), getScrollY(), distance, 0, 600);
                aborted = false;
                post(updateScrollTask);
            } else {
                scrollTo(getScrollX() + distance, getScrollY());
            }
        }
    }


    private void removeViews() {
        for (int i = 0; i < getChildCount(); i++) {
            View child = getChildAt(i);
            if (child.getRight() < getScrollX() - getWidth() || child.getLeft() > getScrollX() + getWidth() * 2) {
                removeViewInLayout(child);
                if (child == preLoader) continue;
                if (child == postLoader) continue;
                cache.add(child);
                Iterator<View> iterator = cache.iterator();
                while (cache.size() > CACHE_SIZE) {
                    iterator.next();
                    iterator.remove();
                }
                if (i == 0) {
                    firstChildIndex += 1;
                }
                i--;
            }
        }
    }

    @Override
    public boolean onDown(MotionEvent e) {
        scroller.abortAnimation();
        return false;
    }

    @Override
    public void onShowPress(MotionEvent e) {
    }

    @Override
    public boolean onSingleTapUp(MotionEvent e) {
        if (animationStart) return true;
        float x = e.getX();
        float y = e.getY();
        int childIndex = -1;
        for (int i = 0; i < getChildCount(); i++) {
            View childAt = getChildAt(i);
            if (childAt.getTop() <= y && childAt.getBottom() >= y && childAt.getLeft() - getScrollX() <= x && childAt.getRight() - getScrollX() > x) {
                childIndex = i;
            }
        }
        int selectionT = childIndex + firstChildIndex;
        if (selectionT < 0 || (selectionT > adapter.getCount())) return true;
        View childAt = getChildAt(childIndex);
        if (childAt == null) return true;
        animationStart = true;
        if (selectionT == selection) {
            closeOutAnimation.start();
            closeInAnimation.start();
            CloseAnimationAdapter closeAnimationAdapter = new CloseAnimationAdapter(closeOutAnimation, selectionT, false, new CountdownAnimationListener(1, finalRunnable));
            childAt.startAnimation(closeAnimationAdapter);

            selection = -1;
        } else {
            openInAnimation.start();
            openOutAnimation.start();
            final View childAt1 = getChildAt(selection - firstChildIndex);
            if (childAt1 != null) {
                closeInAnimation.start();
                closeInAnimation.start();
                CountdownAnimationListener listener = new CountdownAnimationListener(2, finalRunnable);
                CloseAnimationAdapter closeAnimationAdapter = new CloseAnimationAdapter(closeOutAnimation, selection, false, listener);
                childAt1.startAnimation(closeAnimationAdapter);

                closeAnimationAdapter = new CloseAnimationAdapter(openOutAnimation, selectionT, true, listener);
                childAt.startAnimation(closeAnimationAdapter);

            } else {
                if (selection >= 0 && selection < firstChildIndex) {
                    for (int i = 0; i < getChildCount(); i++) {
                        getChildAt(i).offsetLeftAndRight(childWidth - openChildWidth);
                    }
                    scrollBy(childWidth - openChildWidth, 0);
                }

                CloseAnimationAdapter closeAnimationAdapter = new CloseAnimationAdapter(openOutAnimation, selectionT, true, new CountdownAnimationListener(1, finalRunnable));
                childAt.startAnimation(closeAnimationAdapter);
            }

            selection = selectionT;

            int dx = (selection) * childWidth + childWidth / 2 - getWidth() / 2 - getScrollX();
            if (dx != 0) {
                scroller.startScroll(getScrollX(), getScrollY(), (selection) * childWidth + openChildWidth / 2 - getWidth() / 2 - getScrollX(), 0, 1100);
                post(updateScrollTask);
            }

        }
        return true;
    }

    @Override
    public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
        scrollTo(Math.min(Math.max((int) distanceX + getScrollX(), minScroll), maxScroll), 0);
        return Math.abs(distanceX) > Math.abs(distanceY) * 2;
    }

    @Override
    public void onLongPress(MotionEvent e) {

    }

    @Override
    public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
        if (Math.abs(velocityX) < Math.abs(velocityY) * 3) return false;
        scroller.fling(getScrollX(), 0, (int) -velocityX, 0, minScroll, maxScroll, 0, 0);
        post(updateScrollTask);
        return true;
    }

    private class ScrollUpdater implements Runnable {
        @Override
        public void run() {
            if (scroller.computeScrollOffset()) {
                scrollTo(scroller.getCurrX(), scroller.getCurrY());
                post(this);
            } else {
                if (!aborted) {
                    scrollCenter(false);
                }
            }
        }
    }

    private class CloseAnimationAdapter extends AnimationSet {
        private final AnimationListener listener;
        private int selectedIndex;
        private boolean open;

        private int lastOffsetBefore = 0;
        private int lastOffsetAfter = 0;

        private CloseAnimationAdapter(Animation animation, int selectedIndex, boolean open, AnimationListener listener) {
            super(open);
            this.listener = listener;
            addAnimation(animation);
            animation.setFillAfter(true);
            setInterpolator(animation.getInterpolator());
            setAnimationListener(new AnimationListener() {
                @Override
                public void onAnimationStart(Animation animation) {

                }

                @Override
                public void onAnimationEnd(Animation animation) {
                }

                @Override
                public void onAnimationRepeat(Animation animation) {

                }
            });
            this.selectedIndex = selectedIndex;
            this.open = open;
        }


        @Override
        public boolean getTransformation(long interpolatedTime, Transformation t) {
            boolean transformation = super.getTransformation(interpolatedTime, t);
            int index = selectedIndex - firstChildIndex;
            if (transformation) {
                View view = getChildAt(index);
                if (view == null) return false;
                Matrix test = new Matrix();
                test.set(t.getMatrix());
                float[] pts = {0, 0, 0, view.getHeight(), view.getWidth(), 0, view.getWidth(), view.getHeight()};
                test.mapPoints(pts);
                int minX = (int) Math.min(Math.min(pts[0], pts[2]), Math.min(pts[4], pts[6]));
                int maxX = (int) Math.max(Math.max(pts[0], pts[2]), Math.max(pts[4], pts[6]));
                if (maxX - minX < Math.min(openChildWidth, childWidth)) {
                    maxX += (Math.min(openChildWidth, childWidth) - maxX + minX) / 2;
                    minX -= (Math.min(openChildWidth, childWidth) - maxX + minX) / 2;
                }
                for (int i = 0; i < getChildCount(); i++) {
                    if (i < index) {
                        getChildAt(i).offsetLeftAndRight(minX - lastOffsetBefore);
                    }
                    if (i > index) {
                        getChildAt(i).offsetLeftAndRight(maxX - view.getWidth() - lastOffsetAfter);
                    }
                }
                lastOffsetBefore = minX;
                lastOffsetAfter = maxX - view.getWidth();
            }
            if (hasEnded()) {
/*
                for (int i = 0; i < getChildCount(); i++) {
                    if (i < index) {
                        getChildAt(i).offsetLeftAndRight(- lastOffsetBefore);
                    }
                    if (i > index) {
                        getChildAt(i).offsetLeftAndRight(- lastOffsetAfter);
                    }
                }
*/
                super.getTransformation(getStartTime() + getDuration() + 1000, t);
                final View view = getChildAt(index);
                if (view == null) return transformation;
                if (open) {
                    view.findViewById(R.id.front).setVisibility(GONE);
                    view.findViewById(R.id.backside).setVisibility(VISIBLE);
                } else {
                    view.findViewById(R.id.front).setVisibility(VISIBLE);
                    view.findViewById(R.id.backside).setVisibility(GONE);
                }
                layoutChild(view, view.getLeft(), true);
                lastOffsetAfter -= (open ? openChildWidth - childWidth : childWidth - openChildWidth);
//                for (int i = index + 1; i < getChildCount(); i++) {
//                }
                if ((gravity & Gravity.HORIZONTAL_GRAVITY_MASK) == Gravity.CENTER_HORIZONTAL) {
                    if (open) {
                        scrollBy((openChildWidth - childWidth) / 2, 0);
                    } else {
                        scrollBy((childWidth - openChildWidth) / 2, 0);
                    }
                }
                if ((gravity & Gravity.HORIZONTAL_GRAVITY_MASK) == Gravity.RIGHT) {
                    if (open) {
                        scrollBy(openChildWidth - childWidth, 0);
                    } else {
                        scrollBy(childWidth - openChildWidth, 0);
                    }
                }
                if (open) {
                    OpenAnimationAdapter animation1 = new OpenAnimationAdapter(openInAnimation, selectedIndex, open, lastOffsetBefore, lastOffsetAfter);
                    animation1.setAnimationListener(listener);
                    view.setAnimation(animation1);
                } else {
                    OpenAnimationAdapter animation1 = new OpenAnimationAdapter(closeInAnimation, selectedIndex, open, lastOffsetBefore, lastOffsetAfter);
                    animation1.setAnimationListener(listener);
                    view.setAnimation(animation1);
                }
            }
            return transformation;
        }

    }

    private class OpenAnimationAdapter extends AnimationSet {
        private int selectedIndex;
        private boolean open;

        private int lastOffsetBefore = 0;
        private int lastOffsetAfter = 0;

        private OpenAnimationAdapter(Animation animation, int selectedIndex, boolean open, int lastOffsetBefore, int lastOffsetAfter) {
            super(true);
            this.lastOffsetBefore = lastOffsetBefore;
            this.lastOffsetAfter = lastOffsetAfter;
            addAnimation(animation);
            setInterpolator(animation.getInterpolator());
            this.selectedIndex = selectedIndex;
            this.open = open;
        }


        @Override
        public boolean getTransformation(long interpolatedTime, Transformation t) {
            boolean transformation = super.getTransformation(interpolatedTime, t);
            int index = selectedIndex - firstChildIndex;
            if (!transformation) {
                for (int i = 0; i < getChildCount(); i++) {
                    if (i < index) {
                        getChildAt(i).offsetLeftAndRight(-lastOffsetBefore);
                    }
                    if (i > index) {
                        getChildAt(i).offsetLeftAndRight(-lastOffsetAfter);
                    }
                }
                requestLayout();
            } else {
                View view = getChildAt(index);
                if (view == null) return false;
                Matrix test = new Matrix();
                test.set(t.getMatrix());
                float[] pts = {0, 0, 0, view.getHeight(), view.getWidth(), 0, view.getWidth(), view.getHeight()};
                test.mapPoints(pts);
                int minX = (int) Math.min(Math.min(pts[0], pts[2]), Math.min(pts[4], pts[6]));
                int maxX = (int) Math.max(Math.max(pts[0], pts[2]), Math.max(pts[4], pts[6]));
                if (maxX - minX < Math.min(openChildWidth, childWidth)) {
                    maxX += (Math.min(openChildWidth, childWidth) - maxX + minX) / 2;
                    minX -= (Math.min(openChildWidth, childWidth) - maxX + minX) / 2;
                }
                for (int i = 0; i < getChildCount(); i++) {
                    if (i < index) {
                        getChildAt(i).offsetLeftAndRight(minX - lastOffsetBefore);
                    }
                    if (i > index) {
                        getChildAt(i).offsetLeftAndRight(maxX - view.getWidth() - lastOffsetAfter);
                    }
                }
                lastOffsetBefore = minX;
                lastOffsetAfter = maxX - view.getWidth();
            }
            return transformation;
        }
    }

    public interface OnScrollListener {
        public void onScroll(ExpandableHorizontalListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount);
    }
}
