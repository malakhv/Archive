package keyboard.nemo.box;

import android.content.Context;
import android.graphics.Canvas;
import android.inputmethodservice.Keyboard;
import android.inputmethodservice.KeyboardView;
import android.util.AttributeSet;
import static android.inputmethodservice.Keyboard.*;

import java.util.List;

/**
 * Базовый класс для построения клавиатуры с возможностью навигации по клавишам с пульта
 * дистанционного управления.
 *
 * @author Mikhail Malakhov, 2014
 */
public abstract class NavKeyboardView extends KeyboardView {

    /** Индекс несуществующего столбца. */
    public static final int NO_COL = -1;

    /** Индекс несуществующей строки. */
    public static final int NO_ROW = -1;

    /** Индекс несуществующей клавиши. */
    public static final int NO_KEY = -1;

    /** Индекс столбца, в котором сейчас находится фокус ввода */
    protected int selCol = NO_COL;

    /** Индекс строки, в которой сейчас находится фокус ввода */
    protected int selRow = NO_ROW;

    /**
     * Создаёт новый объект {@code NavKeyboardView} с заданными параметрами.
     * */
    public NavKeyboardView(Context context, AttributeSet attrs) { super(context, attrs); }

    /**
     * Создаёт новый объект {@code NavKeyboardView} с заданными параметрами.
     * */
    public NavKeyboardView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    /**
     * Возвращает матрицу всех клавишь клавиатуры, или {@code null}, если матрицы нет или она пуста.
     * */
    protected abstract int[][] getKeyMatrix();

    /**
     * Возвращает индекс клавиши из матрицы по столбцу и строке.
     * */
    protected int getKeyIndex(int col, int row) {
        int[][] matrix = getKeyMatrix();
        if (matrix == null) return NO_KEY;
        try {
            return matrix[row][col];
        } catch (IndexOutOfBoundsException e) {
            return NO_KEY;
        }
    }

    /**
     * Возвращает клавишу по столбцу и строке.
     * */
    public Key getKey(int col, int row) {

        /* Получаем индекс клавиши по столбцу и строке */
        int index = getKeyIndex(col, row);
        if (index == NO_KEY) return null;

        /* Получаем ссылку на текущую клавиатуру и проверяем её */
        Keyboard keyboard = this.getKeyboard();
        if (keyboard == null) return null;

        /* Получаем клавиши */
        List<Key> keys = keyboard.getKeys();
        if (keys == null) return null;

        /* Получаем клавишу по индексу из списка клавиш */
        try {
            return keys.get(index);

        } catch (IndexOutOfBoundsException e) {
            return null;
        }

    }

    /**
     * Возвращает клавишу имеющую фокус ввода, или {@code null}, если ни одна из клавишь фокус
     * ввода не имеет.
     * */
    protected int getSelKeyIndex() { return getKeyIndex(selCol, selRow); }

    /**
     * Возвращает клавишу имеющую фокус ввода, или {@code null}, если ни одна из клавишь фокус
     * ввода не имеет.
     * */
    public Keyboard.Key getSelKey() { return getKey(selCol, selRow); }

    /**
     * Возвращает количество строк в матрице клавиш, или 0, если матрицы нет либо она пуста.
     * */
    public int getRowCount() {
        int[][] matrix = getKeyMatrix();
        if (matrix == null) return 0;
        return matrix.length;
    }

    /**
     * Возвращает количество столбцов в матрице клавиш, или 0, если матрици нет либо она пуста.
     * */
    public int getColCount() {
        if (getRowCount() > 0)
            return getKeyMatrix()[0].length;
        else
            return 0;
    }

    /**
     * Перемещаем фокус ввода на первую клавишу клавиатуры (с индексом 0).
     * */
    public void selectFirstKey() { selCol = 0; selRow = 0; invalidate(); }

    /**
     * Отрисовывает фокус ввода на клавише заданной параметром {@code key}.
     * */
    protected abstract void drawSel(Canvas canvas, Key key);

    /**
     * Отрисовывает объект. Реальная отрисовка происходит в методе предка
     * {@code KeyboardView.OnDraw}, а потом отрисовывается прямоугольник выделения.
     * */
    @Override
    public void onDraw(Canvas canvas) {

        /* Метод предка - рисует клавиатуру */
        super.onDraw(canvas);

        /* Если данные о столбце и строке не корректны, выходим */
        if (selCol == NO_COL || selRow == NO_ROW) return;

        /* Получаем клавишу по строке и столбцу */
        Key key = getKey(selCol, selRow);

        /* Если клавиша существует, вызываем метод отрисовки фокуса */
        if (key != null) drawSel(canvas, key);

    }

