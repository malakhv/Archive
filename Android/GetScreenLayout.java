// get screen layout long

int long = getResources().getConfiguration().screenLayout
& Configuration.SCREENLAYOUT_LONG_MASK;

switch (long) {
    case Configuration.SCREENLAYOUT_LONG_YES:
        // Long screens, such as WQVGA, WVGA, FWVGA
        break;
    case Configuration.SCREENLAYOUT_LONG_NO:
        // Not long screens, such as QVGA, HVGA, and VGA
        break;
    default:
        break;
}
