package tv.nemo.box.updater.request;

/**
 * Информация о приложении. Содержит такие сведения как: url, для скачивания приложения; название
 * пакета приложения; версия приложения; описание приложения; название приложения для пользователя.
 *
 * @author Mikhail Malakhov, 29.10.2014
 * */
public class AppData {

    /** URL для скачивания. */
    private final String url;

    /** Имя пакета приложения. */
    private final String appID;

    /** Версия приложения. */
    private final String version;

    /** Название приложения для пользователя. */
    private final String title;

    /** Описание приложения. */
    private final String description;

    /** Имя APK файла для установки. */
    private String fileName = null;

    /**
     * Создает объект {@code AppData} с заданными параметрами.
     *
     * @param url ссылка для скачивания
     * @param appID Имя пакета приложения
     * @param version Версия приложения
     * @param description Описание приложения
     * @param title Название приложения (для пользователя)
     * */
    public AppData(String url, String appID, String version, String title, String description) {
        this.url = url; this.appID = appID; this.title = title;
        this.version = version; this.description = description;
    }

    /**
     * Создает объект {@code AppData} с заданными параметрами.
     *
     * @param url ссылка для скачивания
     * @param appID Имя пакета приложения
     * @param version Версия приложения
     * @param title Название приложения (для пользователя)
     * */
    public AppData(String url, String appID, String version, String title) {
        this.url = url; this.appID = appID; this.title = title;
        this.version = version; this.description = "";
    }

    /** Возвращает URL для скачивания приложения. */
    public String getUrl() {
        return url;
    }

    /** Возвращает имя пакета приложения. */
    public String getAppID() {
        return appID;
    }

    /** Возвращает версию приложения. */
    public String getVersion() { return version; }

    /** Возвращает название приложения (для пользователя) */
    public String getTitle() { return  title; }

    /** Возвращает описание приложения. */
    public String getDescription() { return description; }

    /** Возвращает имя APK файла для установки. */
    public String getFileName() {return fileName; }

    public boolean hasFileName() { return fileName != null && fileName.length() > 0; }

    public void setFileName(String value) { fileName = value; }

}
