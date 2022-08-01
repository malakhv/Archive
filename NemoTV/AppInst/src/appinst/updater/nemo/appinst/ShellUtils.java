package appinst.updater.nemo.appinst;

import java.io.DataOutputStream;

/**
 * Класс для работы с командами оболочки Android (shell commands).
 *
 * @author Mikhail Malakhov on 20.10.14.
 *
 */
public class ShellUtils {

    /** Команда "SU" */
    private static final String CMD_SU = "su";

    /** Команда "SH" */
    private static final String CMD_SH = "sh";

    /** Команда "exit" */
    private static final String CMD_EXIT = "exit\n";

    /** Символ конца строки в строке команд */
    private static final String CMD_LINE_END = "\n";

    /**
     * Код результата выполнения команды. Пустая команда.
     * */
    public static final int EXEC_CMD_FAILED = -1;

    /**
     * Сообщение об ошибке при выполнении команды. Пустая команда.
     * */
    public static final String EXEC_FAILED_CMD_EMPTY_MSG = "Execution failed, command is empty";

    /**
     * Выполняет команды оболочки (shell commands) заданные параметром {@code commands}.
     *
     * @param command команда оболочки, которую необходимо выполнить
     * @param isRoot нужно ли выполнять команду от имени суперпользователя (root)
     *
     * @return Объект {@link CmdResult}, который содержит информацию о результате выполнения команд.
     */
    public static CmdResult execCmd(String command, boolean isRoot) {
        try {
            return execCmdEx(new String[] {command}, isRoot, true);
        } catch (Exception e) {
            return new CmdResult(EXEC_CMD_FAILED, null, e.getMessage());
        }
    }

    /**
     * Выполняет команды оболочки (shell commands) заданные параметром {@code commands}.
     *
     * @param command команда оболочки, которую необходимо выполнить
     * @param isRoot нужно ли выполнять команду от имени суперпользователя (root)
     * @param isNeedResultMsg нужно ли получить сообщения команды и сообщения об ошибках
     *
     * @return Объект {@link CmdResult}, который содержит информацию о результате выполнения команд.
     */
    public static CmdResult execCmd(String command, boolean isRoot, boolean isNeedResultMsg) {
        try {
            return execCmdEx(new String[] {command}, isRoot, isNeedResultMsg);
        } catch (Exception e) {
            return new CmdResult(EXEC_CMD_FAILED, null, e.getMessage());
        }
    }

    /**
     * Выполняет команды оболочки (shell commands) заданные параметром {@code commands}.
     *
     * @param commands массив команд оболочки, которые необходимо выполнить
     * @param isRoot нужно ли выполнять команды от имени суперпользователя (root)
     * @param isNeedResultMsg нужно ли получить сообщения команд и сообщения об ошибках
     *
     * @return Объект {@link CmdResult}, который содержит информацию о результате выполнения команд.
     */
    public static CmdResult execCmd(String[] commands, boolean isRoot, boolean isNeedResultMsg) {
        try {
            return execCmdEx(commands, isRoot, isNeedResultMsg);
        } catch (Exception e) {
            return new CmdResult(EXEC_CMD_FAILED, null, e.getMessage());
        }
    }

    /**
     * Выполняет команды оболочки (shell commands) заданные параметром {@code commands}.
     *
     * @param commands массив команд оболочки, которые необходимо выполнить
     * @param isRoot нужно ли выполнять команды от имени суперпользователя (root)
     * @param isNeedResultMsg нужно ли получить сообщения команд и сообщения об ошибках
     *
     * @return Объект {@link CmdResult}, который содержит информацию о результате выполнения команд.
     *
     * @throws Exception Ошибки ввода вывода и другие ошибки, которые могли возникнуть при
     * подготовке данных для выполнения команд или при анализе результата их выполнения.
     */
    public static CmdResult execCmdEx(String[] commands, boolean isRoot, boolean isNeedResultMsg)
            throws Exception {

        /* Код результата по умолчанию */
        int result = -1;

        /* Проверка входных параметров */
        if (commands == null || commands.length == 0)
            return new CmdResult(EXEC_CMD_FAILED, null, EXEC_FAILED_CMD_EMPTY_MSG);

        /* Сообщения команд */
        String successMsg = null;
        /* Сообщения об ошибке */
        String errorMsg = null;

        /* Внешний процесс */
        Process process = null;
        /* Поток для записи команд */
        DataOutputStream os = null;

        /* Выполнение команд */
        try {

            /* Получение внешнего процесса */
            process = Runtime.getRuntime().exec(isRoot ? CMD_SU : CMD_SH);

            /* Получение потока внешнего процесса для записи команд */
            os = new DataOutputStream(process.getOutputStream());

            /* Запись команд в поток */
            for (String command : commands) {
                /* Если очередной команды нет */
                if (command == null) continue;
                /* Запись */
                os.write(command.getBytes());
                os.writeBytes(CMD_LINE_END); os.flush();
            }

            /* Команда exit) */
            os.writeBytes(CMD_EXIT); os.flush();

            /* Ожидание завершения внешнего процесса */
            result = process.waitFor();

            /* Получение сообщений (если необходимо) */
            if (isNeedResultMsg) {
                /* Сообщения команд */
                successMsg = StreamUtils.toString(process.getInputStream(), true);
                /* Сообщения об ошибках */
                errorMsg = StreamUtils.toString(process.getErrorStream(), true);
            }

        } finally {

            /* Закрываем поток для записи команд */
            if (os != null) os.close();
            /* Закрываем внешний процесс */
            if (process != null) process.destroy();
        }

        /* Формирование результата работы метода */
        return new CmdResult(result, successMsg, errorMsg);
    }

