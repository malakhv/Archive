package com.vectordigital.commonlibs.ui;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.Scroller;

import java.util.Iterator;
import java.util.LinkedHashSet;


/**
 * User: n.pryanichnikov
 * Date: 18.07.13
 * Time: 15:57
 */
public class VerticalCycleLayersView extends AdapterView implements GestureDetector.OnGestureListener {

    private class ScrollerChecker implements Runnable {
        private boolean finished = true;

        public void startChecking() {
            Log.w("MyActivity", "Start checking scroll");
            finished = false;
        }


        public void stopChecking() {
            Log.w("MyActivity", "Stopped checking scroll");
            finished = true;
        }

        @Override
        public void run() {

            if (scroller.computeScrollOffset()) {
                scrollTo(scroller.getCurrX(), scroller.getCurrY());
            }

            if (!finished) {
                if (scroller.isFinished()) {
                    onScrollerFinished();
                    finished = true;
                }
            }
            post(this);

        }
    }

    private LinkedHashSet<View> cachedViews = new LinkedHashSet<View>();

    private Adapter adapter;
    private GestureDetector gestureDetector;
    private final Scroller scroller;
    private ScrollerChecker scrollerChecker = new ScrollerChecker();
    private View selectedItem;

    private int firstItem = 0;
    private int lastItem = 0;

    // Helpers
    private View getFirstChild() {
        return getChildAt(0);
    }

    private View getLastChild() {
        return getChildAt(getChildCount() - 1);
    }

    private int inc(int value) {
        return (value + 1) % this.adapter.getCount();
    }

    private int dec(int value) {
        value--;
        if (value < 0) {
            value = this.adapter.getCount() - 1;
        }
        return value;
    }

