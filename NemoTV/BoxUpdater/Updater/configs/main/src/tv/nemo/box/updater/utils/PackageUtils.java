package tv.nemo.box.updater.utils;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
//import android.content.pm.IPackageDeleteObserver;
//import android.content.pm.IPackageInstallObserver;
import android.content.pm.PackageManager;
import android.net.Uri;

import java.io.File;

/**
 * Класс для работы с пакетами приложений. Содержит методы, позволяющте установить или удалить
 * приложение в нормальном и "тихом" режиме, без уведомления пользователя (на устройстве должен
 * быть root, или приложение должно быть системным и иметь разрешение
 * {@code android.permission.INSTALL_PACKAGES} в манифесте).
 *
 * @author Mikhail Malakhov on 20.10.14.
 *
 */
public class PackageUtils {

    /**
     * Место установки приложений по умолчанию.
     * */
    private static final int    INSTALL_LOCATION_AUTO     = 0;

    /**
     * Установка приложений во внутреннее хранилище.
     * */
    private static final int    INSTALL_LOCATION_INTERNAL = 1;

    /**
     * Установка приложений во внешнее хранилище.
     * */
    private static final int    INSTALL_LOCATION_EXTERNAL = 2;

    /** Префикс команды для установки пакета. */
    private static final String CMD_INSTALL_PREFIX =
            "LD_LIBRARY_PATH=/vendor/lib:/system/lib pm install ";

    /** Префикс команды для удаления пакета. */
    private static final String CMD_UNINSTALL_PREFIX =
            "LD_LIBRARY_PATH=/vendor/lib:/system/lib pm uninstall ";

    /**
     * Проверяет, является ли текущее приложение системным.
     *
     * @param context текущий контекст приложения
     *
     * @return Если текущее приложение является системным - {@code true}, иначе {@code false}.
     * */
    public static boolean isSystemApp(Context context) {
        return context != null && isSystemApp(context, context.getPackageName());
    }

    /**
     * Проверяет, является ли приложение с именем пакета {@code packageName} системным.
     *
     * @param context текущий контекст приложения
     * @param packageName имя пакета приложения, которое нужно проверить
     *
     * @return Если приложение с именем пакета {@code packageName} является системным - {@code true},
     * иначе {@code false}.
     * */
    public static boolean isSystemApp(Context context, String packageName) {
        return context != null && isSystemApp(context.getPackageManager(), packageName);
    }

