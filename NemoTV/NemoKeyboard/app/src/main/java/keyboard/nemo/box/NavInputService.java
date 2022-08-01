package keyboard.nemo.box;

import android.inputmethodservice.InputMethodService;
import android.view.KeyEvent;
import android.view.inputmethod.ExtractedText;
import android.view.inputmethod.ExtractedTextRequest;
import android.view.inputmethod.InputConnection;

import static android.inputmethodservice.Keyboard.*;
import static android.inputmethodservice.KeyboardView.*;

/**
 * Базовый класс для создания методов ввода.
 *
 * @author Mikhail Malakhov, 24.11.2014
 */
public class NavInputService extends InputMethodService implements OnKeyboardActionListener {

    /** View клавиатуры. */
    protected NavKeyboardView mKeyboardView = null;

    /**
     * Нажата клавиша или нет.
     * */
    private boolean mKeyPressed = false;

    /**
     * Возвращает {@code true}, если на пульте в данный момент зажата клавиша выбора ("ОК").
     * */
    public boolean isKeyPressed() { return mKeyPressed; }

    /**
     * Событие нажатия клавиши клавиатуры {@code key}.
     * */
    public void onKey(Key key) {
        if (key != null && key.codes != null && key.codes.length > 0) {
            onKey(key.codes[0], key.codes);
        } else
            onKey(NavKeyboardView.NO_KEY, null);
    }

    /**
     * Перехватываем нажатие клавиш в системе для реализации перемещения фокуса по клавиатуре.
     * */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {

        /* Если mKeyboardView = null или клавиатура не отображается, выходим */
        if (mKeyboardView == null || !mKeyboardView.isShown())
            return super.onKeyDown(keyCode, event);

        /* Клавиша "Назад" - скрываем клавиатуру */
        if (keyCode == KeyEvent.KEYCODE_BACK) { close(); return true; }

        /* Клавиша "Вправо" */
        if (keyCode == KeyEvent.KEYCODE_DPAD_RIGHT) {
            mKeyboardView.moveSelToNextCol(); return true;
        }

        /* Клавиша "Влево" */
        if (keyCode == KeyEvent.KEYCODE_DPAD_LEFT) {
            mKeyboardView.moveSelToPrevCol(); return true;
        }

        /* Клавиша "Вверх" */
        if (keyCode == KeyEvent.KEYCODE_DPAD_UP) {
            mKeyboardView.moveSelToPrevRow(); return true;
        }

        /* Клавиша "Вниз" */
        if (keyCode == KeyEvent.KEYCODE_DPAD_DOWN) {
            mKeyboardView.moveSelToNextRow(); return true;
        }

        /* Центральная кнопка - выбор клавиши на клавиатуре */
        if (keyCode == KeyEvent.KEYCODE_DPAD_CENTER) {
            Key key = mKeyboardView.getSelKey();
            if ((!mKeyPressed) || key.repeatable) onKey(key);
            mKeyPressed = true;
        }

        return false;
    }

    /**
     * Событие при отпускании клавиши.
     * */
    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_DPAD_CENTER) mKeyPressed = false;
        return super.onKeyUp(keyCode, event);
    }

    /**
     * Закрывает клавиатуру.
     * */
    protected void close() {
        if (mKeyboardView != null) {
            requestHideSelf(0); mKeyboardView.closing();
        }
    }

    /**
     *
     * */
    protected ExtractedText getExtractedText() {
        InputConnection inputConnection = this.getCurrentInputConnection();
        if (inputConnection != null)
            return inputConnection.getExtractedText(null, 0);
        else
            return null;
    }

    /**
     * Сдвигает курсора на количество позиций заданное параметром {@code value}.
     * */
    private void moveCursor(int value) {

        /* Получаем объект InputConnection */
        InputConnection inputConnection = this.getCurrentInputConnection();
        if (inputConnection == null) return;

        /* Получаем объект ExtractedText */
        ExtractedText text = inputConnection.getExtractedText(new ExtractedTextRequest(), 0);
        if (text == null) return;

        /* Длинна текста */
        int length = text.text.length();
        if (length <= 0) return;

        /* Новая позиция курсора */
        int pos = (text.selectionStart + value + ++length) % (length);
        inputConnection.setSelection(pos, pos);

    }

    /**
     * Сдвигает курсора на одну позицию вправо.
     * */
    protected void incCursorPos() { moveCursor(1); }

    /**
     * Сдвигает курсора на одну позицию влево.
     * */
    protected void decCursorPos() { moveCursor(-1); }

    /**
     * Удаляет символы в количестве {@code count} слева от курсора.
     * */
    protected void deleteBeforeCursor(int count) {

        /* Получаем объект InputConnection */
        InputConnection inputConnection = this.getCurrentInputConnection();
        if (inputConnection == null) return;

        /* Удаляем один символ с лева от курсора */
        inputConnection.deleteSurroundingText(1,0);

    }

    /**
     * Удаляет символы в количестве {@code count} справа от курсора.
     * */
    protected void deleteAfterCursor(int count) {

        /* Получаем объект InputConnection */
        InputConnection inputConnection = this.getCurrentInputConnection();
        if (inputConnection == null) return;

        /* Удаляем один символ с лева от курсора */
        inputConnection.deleteSurroundingText(1,0);

    }

    @Override
    public void onPress(int i) {}

    @Override
    public void onRelease(int i) {}

    @Override
    public void onKey(int i, int[] ints) {}

    @Override
    public void onText(CharSequence charSequence) {}

    /**
     * При навигации с пульта дистанционного управления свайп не используется.
     * */

    @Override
    public void swipeLeft() {}

    @Override
    public void swipeRight() {}

    @Override
    public void swipeDown() {}

    @Override
    public void swipeUp() {}
}