    /**
     * Класс для хранения информации о результате выполнения команд оболочки в Android. Содержит
     * поля кода результата, сообщения команд и сообщения об ошибках (в случае неудачи).
     *
     * @author Mikhail Malakhov
     * @author <a href="http://www.trinea.cn" target="_blank">Trinea</a>
     *
     * */
    public static class CmdResult {

        /** Команды оболочки информация о выполнении которых хранится в объекте */
        private final String cmd;

        /** Код результата выполнения команд. **/
        private final int code;

        /** Сообщения команд. **/
        private final String successMsg;

        /** Сообщения об ошибках. **/
        private final String errorMsg;

        /**
         * Создает объект {@link appinst.updater.nemo.appinst.ShellUtils.CmdResult} с заданными
         * параметрами.
         *
         * @param cmd команды оболочки Android
         * @param code код результата выполнения команд
         *
         * */
        public CmdResult(String cmd, int code) { this(cmd, code, null, null); }

        /**
         * Создает объект {@link appinst.updater.nemo.appinst.ShellUtils.CmdResult} с заданными
         * параметрами.
         *
         * @param cmd команда оболочки Android
         * @param code код результата выполнения команд
         * @param successMsg сообщения команд
         * @param errorMsg сообщения об ошибках
         *
         * */
        public CmdResult(String cmd, int code, String successMsg, String errorMsg) {
            this.cmd = cmd;
            this.code = code;
            this.successMsg = successMsg.trim().isEmpty() ? null : successMsg;
            this.errorMsg = errorMsg.trim().isEmpty() ? null : errorMsg;
        }

        /**
         * Преобразует массив команд в строку.
         * */
        private String cmdsToString(String[] cmds) {

            /* Проверка входных параметров */
            if (cmds == null || cmds.length <= 0) return null;

            /* Преобразование массива строк в строку */
            StringBuilder sBuilder = new StringBuilder();
            for (String cmd : cmds)
                if (cmd != null && cmd.length() > 0)
                    sBuilder.append(cmd).append("\n");
            return sBuilder.toString();
        }

        /**
         * Создает объект {@link appinst.updater.nemo.appinst.ShellUtils.CmdResult} с заданными
         * параметрами.
         *
         * @param code код результата выполнения команд
         * @param successMsg сообщения команд
         * @param errorMsg сообщения об ошибках
         *
         * */
        public CmdResult(int code, String successMsg, String errorMsg) {
            this.cmd = null;
            this.code = code;
            this.successMsg = successMsg.trim().isEmpty() ? null : successMsg;
            this.errorMsg = errorMsg.trim().isEmpty() ? null : errorMsg;
        }

        /** Возвращает текущее значение кода результата выполнения команд. */
        public int getCode() { return code; }

        /** Возвращает команды оболочки Android. */
        public String getCmd() {return cmd; }

        /**
         * Возвращает сообщение об успешном выполнении команды, или {@code null}, если
         * сообщения нет.
         * */
        public String getSuccessMsg() { return successMsg; }

        /**
         * Проверяет, есть ли сообщения команд.
         * */
        public boolean hasSuccessMsg() { return getSuccessMsg() != null; }

        /**
         * Проверяет, есть ли в сообщениях команд слова "Success" или "success", что обычно говорит
         * об успешном выполнении команды.
         * */
        public boolean isSuccess() {
            return hasSuccessMsg() &&
                    (successMsg.contains("Success") || successMsg.contains("success"));
        }

        /** Возвращает сообщения об ошибках, или {@code null}, если сообщений нет. */
        public String getErrorMsg() { return errorMsg; }

        /**
         * Проверяет, есть ли сообщения об ошибках.
         * */
        public boolean hasErrorMsg() { return getErrorMsg() != null; }

        /**
         * Вычисляет hash код для объекта.
         * */
        @Override
        public int hashCode() {
            return 31 * code + (successMsg != null ? successMsg.hashCode() : 0) +
                    (errorMsg != null ? errorMsg.hashCode() : 0);
        }

        /**
         * Возвращает данные объекта в виде строки.
         * */
        @Override
        public String toString() {
            return "Result code: " + code + "\n" +
                    "Success Msg: " + (successMsg != null ? successMsg : "") + "\n" +
                    "Error Msg: " + (errorMsg != null ? errorMsg : "");
        }

    }

}