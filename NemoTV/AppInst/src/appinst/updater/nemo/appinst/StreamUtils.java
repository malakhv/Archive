package appinst.updater.nemo.appinst;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * Класс, содержащий методы для работы с потоками данных.
 *
 * @author Mikhail Malakhov, 20.10.2014
 */
public class StreamUtils {

    /**
     * Преобразует поток данных в строку.
     *
     * @param is поток данных который будет преобразован в строку.
     * @param doClose если равен {@code true}, после извлечения данных поток будет закрыт
     *
     * @throws IOException ошибка чтения данных из потока.
     * */
    public static String toStringEx(InputStream is, boolean doClose) throws IOException {

        /* Проверка входных параметров */
        if (is == null) return null;
        if (is.available() <= 0 ) return "";

        /* Объекты для построения строк и чтения из потока */
        StringBuilder sBuilder = new StringBuilder();
        BufferedReader bReader = new BufferedReader(new InputStreamReader(is));

        /* Обработка данных */
        try {
            String buf;
            while ((buf = bReader.readLine()) != null) sBuilder.append(buf);
        } finally {
            /* Закрытие буфера чтения и потока */
            if (bReader != null) bReader.close();
            if (doClose) is.close();
        }

        /* Возврат результата */
        return sBuilder.toString();

    }

    /**
     * Преобразует поток данных в строку.
     *
     * @param is поток данных который будет преобразован в строку.
     * @param doClose если равен {@code true}, после извлечения данных поток будет закрыт
     * */
    public static String toString(InputStream is, boolean doClose) {
        try {
            return toStringEx(is, doClose);
        } catch (IOException e) {
            return null;
        }
    }

    /**
     * Преобразует поток данных в строку. После извлечения данных поток будет закрыт автоматически.
     *
     * @param is поток данных который будет преобразован в строку.
     * */
    public static String toString(InputStream is) {
        try {
            return toStringEx(is, true);
        } catch (IOException e) {
            return null;
        }
    }

}
