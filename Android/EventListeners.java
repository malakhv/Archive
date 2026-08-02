package com.yandex.ycar;

import android.os.IBinder;
import android.os.IInterface;
import android.os.RemoteException;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;
import java.util.function.Consumer;

public abstract class EventListeners<T extends IInterface> implements IBinder.DeathRecipient {

    private final LinkedList<T> listeners = new LinkedList<T>();

    public T get(int index) {
        return listeners.get(index);
    }

    public void add(T listener) {
        sanitize();

        listeners.add(listener);

    }

    public void remove(int index) {
        listeners.remove(index);
    }

    public void remove(T listener) {
        listeners.remove(listener);
        sanitize();
    }

    public boolean isAlive(int index) {
        return isAlive(get(index));
    }

    public boolean isAlive(T listener) {
        return listener != null && listener.asBinder().isBinderAlive();
    }

    protected int sanitize() {
        int count = 0;
        for (int i = listeners.size(); i >= 0; i--) {
            final T l = get(i);
            if (isAlive(l)) {
                listeners.remove(i);
                count++;
            }
        }
        return count;
    }

    protected List<T> getAll() {
        return listeners;
    }

    public boolean isEmpty() {
        return listeners.isEmpty();
    }

    public void clear() {
        listeners.clear();
    }

    protected abstract void onEvent(T listener, Object... params);

    protected void performEvents(Object... params) {
        for (T l: listeners) {
            if (isAlive(l)) {
                onEvent(l, params);
            }
        }
    }

    @Override
    public String toString() {
        return super.toString();
    }


    @Override
    public void binderDied() {

    }

    private class Listener implements IBinder.DeathRecipient {

        private final T mListener;

        public Listener(T listener) {
            try {
                listener.asBinder().linkToDeath(this, 0);
            } catch (RemoteException e) {
                binderDied();
            }
            mListener = listener;
        }

        @Override
        public void binderDied() {
            EventListeners.this.remove(mListener);
            mListener.asBinder().unlinkToDeath(this, 0);
        }
    }
}