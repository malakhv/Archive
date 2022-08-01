package tv.nemo.box.updater.utils;

import java.io.File;
import java.io.FileReader;

/**
 * Класс, который содержит методы для работы с Nemo Box TV. Содержит методы для получения различной
 * информации и тд.
 *
 * @author Mikhail Malakhov, 23.10.2014
 *
 */
public class BoxUtils {

    /**
     * Файл, в котором хранится серийный номер устройства в виде строки, которая содержащит коды
     * символов серийного номера с разделителем ":"
     * */
    protected static final String SERIAL_FILE_NAME = "/sys/class/efuse/userdata";

    /**
     * Значение серийного номера, когда получить его реальное значение не удалось.
     * */
    public static final String SERIAL_UNKNOWN = "unknown";

    /**
     * Возвращает серийный номер устройства в виде строки.
     *
     * @return Серийный номер устройства или {@link #SERIAL_UNKNOWN}, если серийный номер
     * получить не удалось.
     * */
    public static String getSerial() {

        /* Буфер для хранения кодов символов серифного номера (из файла) */
        String strBuf;

        /*
         * Получение данных о серийном номере из файла. Данные представляют собой строку,
         * содержащую коды символов серийного номера с разделителем ":"
         * */
        try {
            FileReader fr = new FileReader(new File(SERIAL_FILE_NAME));
            char[] buf = new char[50];
            fr.read(buf);
            strBuf = new String(buf);
            fr.close();
        } catch (Exception e) {
            return SERIAL_UNKNOWN;
        }

        /* Преобразование данных в строку */
        String a[] = strBuf.split(":");
        char[] t = new char[30];
        for (int x = 0; x < a.length; x++) {
            int b = Integer.parseInt(a[x], 16);
            if (b > 0)t[x] = (char) b;
        }

        /* Проверка данных и возврат значения */
        strBuf = new String(t).trim();
        return strBuf.length() > 0 ? strBuf : SERIAL_UNKNOWN;

    }

}
