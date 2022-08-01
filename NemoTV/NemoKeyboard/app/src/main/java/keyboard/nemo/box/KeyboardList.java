package keyboard.nemo.box;

import android.inputmethodservice.Keyboard;
import java.util.ArrayList;

/**
 * Created by malakhv on 25.11.14.
 *
 */
public class KeyboardList extends ArrayList<Keyboard> {

    /** Значение индекса при отсутствии клавиатуры. */
    public static final int NO_KEYBOARD = -1;

    /**
     * Индекс текущей клавиатуры из набора.
     * */
    private int curIndex = NO_KEYBOARD;

    /**
     * Возвращает следующую клавиатуру из набора.
     * */
    public Keyboard next() {
        if (curIndex == NO_KEYBOARD) return first();
        if (this.size() <= 0) return null;
        curIndex = (curIndex + 1) % this.size();
        return this.get(curIndex);
    }

    /**
     * Возвращает предыдущую клавиатуру из набора.
     * */
    public Keyboard prev() {
        if (curIndex == NO_KEYBOARD) return last();
        if (this.size() <= 0) return null;
        curIndex = (curIndex - 1 + this.size()) % this.size();
        return this.get(curIndex);
    }

    /**
     * Удаляет клавиатуру из набора по индексу {@code index}.
     * */
    @Override
    public Keyboard remove(int index) {
        if (index < 0 || index >= this.size()) return null;
        if (curIndex >= index) curIndex--;
        return super.remove(index);
    }

    /**
     * Возвращает первую клавиатуру в наборе, или {@code null}, если набор пустой.
     * */
    public Keyboard first() {
        if (this.size() > 0) {
            curIndex = 0; return this.get(curIndex);
        } else {
            curIndex = NO_KEYBOARD; return null;
        }
    }

    /**
     * Возвращает последнюю клавиатуру в наборе, или {@code null}, если набор пустой.
     * */
    public Keyboard last() {
        if (this.size() > 0) {
            curIndex = this.size() - 1; return this.get(curIndex);
        } else {
            curIndex = NO_KEYBOARD; return null;
        }
    }

    /**
     * Возвращает текущую клавиатуру из набора.
     * */
    public Keyboard get() {
        if (curIndex != NO_KEYBOARD) return this.get(curIndex);
        else return null;
    }

}