    public VerticalCycleLayersView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.gestureDetector = new GestureDetector(context, this);
        scroller = new Scroller(getContext());
    }


    @Override
    protected void onScrollChanged(int l, int t, int oldl, int oldt) {
        super.onScrollChanged(l, t, oldl, oldt);    //To change body of overridden methods use File | Settings | File Templates.
        processScroll();
    }

    private void onScrollerFinished() {
        Log.w("MyActivity", "Scroll finished");
        positionSelectedItem(true);
    }

    @Override
    public Adapter getAdapter() {
        return this.adapter;
    }

    @Override
    public void setAdapter(Adapter adapter) {
        this.adapter = adapter;
    }

    @Override
    public View getSelectedView() {
        throw new UnsupportedOperationException("Not supported");
    }

    @Override
    public void setSelection(int position) {
        throw new UnsupportedOperationException("Not supported");
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        if (adapter == null) {
            return;
        }

        if (getChildCount() == 0) {
            populateVisibleAreaFirst();
        }

        positionItems();
        trackSelectedItem();
        // TODO_DONE тут лучше позиционировать без анимации.
        positionSelectedItem(false);
        scrollerChecker.run();

    }

    private void addChild(View child, int index) {
        LayoutParams params = child.getLayoutParams();
        if (params == null) {
            params = new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT);
        }

        addViewInLayout(child, index, params, true);
    }

    private void measureChildView(View child) {
        LayoutParams params = child.getLayoutParams();
        int itemWidth = getWidth();
        if (params.height >= 0) {
            child.measure(MeasureSpec.makeMeasureSpec(itemWidth, MeasureSpec.EXACTLY), MeasureSpec.makeMeasureSpec(params.height, MeasureSpec.EXACTLY));
        } else if (params.height == LayoutParams.MATCH_PARENT) {
            child.measure(MeasureSpec.makeMeasureSpec(itemWidth, MeasureSpec.EXACTLY), MeasureSpec.makeMeasureSpec(getHeight() / 2, MeasureSpec.EXACTLY));
        } else {
            child.measure(MeasureSpec.makeMeasureSpec(itemWidth, MeasureSpec.EXACTLY), MeasureSpec.makeMeasureSpec(getHeight() / 2, MeasureSpec.AT_MOST));
        }
    }

    private void addAndMeasureChild(View child, int index) {
        addChild(child, index);
        measureChildView(child);
    }

    private void positionItems() {
        int top = 0;

        for (int index = 0; index < getChildCount(); index++) {
            View child = getChildAt(index);

            int width = child.getMeasuredWidth();
            int height = child.getMeasuredHeight();
            int left = (getWidth() - width) / 2;

            child.layout(left, top, left + width, top + height);
            top += height;
        }
    }

    private void populateVisibleAreaFirst() {
        firstItem = 0;
        lastItem = 0;

        int top;
        if (this.getChildCount() == 0) {
            top = 0;
        } else {
            top = this.getChildAt(this.getChildCount() - 1).getBottom();
        }

        int position = 0;
        while (top < this.getHeight() && position < adapter.getCount() - 1) {
            View child = this.adapter.getView(position++, null, this);
            this.addAndMeasureChild(child, -1);
            top += child.getMeasuredHeight();
            lastItem++;
        }
    }


    private void populateVisibleArea() {
        //Заполнить верхнюю часть
        int top = getFirstChild().getTop();
        Iterator<View> iterator = cachedViews.iterator();
        View cachedView;
        while (top > getScrollY()) {
            firstItem = dec(firstItem);
            cachedView = iterator.hasNext() ? iterator.next() : null;
            cachedViews.remove(cachedView);
            View child = adapter.getView(firstItem, cachedView, this);
            measureChildView(child);

            int width = child.getMeasuredWidth();
            int height = child.getMeasuredHeight();
            int left = (getWidth() - width) / 2;
            top -= height;

            if (top < getScrollY() + getHeight()) {
                addChild(child, 0);
                child.layout(left, top, left + width, top + height);
            }

        }

        //Заполнить нижнюю часть
        int bottom = getLastChild().getBottom();

        while (bottom < getHeight() + getScrollY()) {
            lastItem = inc(lastItem);
            cachedView = iterator.hasNext() ? iterator.next() : null;
            cachedViews.remove(cachedView);
            View child = adapter.getView(lastItem, cachedView, this);

            measureChildView(child);

            int width = child.getMeasuredWidth();
            int height = child.getMeasuredHeight();
            int left = (getWidth() - width) / 2;
            bottom += height;
            if (bottom > this.getScrollY()) {
                addChild(child, -1);
                child.layout(left, bottom - height, left + width, bottom);
            }

        }
        // TODO_DONE Вообще этот метод имеет смысл модифицировать на тот случай, если мы проскролимся глубоко вниз.

    }

    private void hideOutsideVisibleArea() {
        for (int i = 0; i < getChildCount(); i++) {
            View child = getChildAt(i);


            // Если вышел за нижнюю границу
            if (child.getTop() > (this.getHeight() + this.getScrollY())) {
                lastItem = dec(lastItem);
                cachedViews.add(child);
                removeViewInLayout(child);

                // Если вышел за верхнюю границу
            } else if (child.getBottom() < (getScrollY())) {
                firstItem = this.inc(firstItem);
                cachedViews.add(child);
                removeViewInLayout(child);
            }
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        // check for tap and cancel fling

//
        if ((event.getAction() & MotionEvent.ACTION_MASK) == MotionEvent.ACTION_UP) {
            if (scroller.isFinished()) {
                positionSelectedItem(true);
            }
        }


        gestureDetector.onTouchEvent(event);
        return true;
    }

    private float initialY;
    private final float DELTAY = 20f;

    @Override
    public boolean onInterceptTouchEvent(MotionEvent event) {
        if ((event.getAction() & MotionEvent.ACTION_MASK) == MotionEvent.ACTION_UP) {
            event.setAction(MotionEvent.ACTION_CANCEL);
        }

        if ((event.getAction() & MotionEvent.ACTION_MASK) == MotionEvent.ACTION_DOWN) {
            initialY = event.getY();
            gestureDetector.onTouchEvent(event);
        }

        if ((event.getAction() & MotionEvent.ACTION_MASK) == MotionEvent.ACTION_MOVE) {
            if (Math.abs(initialY - event.getY()) > DELTAY) {
                return true;
            }
        }

        // при онапе всегда канцел, если у-у0 больше дельты то ретерн тру
//        onTouchEvent(event);
        return super.onInterceptTouchEvent(event);
    }

    @Override
    public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
        this.scrollBy(0, (int) distanceY);
        return true;
    }

    @Override
    public void onLongPress(MotionEvent e) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
        Log.w("MyActivity", String.format("onFling, top: %d", selectedItem.getTop()));
        int height = selectedItem.getHeight();
        int center = getHeight() / 2 + getScrollY();

        float vel = Math.min(Math.abs(velocityY), 950) * Math.signum(velocityY);
        Log.w("MyActivity", String.format("Velocity: %f", vel));


        scroller.fling(getScrollX(), getScrollY(), 0, -(int) vel, Integer.MIN_VALUE, Integer.MAX_VALUE, getScrollY() + selectedItem.getTop() - center - height / 2, getScrollY() + selectedItem.getBottom() - center + height / 2); // Integer.MIN_VALUE,  Integer.MAX_VALUE);
        scrollerChecker.startChecking();
        return true;
    }

    @Override
    public boolean onDown(MotionEvent e) {
        scrollerChecker.stopChecking();
        scroller.abortAnimation();
        return true;
    }

    @Override
    public void onShowPress(MotionEvent e) {

    }

    @Override
    public boolean onSingleTapUp(MotionEvent e) {
        return false;
    }

    private void processScroll() {

        this.hideOutsideVisibleArea();
        this.populateVisibleArea();
        this.trackSelectedItem();
    }

    private void trackSelectedItem() {

        int center = getHeight() / 2 + getScrollY();

        for (int i = 0; i < this.getChildCount(); i++) {
            View child = this.getChildAt(i);

            if (child.getTop() < center && child.getBottom() > center) {
                selectedItem = child;
            }

        }
    }

    private void positionSelectedItem(boolean useScroller) {
        if (selectedItem == null)
            return;

        int center = getHeight() / 2 + getScrollY();
        int delta = selectedItem.getHeight() / 2 - (center - selectedItem.getTop());
        if (Math.abs(delta) > 5) {
            if (useScroller)
                scroller.startScroll(getScrollX(), getScrollY(), 0, delta, 700);
            else
                scrollBy(0, delta);

            postInvalidate();
        }
    }


//    @Override
//    public void computeScroll() {
    // TODO_DONE Вообще я бы не советовал использовать этот метод т.к. он вызывается в процессе рисования.
    // на мой взгляд это идеологически неправильно, и лучше идти по другой схеме.

////        if (scroller.computeScrollOffset())
////        {
////            int oldX = getScrollX();
////            int oldY = getScrollY();
////            int x = scroller.getCurrX();
////            int y = scroller.getCurrY();
////            scrollTo(x, y);
////            // TODO_DONE Он сам вызовется, не обязательно делать это вручную
////            if (oldX != getScrollX() || oldY != getScrollY())
////            {
////                onScrollChanged(getScrollX(), getScrollY(), oldX, oldY);
////            }
////            // TODO_DONE не нужно вызывать это специально. Пусть система сама перерисовывает.
//////                postInvalidate();
////            processScroll();
////        }
//
//
//    }
}
