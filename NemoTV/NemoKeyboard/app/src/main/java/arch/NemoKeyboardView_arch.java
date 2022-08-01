package arch;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Rect;
import android.inputmethodservice.Keyboard;
import android.inputmethodservice.KeyboardView;
import android.util.AttributeSet;

import java.util.List;

import static android.inputmethodservice.Keyboard.Key;

/**
 * Клас, обеспечивающий визуальное представление клавиатуры и возможность навигации по ней с пульта
 * дистанционного управления.
 *
 * @author Mikhail Malakhov, 17.11.14.
 */
public class NemoKeyboardView_arch extends KeyboardView {

    public static final int BAD_KEY_CODE = -1;

    public static final int NO_KEY = -1;

    /** Область для отрисовки прямоугольника выделения. */
    private Rect selRect = new Rect(0,0,0,0);

    /** Выделенная клавиша. */
    private Key selKey = null;

    /** Количество столбцов в клавиатуре. */
    private int colCount = 0;

    /** Количество строк в клавиатуре. */
    private int rowCount = 0;

    private int keyCol = 0;
    private int keyRow = 0;

    private int keyIndex = NO_KEY;

    /** Цвет прямоугольного выделения. */
    private int selColor = Color.argb(0x77, 0x00, 0xFF, 0x00);

    /** Создает новый объект {@code NemoKeyboardView} с заданными параметрами. */
    public NemoKeyboardView_arch(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    /**
     * Отрисовывает объект. Реальная отрисовка происходит в методе предка
     * {@code KeyboardView.OnDraw}, а потом отрисовывается прямоугольник выделения.
     * */
    @Override
    public void onDraw(Canvas canvas) {

        /* Метод предка - рисует клавиатуру */
        super.onDraw(canvas);

        /* Если выбранной клавиши нет - выходим */
        if (selKey == null) return;

        /* Расчет прямоугольной области */
        selRect.set(selKey.x, selKey.y, selKey.x + selKey.width, selKey.y + selKey.height);

        /* Отрисовка прямоугольной области */
        canvas.clipRect(selRect);
        canvas.drawColor(selColor);

    }

    public void setSelColor(int color) { selColor = color; invalidate(); }


    /**
     * Выбирает клавишу, заданную параметром {@code key}.
     *
     * @param key клавиша, которую необходимо выбрать (для которой будет отрисованно выделение)
     * */
    protected void selectKey(Key key) {

        /* Запоминаем выделенную клавишу */
        selKey = key;

        /* Запрос перерисовки объекта */
        invalidate();

    }

    /**
     * Выбирает клавишу по её индексу в списке всех клавиш текущей клавиатуры.
     *
     * @param index индекс клавиши в списке всех клавиш текущей клавиатуры.
     * */
    protected void selectKey(int index) {

        /* Получаем ссылку на текущую клавиатуру и проверяем её */
        Keyboard keyboard = this.getKeyboard();

        /* Клавиша для выбора */
        Key key = null;
        keyIndex = NO_KEY;

        /* Если есть клавиатура, пытаемся получить клавишу по индексу */
        if (keyboard != null) {

            /* Список всех клавиш */
            List<Key> keys = keyboard.getKeys();

            /* Если список не пустой, проверяем индекс */
            if (keys != null && keys.size() > 0) {

                /* Индекс клавиши */
                int i = index >= 0 ? index : 0;
                if (i >= keys.size()) i = keys.size() - 1;

                /* Клавиша */
                key = keys.get(i);
                keyIndex = i; // Добавил индекс последней выбранной клавиши
            }

        }

        /* Вычисляем строку и  */

        /* Выбираем клавишу */
        selectKey(key);

    }

    public void selectKey(int col, int row) { selectKey(row * colCount + col); }

    /**
     * Выбирает первую клавишу на текущей клавиатуре.
     * */
    protected void selectKey() { selectKey(keyCol, keyRow);}

    public void selectFirstKey() { keyCol = 0; keyRow = 0; selectKey(0); }

    public void selectLastKey() {  }

    /**
     * Вызвращает текущую выделенную клавишу, или null, если клавиша не выбранна.
     * */
    public Key getSelKey() { return selKey; }

    /** Возвращает код для текущей выбранной клавиши. */
    public int getSelCode() {
        int[] codes = getSelCodes();
        if (codes.length > 0) return codes[0];
        else return BAD_KEY_CODE;
    }

    /** Возвращает все коды для текущей выбранной клавиши. */
    public int[] getSelCodes() {
        Key key = getSelKey();
        if (key != null)
            return key.codes;
        else
            return new int[]{BAD_KEY_CODE};
    }

    /** Возвращает количество столбцов клавиш в клавиатуре */

    @Override
    public void setKeyboard(Keyboard keyboard) {
        super.setKeyboard(keyboard); updateColRowCount();
    }

    /**
     * Пересчитывает количество строк и столбцов для текущей клавиатуры.
     * */
    protected void updateColRowCount() {

        /* Сбрасываем значения количества строк и столбцов */
        colCount = 0; rowCount = 0;

        /* Получаем ссылку на текущую клавиатуру и проверяем её */
        Keyboard keyboard = this.getKeyboard();
        if (keyboard == null) return;

        /* Получаем список всех клавиш и проверяем его */
        List<Key> keys = keyboard.getKeys();
        if (keys == null || keys.size() <= 0) return;

        /*
         * Для подсчета количества строк и столбцов будем сравнивать координаты x и y соседних
         * клавишь. Если меняется координата x, значит перешли на новый столбец, если y - на новую
         * строку.
         * */

        /* Координаты для сравнения */
        int x = -1, y = -1;

        /* Считаем количество строк и столбцов */
        for (Key key: keys) {
            //if (x != key.x) { x = key.x; colCount++; }
            if (y != key.y) { y = key.y; rowCount++; }
        }

        /* Пока считаем, что клавиш в каждой строке одинаковое количество */
        colCount = keys.size() / rowCount;

    }

    /**
     *
     *
     * */
    public void nextCol() {

        /* Вычисляем индекс следующего столюца */
        keyCol = (keyCol + 1) % colCount;

        /* Вычисляем индекс клавиши */
        keyIndex++;
        if (keyIndex % colCount == 0) keyIndex = keyIndex - colCount;

        /* Выбираем клавишу */
        selectKey(keyIndex);

    }

    public void prevCol() {

        /* Вычисляем индекс предыдущего столюца */
        keyCol = (keyCol -1 + colCount) % colCount;

        /* Вычисляем индекс клавиши */
        //keyIndex--;
        if (keyIndex % colCount == 0) keyIndex = keyIndex + colCount;
        keyIndex--;

        /* Выбираем клавишу */
        selectKey(keyIndex);

    }


    protected int getKeyCount() {
        return getKeyboard().getKeys().size();
    }

    public void nextRow() {

        /* Вычисляем индекс следующего столюца */
        keyRow = (keyRow + 1) % rowCount;

        /* Вычисляем индекс клавиши */
        keyIndex = (keyIndex + colCount) % getKeyCount();

        /* Выбираем клавишу */
        selectKey(keyIndex);

    }

    public void prevRow() {

        /* Вычисляем индекс предыдущего столюца */
        keyRow = (keyRow -1 + rowCount) % rowCount;

        /* Вычисляем индекс клавиши */
        keyIndex = (keyIndex - colCount + getKeyCount()) % getKeyCount();

        /* Выбираем клавишу */
        selectKey(keyIndex);

    }

}