    /**
     * Проверяет, является ли приложение с именем пакета {@code packageName} системным.
     *
     * @param packageManager объект менеджера пакетов
     * @param packageName имя пакета приложения, которое нужно проверить
     *
     * @return Если приложение с именем пакета {@code packageName} является системным - {@code true},
     * иначе {@code false}.
     * */
    public static boolean isSystemApp(PackageManager packageManager, String packageName) {

        /* Проверка входных параметров */
        if (packageManager == null || packageName == null || packageName.length() <= 0)
            return false;

        /* Получение информации о приложении */
        try {
            ApplicationInfo info = packageManager.getApplicationInfo(packageName, 0);
            return (info != null && (info.flags & ApplicationInfo.FLAG_SYSTEM) > 0);
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    /**
     * Установка приложения в нормальном режиме с использованием интента.
     *
     * @param context текущий контекст приложения
     * @param fileName полное имя файла, вместе с путём поиска
     * */
    public static boolean installNormal(Context context, String fileName) {

        /* Проверка имени файла APK */
        if (fileName == null || fileName.length() <= 0) return false;

        /* Создание объекта файла */
        File file = new File(fileName);

        /* Установка приложения */
        return PackageUtils.installNormal(context, file);
    }

    /**
     * Установка приложения в нормальном режиме с использованием интента.
     *
     * @param context текущий контекст приложения
     * @param file объект, представляющий файл приложения на диске
     * */
    public static boolean installNormal(Context context, File file) {

        /* Проверка входных параметров */
        if (context == null) return false;
        if (!isValidApkFile(file)) return false;

        /* Создание интента и запуск установки приложения */
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive");
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);

        /* Считаем, что приложение будет установленно успешно */
        return true;
    }

    /**
     * Установка приложения в "тихом" режиме, без уведомления пользователя. Для работы этого метода
     * пользователь должен обладать root правами, или приложение должно быть системным и иметь
     * разрешение {@code android.permission.INSTALL_PACKAGES} в манифесте.
     *
     * @param context текущий контекст приложения
     * @param file объект, представляющий файл приложения на диске
     * @param params параметры командной строки менеджера пакетов
     * */
    public static int installByShell(Context context, File file, String params) {
        return installByShell(context, file == null ? null : file.getAbsolutePath(), params);
    }

    /**
     * Установка приложения в "тихом" режиме, без уведомления пользователя. Для работы этого метода
     * пользователь должен обладать root правами, или приложение должно быть системным и иметь
     * разрешение {@code android.permission.INSTALL_PACKAGES} в манифесте.
     *
     * @param context текущий контекст приложения
     * @param fileName полное имя файла, вместе с путём поиска
     * @param params параметры командной строки менеджера пакетов
     * */
    public static int installByShell(Context context, String fileName, String params) {

        /* Проверка входных параметров */
        if (context == null) return PM_FAILED_PREPARE;
        if (!isValidApkFile(fileName)) return INSTALL_FAILED_INVALID_URI;

        /* Формируем команду для установки пакета */
        String cmd = CMD_INSTALL_PREFIX +
                (params != null ? params : "") + " " + fileName.replace(" ", "\\ ");

        /* Выполнение команды */
        ShellUtils.CmdResult cmdResult = ShellUtils.execCmd(cmd, !isSystemApp(context), true);

        /* Если не получили результат */
        if (cmdResult == null) return PM_FAILED_UNKNOWN;

        /* Проверка, всё ли прошло хорошо */
        if (cmdResult.isSuccess())
            return INSTALL_SUCCEEDED;
        else
            return parseErrorMsg(cmdResult.getErrorMsg());
    }

    /**
     * Установка приложения в "тихом" режиме, без уведомления пользователя. Не будет компилироваться
     * на стандартном SDK, использует скрытые методы класса PackageManager. Требует наличия
     * разрешения {@code android.permission.INSTALL_PACKAGES}.
     *
     * @param context текущий контекст приложения
     * @param fileName полное имя файла, вместе с путём поиска
     * @param observer callback интерфейс установщика пакетов, может быть {@code null}
     * */
    /*public static int installByPm(Context context, String fileName, IPackageInstallObserver observer) {

        / Проверка входных параметров /
        if (context == null) return PM_FAILED_PREPARE;
        if (!isValidApkFile(fileName)) return INSTALL_FAILED_INVALID_URI;

        / Установка приложения /
        return installByPm(context, new File(fileName), observer);

    }*/

    /**
     * Установка приложения в "тихом" режиме, без уведомления пользователя. Не будет компилироваться
     * на стандартном SDK, использует скрытые методы класса PackageManager. Требует наличия
     * разрешения {@code android.permission.INSTALL_PACKAGES}.
     *
     * @param context текущий контекст приложения
     * @param file объект, представляющий файл приложения на диске
     * @param observer callback интерфейс установщика пакетов, может быть {@code null}
     * */
    /*public static int installByPm(Context context, File file, IPackageInstallObserver observer) {

        / Проверка входных параметров /
        if (context == null) return PM_FAILED_PREPARE;
        if (!isValidApkFile(file)) return INSTALL_FAILED_INVALID_URI;

        / Получаем ссылку на менеджер пакетов /
        PackageManager pm = context.getPackageManager();

        / Установка приложения /
        pm.installPackage(Uri.fromFile(file), observer, PackageManager.INSTALL_REPLACE_EXISTING,
                null);

        / Считаем что все прошло хорошо /
        return INSTALL_SUCCEEDED;

    }*/

    /**
     * Удаление прилождения в нормальном режиме с использованием интента.
     *
     * @param context текущий контекст приложения
     * @param packageName имя пакета приложения, которое необходимо удалить
     * */
    public static boolean deleteNormal(Context context, String packageName) {

        /* Проверка входных параметров */
        if (packageName == null || packageName.trim().isEmpty()) return false;

        /* Создание интента и запуск удаления приложения */
        Intent intent = new Intent(Intent.ACTION_DELETE, Uri.parse("package:" + packageName));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);

        /* Считаем, что приложение будет удалено успешно */
        return true;
    }

