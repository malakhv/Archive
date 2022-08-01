package com.vectordigital.commonlibs.ui.floatingfocus;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.TypedArray;
import android.os.Build;
import android.util.AttributeSet;
import android.view.Gravity;
import android.widget.ListAdapter;

import com.vectordigital.commonlibs.R;

/**
 * Created by a.karmanov on 24.06.14.
 */
@TargetApi(Build.VERSION_CODES.HONEYCOMB)
public class HorizontalFloatingListView extends FloatingFocusAdapterView<ListAdapter> {

    private HorizontalLayoutStrategy layoutStrategy;
    private int separatorSize;
    private int gravity;

    public HorizontalFloatingListView(Context context) {
        super(context);
        init(null, 0);
    }

    public HorizontalFloatingListView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(attrs, 0);
    }

    public HorizontalFloatingListView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(attrs, defStyle);
    }

    private void init(AttributeSet attributeSet, int defStyle) {
        if (attributeSet != null) {
            TypedArray typedArray = getContext().obtainStyledAttributes(attributeSet, R.styleable.HorizontalFloatingListView, 0, 0);
            int gravity = typedArray.getInt(R.styleable.HorizontalFloatingListView_gravity, 1);
            switch (gravity) {
                case 0:
                    this.gravity = Gravity.TOP;
                    break;
                case 1:
                    this.gravity = Gravity.CENTER_VERTICAL;
                    break;
                case 2:
                    this.gravity = Gravity.BOTTOM;
                    break;
            }

            this.separatorSize = typedArray.getDimensionPixelSize(R.styleable.HorizontalFloatingListView_separatorSize, 0);
            typedArray.recycle();
        } else {
            gravity = Gravity.CENTER_VERTICAL;
            separatorSize = 0;
        }

        layoutStrategy = new HorizontalLayoutStrategy(separatorSize, gravity);
        setup(layoutStrategy, new SimpleFocusStrategy(), new SimpleScrollStrategy());
    }

    public void setSeparatorSize(int separatorSize) {
        this.separatorSize = separatorSize;
        layoutStrategy.setSeparatorSize(separatorSize);
    }

    public void setGravity(int gravity) {
        this.gravity = gravity;
        layoutStrategy.setChildGravity(gravity);
    }
}
