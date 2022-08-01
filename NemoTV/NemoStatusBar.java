package com.android.systemui.statusbar.nemo;

import android.os.IBinder;
import android.service.notification.StatusBarNotification;
import android.util.Slog;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;

import com.android.internal.statusbar.StatusBarIcon;
import com.android.systemui.statusbar.BaseStatusBar;

/**
 * Created by nikita on 19.02.14.
 */
public class NemoStatusBar extends BaseStatusBar {
    final static String TAG = "NemoStatusBar";
    final static boolean DEBUG = true;
    @Override
    public void addIcon(String slot, int index, int viewIndex, StatusBarIcon icon) {
        if(DEBUG) Slog.d(TAG, "addIcon");
    }

    @Override
    public void updateIcon(String slot, int index, int viewIndex, StatusBarIcon old,
                           StatusBarIcon icon) {
        if(DEBUG) Slog.d(TAG, "updateIcon");
    }

    @Override
    public void removeIcon(String slot, int index, int viewIndex) {
        if(DEBUG) Slog.d(TAG, "removeIcon");
    }

    @Override
    public void addNotification(IBinder key, StatusBarNotification notification) {
        if(DEBUG) Slog.d(TAG, "addNotification");
    }

    @Override
    public void updateNotification(IBinder key, StatusBarNotification notification) {
        if(DEBUG) Slog.d(TAG, "updateNotification");
    }

    @Override
    public void removeNotification(IBinder key) {
        if(DEBUG) Slog.d(TAG, "removeNotification");
    }

    @Override
    public void disable(int state) {
        if(DEBUG) Slog.d(TAG, "disable");
    }

    @Override
    public void animateExpandNotificationsPanel() {
        if(DEBUG) Slog.d(TAG, "animateExpandNotificationsPanel");
    }

    @Override
    public void animateCollapsePanels(int flags) {
        if(DEBUG) Slog.d(TAG, "animateCollapsePanels");
    }

    @Override
    public void animateExpandSettingsPanel() {
        if(DEBUG) Slog.d(TAG, "animateExpandSettingsPanel");
    }

    @Override
    public void setSystemUiVisibility(int vis, int mask) {
        if(DEBUG) Slog.d(TAG, "setSystemUiVisibility");
    }

    @Override
    public void topAppWindowChanged(boolean visible) {
        if(DEBUG) Slog.d(TAG, "topAppWindowChanged");
    }

    @Override
    public void setImeWindowStatus(IBinder token, int vis, int backDisposition) {
        if(DEBUG) Slog.d(TAG, "setImeWindowStatus");
    }

    @Override
    public void setHardKeyboardStatus(boolean available, boolean enabled) {
        if(DEBUG) Slog.d(TAG, "setHardKeyboardStatus");
    }

    @Override
    public void toggleRecentApps() {
        if(DEBUG) Slog.d(TAG, "toggleRecentApps");
    }

    @Override
    public void setNavigationIconHints(int hints) {
        if(DEBUG) Slog.d(TAG, "setNavigationIconHints");
    }


    /**
     * BaseStatusBar
     *
     * */

    /**
     * Create all windows necessary for the status bar (including navigation, overlay panels, etc)
     * and add them to the window manager.
     */
    @Override
    protected void createAndAddWindows() {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::createAndAddWindows");
    }


    // Поддержка чтения справа-налево
    @Override
    protected void refreshLayout(int layoutDirection) {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::refreshLayout");
    }

    // Этот метод вообще по-моему нигед не используется
    @Override
    protected WindowManager.LayoutParams getRecentsLayoutParams(ViewGroup.LayoutParams layoutParams) {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::getRecentsLayoutParams");
        return null;
    }

    //Лайоут для панели поиска, не используем
    @Override
    protected WindowManager.LayoutParams getSearchLayoutParams(ViewGroup.LayoutParams layoutParams) {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::getSearchLayoutParams");
        return null;
    }

    // Используется в активити последних приложений
    @Override
    protected View getStatusBarView() {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::getStatusBarView");
        return null;
    }

    // Похоже что тикается (показвается заново новая нотфикация)
    // Этот метод сбрасывает тики
    // используется в updateNotification
    @Override
    protected void haltTicker() {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::haltTicker");
    }

    // Устанавливает, что есть нотификации
    // используется в updateNotification
    @Override
    protected void setAreThereNotifications() {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::setAreThereNotifications");

    }

    // Используется в updateNotification
    @Override
    protected void updateNotificationIcons() {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::updateNotificationIcons");

    }

    // Используется в updateNotification
    @Override
    protected void tick(IBinder key, StatusBarNotification n, boolean firstTime) {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::tick");
    }

    // Используется в updateNotification
    @Override
    protected void updateExpandedViewPos(int expandedPosition) {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::updateExpandedViewPos");
    }

    // используется в super.setPileLayers, которые похоже что никогда не вызывается
    @Override
    protected int getExpandedViewMaxHeight() {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::getExpandedViewMaxHeight");
        return 0;
    }

    // Используется в обработчике жестов в телефонном и таблетном статусбаре
    @Override
    protected boolean shouldDisableNavbarGestures() {
        if(DEBUG) Slog.d(TAG, "@BaseStatusBar::shouldDisableNavbarGestures");
        return false;
    }
}
