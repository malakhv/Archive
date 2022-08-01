package keyboard.nemo.box;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Rect;
import android.inputmethodservice.Keyboard;
import android.util.AttributeSet;

/**
 * Created by malakhv on 21.11.14.
 */
public class NemoKeyboardView extends NavKeyboardView {

    /** Область для отрисовки прямоугольника выделения. */
    private Rect selRect = new Rect(0,0,0,0);

    /** Цвет прямоугольника выделения. */
    private int selColor = Color.argb(0x77, 0x00, 0xFF, 0x00);

    /** Матрица всех клавишь */
    final int[][] keyMatrix = new int[][] {
            { 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 10},
            {11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22},
            {23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 22},
            {34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 22},
            {45, 46, 47, 47, 47, 47, 47, 47, 47, 48, 49, 50}
    };

    /**
     * Создаёт новый объект {@code BasicKeyboardView} с заданными параметрами.
     */
    public NemoKeyboardView(Context context, AttributeSet attrs) { super(context, attrs); }

    /**
     * Создаёт новый объект {@code BasicKeyboardView} с заданными параметрами.
     */
    public NemoKeyboardView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    /**
     * Возвращает матрицу всех клавишь клавиатуры, или {@code null}, если матрицы нет или она пуста.
     */
    @Override
    protected int[][] getKeyMatrix() { return keyMatrix; }

    /**
     * Отрисовывает фокус ввода на клавише заданной параметром {@code key}.
     */
    @Override
    protected void drawSel(Canvas canvas, Keyboard.Key key) {

        /* Проверка входных параметров */
        if (key == null) return;

        /* Расчет прямоугольной области */
        selRect.set(key.x, key.y, key.x + key.width, key.y + key.height);

        /* Отрисовка прямоугольной области */
        canvas.clipRect(selRect);
        canvas.drawColor(selColor);

    }

}
