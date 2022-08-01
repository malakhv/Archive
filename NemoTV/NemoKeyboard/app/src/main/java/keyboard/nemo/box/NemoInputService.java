package keyboard.nemo.box;

import android.inputmethodservice.Keyboard;
import android.view.View;
import android.view.inputmethod.EditorInfo;

/**
 * Created by malakhv on 24.11.14.
 */
public class NemoInputService extends NavInputService {

    /** Код клавиши - Backspace */
    public static final int KEY_CODE_BACKSPACE = 88800;

    /** Код клавиши - перемещение курсора на одну позицию влево */
    public static final int KEY_CODE_LEFT = 88801;

    /** Код клавиши - перемещение курсора на одну позицию вправо */
    public static final int KEY_CODE_RIGHT = 88802;

    /** Код клавиши - смена раскладки клавиатуры */
    public static final int KEY_CODE_LANG = 88803;

    /**
     * Набор раскладок клавиатуры.
     * */
    protected KeyboardList keyboardList = null;

    /**
     * Создает View клавиатуры (InputView).
     * */
    @Override
    public View onCreateInputView() {

        /* Создаём View из ресурсов */
        View inputView = getLayoutInflater().inflate(R.layout.nemo_input_view, null);

        /* View клавиатуры (KeyboardView) */
        mKeyboardView = (NemoKeyboardView) inputView.findViewById(R.id.keyboard);

        /* Создаём раскладки клавиатуры */
        keyboardList = new KeyboardList();
        keyboardList.add(new Keyboard(this, R.xml.nemo_qwerty_rus));
        keyboardList.add(new Keyboard(this, R.xml.nemo_qwerty_en));

        /* Настраиваем View клавиатуры */
        mKeyboardView.setKeyboard(keyboardList.first());
        mKeyboardView.setFocusable(true);
        mKeyboardView.setOnKeyboardActionListener(this);

        /* Возвращаем все что получили из ресурсов (layout и KeyboardView) */
        return inputView;

    }

    /**
     * Событие нажатия клавиши клавиатуры.
     * */
     @Override
    public void onKey(int primaryCode, int[] keyCodes) {

        /* Закрываем клавиатуру, если пришел соответствующий код клавиши */
        if (primaryCode == Keyboard.KEYCODE_CANCEL) { close(); return; }

        /* Клавиша "Backspace" */
        if (primaryCode == KEY_CODE_BACKSPACE) { deleteBeforeCursor(1); return; }

        /* Клавиша "Курсор влево" */
        if (primaryCode == KEY_CODE_LEFT) { decCursorPos(); return; }

        /* Клавиша "Курсор вправо" */
        if (primaryCode == KEY_CODE_RIGHT) { incCursorPos(); return; }

        /* Меняем раскладку */
        if (primaryCode == KEY_CODE_LANG) {
            mKeyboardView.setKeyboard(keyboardList.next()); return;
        }

        /* Обновляем текст в поле ввода */
        getCurrentInputConnection().commitText(String.valueOf((char) primaryCode), 1);

    }

    @Override
    public void onStartInputView(EditorInfo info, boolean restarting) {
        mKeyboardView.selectFirstKey(); super.onStartInputView(info, restarting);
    }

}
