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
public class VerticalFloatingListView extends FloatingFocusAdapterView<ListAdapter> {

    private VerticalLayoutStrategy layoutStrategy;
    private int separatorSize;
    private int gravity;

    public VerticalFloatingListView(Context context) {
        super(context);
        init(null, 0);
    }

    public VerticalFloatingListView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(attrs, 0);
    }

    public VerticalFloatingListView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(attrs, defStyle);
    }

    private void init(AttributeSet attributeSet, int defStyle) {
        if (attributeSet != null) {
            TypedArray typedArray = getContext().obtainStyledAttributes(attributeSet, R.styleable.VerticalFloatingListView, 0, 0);
            int gravity = typedArray.getInt(R.styleable.VerticalFloatingListView_gravity, 1);
            switch (gravity) {
                case 0:
                    this.gravity = Gravity.LEFT;
                    break;
                case 1:
                    this.gravity = Gravity.CENTER_HORIZONTAL;
                    break;
                case 2:
                    this.gravity = Gravity.RIGHT;
                    break;
            }

            this.separatorSize = typedArray.getDimensionPixelSize(R.styleable.VerticalFloatingListView_separatorSize, 0);
            typedArray.recycle();
        } else {
            gravity = Gravity.CENTER_HORIZONTAL;
            separatorSize = 0;
        }

        layoutStrategy = new VerticalLayoutStrategy(separatorSize, gravity);
        setup(layoutStrategy, new SimpleFocusStrategy(), new CenterScrollStrategy(CenterScrollStrategy.BOUND_NEVER, CenterScrollStrategy.BOUND_ONE_THIRD));
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