    /**
     * Удаление приложения в "тихом" режиме, без уведомления пользователя. Не будет компилироваться
     * на стандартном SDK, использует скрытые методы класса PackageManager. Требует наличия
     * разрешения {@code android.permission.DELETE_PACKAGES}.
     *
     * @param context текущий контекст приложения
     * @param packageName имя пакета приложения, которое необходимо удалить
     * @param observer callback интерфейс установщика пакетов, может быть {@code null}
     * */
    /*public static int deleteByPm(Context context, String packageName, IPackageDeleteObserver observer) {

        / Проверка входных параметров /
        if (context == null) return PM_FAILED_PREPARE;
        if (packageName == null || packageName.trim().isEmpty()) return
                DELETE_FAILED_INVALID_PACKAGE;

        / Получаем ссылку на менеджер пакетов /
        PackageManager pm = context.getPackageManager();

        / Удаление приложения /
        pm.deletePackage(packageName, observer, PackageManager.DELETE_ALL_USERS);

        / Считаем что все прошло хорошо /
        return DELETE_SUCCEEDED;

    }*/

    /**
     * Удаление приложения в "тихом" режиме, без уведомления пользователя. Для работы этого метода
     * пользователь должен обладать root правами, или приложение должно быть системным и иметь
     * разрешение {@code android.permission.DELETE_PACKAGES} в манифесте.
     *
     * @param context текущий контекст приложения
     * @param packageName имя пакета приложения, которое необходимо удалить
     * @param isKeepData оставить данные приложения - {@code true}, или нет - {@code false}
     * */
    public static int deleteByShell(Context context, String packageName, boolean isKeepData) {

        /* Проверка входных параметров */
        if (context == null) return PM_FAILED_PREPARE;
        if (packageName == null || packageName.length() <= 0) return DELETE_FAILED_INVALID_PACKAGE;

        /* Формируем команду для установки пакета */
        String cmd = CMD_UNINSTALL_PREFIX + (isKeepData ? " -k ": " ") +
                packageName.replace(" ", "\\ ");

        /* Выполнение команды */
        ShellUtils.CmdResult cmdResult = ShellUtils.execCmd(cmd, !isSystemApp(context), true);

        /* Если не получили результат */
        if (cmdResult == null) return PM_FAILED_UNKNOWN;

        /* Проверка, всё ли прошло хорошо */
        if (cmdResult.isSuccess()) return DELETE_SUCCEEDED;

        /* Коды ошибок */
        if (cmdResult.hasErrorMsg() && cmdResult.getErrorMsg().contains("Permission denied"))
            return DELETE_FAILED_PERMISSION_DENIED;

        /* Код ошибки по умолчанию */
        return DELETE_FAILED_INTERNAL_ERROR;
    }

