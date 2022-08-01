package arch;

import android.inputmethodservice.InputMethodService;
import android.inputmethodservice.Keyboard;
import android.inputmethodservice.KeyboardView;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;

import keyboard.nemo.box.R;

import static android.inputmethodservice.Keyboard.*;

/**
 * Created by malakhv on 14.11.14.
 *
 */
public class InputService extends InputMethodService implements KeyboardView.OnKeyboardActionListener {

    /** View клавиатуры. */
    private NemoKeyboard mKeyboardView = null;

    /**
     * Создает View клавиатуры (InputView).
     * */
    @Override
    public View onCreateInputView() {

        /* Создаём View из ресурсов */
        View inputView = getLayoutInflater().inflate(R.layout.input, null);

        /* View клавиатуры (KeyboardView) */
        mKeyboardView = (NemoKeyboard) inputView.findViewById(R.id.keyboard);

        /* Настраиваем View клавиатуры */
        mKeyboardView.setKeyboard(new Keyboard(this, R.xml.nemo_qwerty_rus));
        mKeyboardView.setFocusable(true);
        mKeyboardView.setOnKeyboardActionListener(this);

        /* Возвращаем все что получили из ресурсов (layout и KeyboardView) */
        return inputView;

    }

    @Override
    public void onStartInputView(EditorInfo info, boolean restarting) {
        mKeyboardView.selectFirstKey(); super.onStartInputView(info, restarting);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {

        /* Если mKeyboardView = null или клавиатура не отображается, не обрабатываем клавиши */
        if (mKeyboardView == null || !mKeyboardView.isShown())
            return super.onKeyDown(keyCode, event);

        /* Клавиша "Назад" - скрываем клавиатуру */
        if (keyCode == KeyEvent.KEYCODE_BACK) { closeKeyboard(); return true; }

        /* Навигация в Право */
        if (keyCode == KeyEvent.KEYCODE_DPAD_RIGHT) {
            mKeyboardView.moveSelToNextCol();
            return true;
        }

        /* Навигация в Лево */
        if (keyCode == KeyEvent.KEYCODE_DPAD_LEFT) {
            mKeyboardView.moveSelToPrevCol();
            return true;
        }

        /* Навигация в Верх */
        if (keyCode == KeyEvent.KEYCODE_DPAD_UP) {
            mKeyboardView.moveSelToPrevRow();
            return true;
        }

        /* Навигация в Низ */
        if (keyCode == KeyEvent.KEYCODE_DPAD_DOWN) {
            mKeyboardView.moveSelToNextRow();
            return true;
        }

        /* Центральная кнопка - выбор клавиши */
        if (keyCode == KeyEvent.KEYCODE_DPAD_CENTER) {
            //int color = Color.argb(0x77, 0xFF, 0xFF, 0x00);
            //mKeyboardView.setSelColor(color);
            onKey(mKeyboardView.getSelKey()); return false;
        }

        return false;
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {

        /* Если mKeyboardView = null или клавиатура не отображается, не обрабатываем клавиши */
        if (mKeyboardView == null || !mKeyboardView.isShown())
            return super.onKeyDown(keyCode, event);

        /* Центральная кнопка - выбор клавиши */
        if (keyCode == KeyEvent.KEYCODE_DPAD_CENTER) {
            //int color = Color.argb(0x77, 0x00, 0xFF, 0x00);
            //mKeyboardView.setSelColor(color); return true;
        }

        return false;

    }

    @Override
    public void onKey(int primaryCode, int[] keyCodes) {

        /* Закрываем клавиатуру, если пришел соответствующий код клавиши */
        if (primaryCode == Keyboard.KEYCODE_CANCEL) { closeKeyboard(); return; }

        /* Обновляем текст в поле ввода */
        getCurrentInputConnection().commitText(String.valueOf((char) primaryCode), 1);

    }

    public void onKey(Key key) { if (key != null) onKey(key.codes[0], key.codes); }

    @Override
    public void onText(CharSequence charSequence) {}

    /** Закрывает клавиатуру. */
    private void closeKeyboard() { requestHideSelf(0); mKeyboardView.closing(); }

    /* Свайп не реализован */
    public void swipeLeft() {} public void swipeRight() {}
    public void swipeDown() {} public void swipeUp() {}

    /* Не используем Touch режим */
    public void onPress(int i) {} public void onRelease(int i) {}

}