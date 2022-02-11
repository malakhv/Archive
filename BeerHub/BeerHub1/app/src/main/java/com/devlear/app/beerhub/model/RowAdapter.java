package com.devlear.app.beerhub.model;

import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.devlear.app.beerhub.data.RowList;
import com.devlear.app.beerhub.data.RowObject;

/**
 * @author Mikhail.Malakhov
 */
public abstract class RowAdapter<E extends RowObject, L extends RowList<E>,
        V extends DataViewHolder<E>> extends RecyclerView.Adapter<V> {

    /**
     * The internal data for this adapter.
     * @see #mListClass
     * @see #getItems()
     * */
    private L mItems = null;

    /**
     * The class of internal data in this adapter.
     * @see #mItems
     * */
    private Class<L> mListClass = null;

    /**
     * Construct a new {@link RowAdapter} instance with specified parameters.
     * */
    public RowAdapter(Class<L> listClass) {
        mListClass = listClass;
        mItems = makeItems();
    }

    public L getItems() {
        return mItems;
    }

    @NonNull
    @Override
    public V onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return null;
    }

    @Override
    public void onBindViewHolder(@NonNull V holder, int position) {
        holder.setOnItemClickListener(mInternalOnItemClickListener);
        holder.obtain(position, getItem(position));
    }

    @Override
    public int getItemCount() {
        return mItems.size();
    }

    @Override
    public long getItemId(int position) {
        return mItems.getItem(position).getId();
    }

    public E getItem(int position) {
        return mItems.getItem(position);
    }

    /**
     * The internal click listener for item.
     * */
    private DataViewHolder.OnItemClickListener mInternalOnItemClickListener =
            new DataViewHolder.OnItemClickListener() {
                @Override
                public void onItemClick(int position, long id) {
                    performItemClick(position, id);
                }
    };

    /**
     * Performs click action.
     * */
    protected void performItemClick(int position, long id) {
        if (mOnItemClickListener != null) mOnItemClickListener.onItemClick(position, id);
    }

    /**
     * The external click listener for items.
     * */
    private DataViewHolder.OnItemClickListener mOnItemClickListener = null;

    /***/
    public void setOnItemClickListener(DataViewHolder.OnItemClickListener l) {
        mOnItemClickListener = l;
    }

    public void update() {
        updateInternal();
        this.notifyDataSetChanged();
    }

    protected void updateInternal() {
        mItems.update();
    }

    protected L makeItems() {
        try {
            return mListClass.newInstance();
        } catch (IllegalAccessException | InstantiationException e) {
            return null;
        }
    }

}
