package com.malakhv.testapp;

/**
 * Class contains methods for print an information to system out.
 * @author Mikhail.Malakhov
 * */
public class Console {

    /** The Empty string. */
    private static final String STR_EMPTY = "";

    /** The string that used as separator. */
    private static final String STR_SEP =
            "#---------------------------------------------------------------------------------------------------";

    /**
     * Print an empty string.
     * */
    public static void empty() {
        println(STR_EMPTY);
    }

    /**
     * Print a single line.
     * */
    public static void line() {
        System.out.println(STR_SEP);
    }

    /**
     * Print a header with specified title.
     * */
    public static void header(String title) {
        empty(); line();
        print("# "); System.out.println(title);
        line(); empty();
    }

    public static void paragraph(String text) {
        String[] array = text.split(" ");
        String tmp = "";
        String w = "";
        for (int i = 0; i < array.length; i++) {
            w = array[i];
            if ((tmp.length() + w.length()) >= 92) {
                println(tmp.trim());
                tmp = "";
            }
            tmp += w + " ";
        }
        if (!tmp.isEmpty()) {
            println(tmp.trim());
        }
    }

    public static void split(String text, int maxSize) {
        String[] array = text.split(" ");
        String tmp = "";
        String w = "";
        for (int i = 0; i < array.length; i++) {
            w = array[i];
            if ((tmp.length() + w.length()) >= maxSize) {
                println(tmp.trim());
                tmp = "";
            }
            tmp += w + " ";
        }
        if (!tmp.isEmpty()) {
            println(tmp.trim());
        }
    }

    public static String alignment(String text, int size) {
        int d = size - text.length();
        if (d > 10 || d <= 0) return text;
        String res = "";
        for (int i = 0; i < text.length(); i++) {
            String c = String.valueOf(text.charAt(i));
            res += c;
            if (c.equals(" ") && d > 0) {
                res +=" "; d--;
            }
        }
        return res;
    }

    public static void print(String value) {
        System.out.print(value);
    }

    public static void println(String value) {
        String v = alignment(value, 92);
        System.out.println("\t" + v);
    }

    public static void time() {
        System.currentTimeMillis();
    }



}
