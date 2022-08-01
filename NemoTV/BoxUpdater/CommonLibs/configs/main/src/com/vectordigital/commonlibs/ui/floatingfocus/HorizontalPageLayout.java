package com.vectordigital.commonlibs.ui.floatingfocus;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.ListAdapter;

/**
 * Created by a.karmanov on 11.07.14.
 */
public class HorizontalPageLayout extends FloatingFocusAdapterView<ListAdapter> {
    private HorizontalPageOrientedLayoutStrategy layoutStrategy;

    public HorizontalPageLayout(Context context) {
        super(context);
        init(null, 0);
    }

    public HorizontalPageLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(attrs, 0);
    }

    public HorizontalPageLayout(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(attrs, defStyle);
    }

    private void init(AttributeSet attributeSet, int defStyle) {
        if (attributeSet != null) {
//            TypedArray typedArray = getContext().obtainStyledAttributes(attributeSet, R.styleable.HorizontalFloatingListView, 0, 0);
//            int gravity = typedArray.getInt(R.styleable.HorizontalFloatingListView_gravity, 1);
//            switch (gravity) {
//                case 0:
//                    this.gravity = Gravity.TOP;
//                    break;
//                case 1:
//                    this.gravity = Gravity.CENTER_VERTICAL;
//                    break;
//                case 2:
//                    this.gravity = Gravity.BOTTOM;
//                    break;
//            }
//
//            this.separatorSize = typedArray.getDimensionPixelSize(R.styleable.HorizontalFloatingListView_separatorSize, 0);
//            typedArray.recycle();
        } else {
//            gravity = Gravity.CENTER_VERTICAL;
//            separatorSize = 0;
        }

        layoutStrategy = new HorizontalPageOrientedLayoutStrategy();
        setup(layoutStrategy, new SimpleFocusStrategy(), new HorizontalPageScrollStrategy());
    }

}