    /**
     * Получение кода возврата из сообщения об ошибке.
     * */
    protected static int parseErrorMsg(String msg) {
        if (msg == null) return PM_FAILED_UNKNOWN;
        if (msg.contains("INSTALL_FAILED_ALREADY_EXISTS")) return INSTALL_FAILED_ALREADY_EXISTS;
        if (msg.contains("INSTALL_FAILED_INVALID_APK")) return INSTALL_FAILED_INVALID_APK;
        if (msg.contains("INSTALL_FAILED_INVALID_URI")) return INSTALL_FAILED_INVALID_URI;
        if (msg.contains("INSTALL_FAILED_INSUFFICIENT_STORAGE")) return INSTALL_FAILED_INSUFFICIENT_STORAGE;
        if (msg.contains("INSTALL_FAILED_DUPLICATE_PACKAGE")) return INSTALL_FAILED_DUPLICATE_PACKAGE;
        if (msg.contains("INSTALL_FAILED_NO_SHARED_USER")) return INSTALL_FAILED_NO_SHARED_USER;
        if (msg.contains("INSTALL_FAILED_UPDATE_INCOMPATIBLE")) return INSTALL_FAILED_UPDATE_INCOMPATIBLE;
        if (msg.contains("INSTALL_FAILED_SHARED_USER_INCOMPATIBLE")) return INSTALL_FAILED_SHARED_USER_INCOMPATIBLE;
        if (msg.contains("INSTALL_FAILED_MISSING_SHARED_LIBRARY")) return INSTALL_FAILED_MISSING_SHARED_LIBRARY;
        if (msg.contains("INSTALL_FAILED_REPLACE_COULDNT_DELETE")) return INSTALL_FAILED_REPLACE_COULDNT_DELETE;
        if (msg.contains("INSTALL_FAILED_DEXOPT")) return INSTALL_FAILED_DEXOPT;
        if (msg.contains("INSTALL_FAILED_OLDER_SDK")) return INSTALL_FAILED_OLDER_SDK;
        if (msg.contains("INSTALL_FAILED_CONFLICTING_PROVIDER")) return INSTALL_FAILED_CONFLICTING_PROVIDER;
        if (msg.contains("INSTALL_FAILED_NEWER_SDK")) return INSTALL_FAILED_NEWER_SDK;
        if (msg.contains("INSTALL_FAILED_TEST_ONLY")) return INSTALL_FAILED_TEST_ONLY;
        if (msg.contains("INSTALL_FAILED_CPU_ABI_INCOMPATIBLE")) return INSTALL_FAILED_CPU_ABI_INCOMPATIBLE;
        if (msg.contains("INSTALL_FAILED_MISSING_FEATURE")) return INSTALL_FAILED_MISSING_FEATURE;
        if (msg.contains("INSTALL_FAILED_CONTAINER_ERROR")) return INSTALL_FAILED_CONTAINER_ERROR;
        if (msg.contains("INSTALL_FAILED_INVALID_INSTALL_LOCATION")) return INSTALL_FAILED_INVALID_INSTALL_LOCATION;
        if (msg.contains("INSTALL_FAILED_MEDIA_UNAVAILABLE")) return INSTALL_FAILED_MEDIA_UNAVAILABLE;
        if (msg.contains("INSTALL_FAILED_VERIFICATION_TIMEOUT")) return INSTALL_FAILED_VERIFICATION_TIMEOUT;
        if (msg.contains("INSTALL_FAILED_VERIFICATION_FAILURE")) return INSTALL_FAILED_VERIFICATION_FAILURE;
        if (msg.contains("INSTALL_FAILED_PACKAGE_CHANGED")) return INSTALL_FAILED_PACKAGE_CHANGED;
        if (msg.contains("INSTALL_FAILED_UID_CHANGED")) return INSTALL_FAILED_UID_CHANGED;
        if (msg.contains("INSTALL_PARSE_FAILED_NOT_APK")) return INSTALL_PARSE_FAILED_NOT_APK;
        if (msg.contains("INSTALL_PARSE_FAILED_BAD_MANIFEST")) return INSTALL_PARSE_FAILED_BAD_MANIFEST;
        if (msg.contains("INSTALL_PARSE_FAILED_UNEXPECTED_EXCEPTION")) return INSTALL_PARSE_FAILED_UNEXPECTED_EXCEPTION;
        if (msg.contains("INSTALL_PARSE_FAILED_NO_CERTIFICATES")) return INSTALL_PARSE_FAILED_NO_CERTIFICATES;
        if (msg.contains("INSTALL_PARSE_FAILED_INCONSISTENT_CERTIFICATES")) return INSTALL_PARSE_FAILED_INCONSISTENT_CERTIFICATES;
        if (msg.contains("INSTALL_PARSE_FAILED_CERTIFICATE_ENCODING")) return INSTALL_PARSE_FAILED_CERTIFICATE_ENCODING;
        if (msg.contains("INSTALL_PARSE_FAILED_BAD_PACKAGE_NAME")) return INSTALL_PARSE_FAILED_BAD_PACKAGE_NAME;
        if (msg.contains("INSTALL_PARSE_FAILED_BAD_SHARED_USER_ID")) return INSTALL_PARSE_FAILED_BAD_SHARED_USER_ID;
        if (msg.contains("INSTALL_PARSE_FAILED_MANIFEST_MALFORMED")) return INSTALL_PARSE_FAILED_MANIFEST_MALFORMED;
        if (msg.contains("INSTALL_PARSE_FAILED_MANIFEST_EMPTY")) return INSTALL_PARSE_FAILED_MANIFEST_EMPTY;
        if (msg.contains("INSTALL_FAILED_INTERNAL_ERROR")) return INSTALL_FAILED_INTERNAL_ERROR;
       return PM_FAILED_UNKNOWN;
    }

