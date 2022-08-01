package serialnumber.nemo.test.serialnumber;

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
     * Возвращает серийный номер устройства в виде строки.
     *
     * @return Серийный номер устройства или {@code null}, если серийный номер получить не удалось.
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
            e.printStackTrace();
            return null;
        }

        /* Преобразование данных в строку */
        String a[] = strBuf.split(":");
        char[] t = new char[30];
        for (int x = 0; x < a.length; x++) {
            int b = Integer.parseInt(a[x], 16);
            if (b > 0)t[x] = (char) b;
        }
        return new String(t);
    }

}
