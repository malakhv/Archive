package com.devlear.app.beerhub.app;

import com.malakhv.util.LogCat;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Mikhail.Malakhov
 */
public class AppComponents implements Iterable<AppComponent> {

    /** The list of registered app components. */
    private final List<AppComponent> mComponents = new LinkedList<>();

    /**
     * Registers app component.
     * */
    public void register(AppComponent component) {
        if (component != null) mComponents.add(component);
    }

    /**
     * Unregisters app component.
     * */
    public void unregister(AppComponent component) {
        if (component != null) mComponents.remove(component);
    }

    /**
     * Generates debug information and prints it to log.
     * */
    public void dump() {
        final int count = mComponents.size();
        LogCat.d("App components count: " + count);
        for (AppComponent component: mComponents) {
            if (component == null) continue;
            LogCat.d("=== " + component.getName() + " (" + component.getVersion() + ")");
            component.dump();
        }
    }

    /** {@inheritDoc} */
    @Override
    public Iterator<AppComponent> iterator() {
        return null;
    }
}
