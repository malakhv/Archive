 public <T extends View> T findViewWithId(final int id) {
        return (T) super.findViewById(id);
    }