    /**
     * Перемещает фокус ввода на следующую клавишу в строке. Возвращает {@code true}, если фокус
     * был перемещен на другую клавишу.
     * */
    public boolean moveSelToNextCol() {

        /* Получаем и проверяем матрицу всех клавишь для текущей клавиатуры */
        int [][] matrix = getKeyMatrix();
        if (matrix == null) return false;

        /* Если текущие данные о столбце не корректны, выходим */
        if (selCol < 0 || selCol >= getColCount()) return false;

        /* Запоминаем текущий столбец */
        int oldCol = selCol;

        /* Индекс клавиши, в следующем столбце */
        int index = NO_KEY;

        /* Перебираем все клавиши в строке, пока не найдем первую с валидным индексом */
        int oldIndex = getKeyIndex(oldCol, selRow);
        do {
            selCol = (selCol + 1) % getColCount();
            index = getKeyIndex(selCol, selRow);
            if (oldIndex != index && index != -1) break;
        } while (oldCol != selCol);


        /* Сравниваем ставое и новое значение индекса столбца */
        if (oldCol != selCol) {
            invalidate(); return true;
        } else
            return false;

    }

    /**
     * Перемещает фокус ввода на предыдущую клавишу в строке. Возвращает {@code true}, если фокус
     * был перемещен на другую клавишу.
     * */
    public boolean moveSelToPrevCol() {

        /* Получаем и проверяем матрицу всех клавишь для текущей клавиатуры */
        int [][] matrix = getKeyMatrix();
        if (matrix == null) return false;

        /* Если текущие данные о столбце не корректны, выходим */
        if (selCol < 0 || selCol >= getColCount()) return false;

        /* Запоминаем текущий столбец */
        int oldCol = selCol;

        /* Индекс клавиши, в следующем столбце */
        int index = NO_KEY;

        /* Перебираем все клавиши в строке, пока не найдем первую с валидным индексом */
        int oldIndex = getKeyIndex(oldCol, selRow);
        do {
            selCol = (selCol - 1 + getColCount()) % getColCount();
            index = getKeyIndex(selCol, selRow);
            if (oldIndex != index && index != -1) break;
        } while (oldCol != selCol);

        /* Сравниваем ставое и новое значение индекса столбца */
        if (oldCol != selCol) {
            invalidate(); return true;
        } else
            return false;

    }

    /**
     * Перемещает фокус ввода на предыдущую клавишу в строке. Возвращает {@code true}, если фокус
     * был перемещен на другую клавишу.
     * */
    public boolean moveSelToPrevRow() {

        /* Получаем и проверяем матрицу всех клавишь для текущей клавиатуры */
        int [][] matrix = getKeyMatrix();
        if (matrix == null) return false;

        /* Если текущие данные о столбце не корректны, выходим */
        if (selRow < 0 || selRow >= getRowCount()) return false;

        /* Запоминаем текущий столбец */
        int oldRow = selRow;

        /* Индекс клавиши, в следующем столбце */
        int index = NO_KEY;

        /* Перебираем все клавиши в строке, пока не найдем первую с валидным индексом */
        int oldIndex = getKeyIndex(selCol, oldRow);
        do {
            selRow = (selRow - 1 + getRowCount()) % getRowCount();
            index = getKeyIndex(selCol, selRow);
            if (oldIndex != index && index != -1) break;
        } while (oldRow != selRow);

        /* Сравниваем ставое и новое значение индекса столбца */
        if (oldRow != selRow) {
            invalidate(); return true;
        } else
            return false;

    }

    /**
     * Перемещает фокус ввода на предыдущую клавишу в строке. Возвращает {@code true}, если фокус
     * был перемещен на другую клавишу.
     * */
    public boolean moveSelToNextRow() {

        /* Получаем и проверяем матрицу всех клавишь для текущей клавиатуры */
        int [][] matrix = getKeyMatrix();
        if (matrix == null) return false;

        /* Если текущие данные о столбце не корректны, выходим */
        if (selRow < 0 || selRow >= getRowCount()) return false;

        /* Запоминаем текущий столбец */
        int oldRow = selRow;

        /* Индекс клавиши, в следующем столбце */
        int index = NO_KEY;

        /* Перебираем все клавиши в строке, пока не найдем первую с валидным индексом */
        int oldIndex = getKeyIndex(selCol, oldRow);
        do {
            selRow = (selRow + 1) % getRowCount();
            index = getKeyIndex(selCol, selRow);
            if (oldIndex != index && index != -1) break;
        } while (oldRow != selRow);


        /* Сравниваем ставое и новое значение индекса столбца */
        if (oldRow != selRow) {
            invalidate(); return true;
        } else
            return false;

    }

}