    /**
     * Проверка файла APK. Метод проверяет корректность имени и наличие файла на диске.
     *
     * @param fileName полное имя файла, вместе с путём поиска
     *
     * @return True, если файл существует и имеет не нулевой размер, иначе false.
     * */
    protected static boolean isValidApkFile(String fileName) {

        /* Проверка имени файла APK */
        if (fileName == null || fileName.length() <= 0) return false;

        /* Проверка файла на диске и возврат результата */
        File file = new File(fileName);
        return isValidApkFile(file);
    }

    /**
     * Проверка файла APK. Метод проверяет корректность имени и наличие файла на диске.
     *
     * @param file объект, представляющий файл приложения на диске
     *
     * @return True, если файл существует и имеет не нулевой размер, иначе false.
     * */
    protected static boolean isValidApkFile(File file) {
        return file != null && file.exists() && file.isFile() && file.length() > 0;
    }

    /**
     * Код результата, когда не удалось получить сообщение об ошибке или ошибку не удалось
     * идентифицировать.
     * */
    public static final int PM_FAILED_UNKNOWN = -1000;

    /**
     * Код результата, когда возникли проблемы на этапе подготовки параметров для установки или
     * удаления приложений. При этом попытки установить или удалить приложение не происходило.
     * */
    public static final int PM_FAILED_PREPARE = -2000;

    /**
     * Коды возврата менеджера пакета. Взяты из исходников Android. Из оригинальных комментариев
     * удалены ссылки, текст сохранен.
     * */

    /** Installation return code. Installation success. */
    public static final int INSTALL_SUCCEEDED = 1;

    /** Installation return code. The package is already installed. */
    public static final int INSTALL_FAILED_ALREADY_EXISTS = -1;

    /** Installation return code. The package archive file is invalid. */
    public static final int INSTALL_FAILED_INVALID_APK = -2;

    /** Installation return code. The URI passed in is invalid. */
    public static final int INSTALL_FAILED_INVALID_URI = -3;

    /**
     * Installation return code. The package manager service found that the device didn't have
     * enough storage space to install the app.
     */
    public static final int INSTALL_FAILED_INSUFFICIENT_STORAGE = -4;

    /** Installation return code. The package is already installed with the same name. */
    public static final int INSTALL_FAILED_DUPLICATE_PACKAGE = -5;

    /** Installation return code. The requested shared user does not exist. */
    public static final int INSTALL_FAILED_NO_SHARED_USER = -6;

    /**
     * Installation return code. A previously installed package of the same name has a different
     * signature than the new package (and the old package's data was not removed).
     */
    public static final int INSTALL_FAILED_UPDATE_INCOMPATIBLE = -7;

    /**
     * Installation return code. The new package is requested a shared user which is already
     * installed on the device and does not have matching signature.
     */
    public static final int INSTALL_FAILED_SHARED_USER_INCOMPATIBLE = -8;

    /** Installation return code. The new package uses a shared library that is not available. */
    public static final int INSTALL_FAILED_MISSING_SHARED_LIBRARY = -9;

    /**
     * Installation return code. The new package uses a shared library that is not available.
     */
    public static final int INSTALL_FAILED_REPLACE_COULDNT_DELETE = -10;

    /**
     * Installation return code. The new package failed while optimizing and validating its dex
     * files, either because there was not enough storage or the validation failed.
     */
    public static final int INSTALL_FAILED_DEXOPT = -11;

    /**
     * Installation return code. The new package failed because the current SDK version is older
     * than that required by the package.
     */
    public static final int INSTALL_FAILED_OLDER_SDK = -12;

    /**
     * Installation return code. The new package failed because it contains a content provider with
     * the same authority as a provider already installed in the system.
     */
    public static final int INSTALL_FAILED_CONFLICTING_PROVIDER = -13;

    /**
     * Installation return code. The new package failed because the current SDK version is newer
     * than that required by the package.
     */
    public static final int INSTALL_FAILED_NEWER_SDK = -14;

    /**
     * Installation return code. The new package failed because it has specified that it is a
     * test-only package.
     */
    public static final int INSTALL_FAILED_TEST_ONLY = -15;

    /**
     * Installation return code. The package being installed contains native code, but none that is
     * compatible with the the device's CPU_ABI.
     */
    public static final int INSTALL_FAILED_CPU_ABI_INCOMPATIBLE = -16;

