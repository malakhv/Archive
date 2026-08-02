// @see http://developer.android.com/intl/ja/reference/android/content/res/Configuration.html#screenLayout

// get screen layout size
int size = getResources().getConfiguration().screenLayout
        & Configuration.SCREENLAYOUT_SIZE_MASK;

switch (size) {
    case Configuration.SCREENLAYOUT_SIZE_XLARGE:
        // 720x960 dp units
        break;
    case Configuration.SCREENLAYOUT_SIZE_LARGE:
        // 480x640 dp units
        break;
    case Configuration.SCREENLAYOUT_SIZE_NORMAL:
        // 320x470 dp units
        break;
    case Configuration.SCREENLAYOUT_SIZE_SMALL:
        // 320x426 dp units
        break;
    default:
        break;
}