    /** Installation return code. The new package uses a feature that is not available. */
    public static final int INSTALL_FAILED_MISSING_FEATURE = -17;

    /**
     * Installation return code. A secure container mount point couldn't be accessed on
     * external media.
     */
    public static final int INSTALL_FAILED_CONTAINER_ERROR = -18;

    /**
     * Installation return code. The new package couldn't be installed in the specified install
     * location.
     */
    public static final int INSTALL_FAILED_INVALID_INSTALL_LOCATION = -19;

    /**
     * Installation return code. The new package couldn't be installed in the specified install
     * location because the media is not available.
     */
    public static final int INSTALL_FAILED_MEDIA_UNAVAILABLE = -20;

    /**
     * Installation return code. The new package couldn't be installed because the verification
     * timed out.
     */
    public static final int INSTALL_FAILED_VERIFICATION_TIMEOUT = -21;

    /**
     * Installation return code. The new package couldn't be installed because the verification
     * did not succeed.
     */
    public static final int INSTALL_FAILED_VERIFICATION_FAILURE = -22;

    /** Installation return code. The package changed from what the calling program expected. */
    public static final int INSTALL_FAILED_PACKAGE_CHANGED = -23;

    /**
     * Installation return code. The new package is assigned a different UID than it
     * previously held.
     */
    public static final int INSTALL_FAILED_UID_CHANGED = -24;

    /**
     * Installation parse return code. The parser was given a path that is not a file, or does
     * not end with the expected '.apk' extension.
     */
    public static final int INSTALL_PARSE_FAILED_NOT_APK = -100;

    /**
     * Installation parse return code. The parser was unable to retrieve the
     * AndroidManifest.xml file.
     */
    public static final int INSTALL_PARSE_FAILED_BAD_MANIFEST = -101;

    /** Installation parse return code. The parser encountered an unexpected exception. */
    public static final int INSTALL_PARSE_FAILED_UNEXPECTED_EXCEPTION = -102;

    /**
     * Installation parse return code. The parser did not find any certificates in the .apk.
     */
    public static final int INSTALL_PARSE_FAILED_NO_CERTIFICATES = -103;

    /**
     * Installation parse return code. The parser found inconsistent certificates on the files
     * in the .apk.
     */
    public static final int INSTALL_PARSE_FAILED_INCONSISTENT_CERTIFICATES = -104;

    /**
     * Installation parse return code. The parser encountered a CertificateEncodingException in
     * one of the files in the .apk.
     */
    public static final int INSTALL_PARSE_FAILED_CERTIFICATE_ENCODING = -105;

    /**
     * Installation parse return code. The parser encountered a bad or missing package name in
     * the manifest.
     */
    public static final int INSTALL_PARSE_FAILED_BAD_PACKAGE_NAME = -106;

    /**
     * Installation parse return code. The parser encountered a bad shared user id name in
     * the manifest.
     */
    public static final int INSTALL_PARSE_FAILED_BAD_SHARED_USER_ID = -107;

    /**
     * Installation parse return code. The parser encountered some structural problem in
     * the manifest.
     */
    public static final int INSTALL_PARSE_FAILED_MANIFEST_MALFORMED = -108;

    /**
     * Installation parse return code. The parser did not find any actionable tags (instrumentation
     * or application) in the manifest.
     */
    public static final int INSTALL_PARSE_FAILED_MANIFEST_EMPTY = -109;

    /**
     * Installation failed return code. The system failed to install the package because of
     * system issues.
     */
    public static final int INSTALL_FAILED_INTERNAL_ERROR = -110;

    /**
     * Return code for when package deletion succeeds. The system succeeded in deleting the package.
     */
    public static final int DELETE_SUCCEEDED = 1;

    /**
     * Deletion failed return code. The system failed to delete the package for an
     * unspecified reason.
     */
    public static final int DELETE_FAILED_INTERNAL_ERROR = -1;

    /**
     * Deletion failed return code. The system failed to delete the package because it is the
     * active DevicePolicy manager.
     */
    public static final int DELETE_FAILED_DEVICE_POLICY_MANAGER = -2;

    /** Deletion failed return code. Invalid package. */
    public static final int DELETE_FAILED_INVALID_PACKAGE = -3;

    /** Deletion failed return code. Permission denied. */
    public static final int DELETE_FAILED_PERMISSION_DENIED = -4;

}