/* *
 * Copyright (C) 2012 Mikhail Malakhov <malakhv@live.ru>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * */

/* *
 * Author Mikhail.Malakhov [malakhv@live.ru|https://github.com/malakhv]
 * */

#include <stdio.h>
#include <string.h>
#include <android/log.h>
#include <stdbool.h>
#include "utils_native.h"

/** The tag for LogCat. */
static const char *TAG = "NativeUtils";

// Boolean type
//typedef int bool;
//#define true 1
//#define false 0

/** The '0' character. */
static const char CHAR_ZERO = '0';

/** The ' ' (space) character. */
static const char CHAR_SPACE = 32;

/** The '-' character. */
static const char CHAR_DASH = 45;

/**
 * Returns true, if specified value is digit (0..9).
 * */
static bool digit(char value) {
    return  value >= 48 && value <= 57;
}

/**
 * Convert an integer value to string (char*).
 * */
char* its(int value) {
    char *str = NULL;
    sprintf(str, "%n", &value);
    return str;
}

/**
 * Convert a char value to integer.
 * */
static int cti(char value) {
    return value - CHAR_ZERO;
}

/**
 * Convert a string (char*) to integer.
 * */
int sti(const char *value, int def) {
    int len = (int) strlen(value);
    if (len <= 0) return def;

    // Negative or not
    bool negative = value[0] == CHAR_DASH;

    // Make number
    char current;
    int number = def;
    for (int i = len - 1, k = 1; i >= 0 + negative; i--) {
        current = value[i];
        if (current == CHAR_SPACE) continue; // Ignore any spaces
        if (digit(current)) {
            number = number + cti(value[i]) * k;
        } else {
            return def; // Default
        }
        k = k * 10;
    }
    return negative ? number * -1 : number;
}

/** Error Messages table. */
enum {
    MSG_ERROR_UNKNOWN = -1,
    MSG_ERROR_FILE_OPEN_READ,
    MSG_ERROR_FILE_OPEN_WRITE,
    MSG_ERROR_FILE_READ,
    MSG_ERROR_FILE_WRITE
};

/**
 * Write specified error log message (by id).
 * */
static void writeErrorLog(int msg_id) {
    const char *msg = NULL;
    switch (msg_id) {
        case MSG_ERROR_FILE_OPEN_READ:
            msg = "Can not open file for read";
            break;
        case MSG_ERROR_FILE_OPEN_WRITE:
            msg = "Can not open file for write";
            break;
        case MSG_ERROR_FILE_READ:
            msg = "Can not read from file";
            break;
        case MSG_ERROR_FILE_WRITE:
            msg = "Can not write to file";
            break;
        default:;
    }
    if (msg != NULL) {
        __android_log_write(ANDROID_LOG_ERROR, TAG, msg);
    }
}

/**
 * Open specified file for read.
 * */
static FILE* openr(const char* path) {
    FILE *file = fopen(path,"r");
    if (file == NULL) writeErrorLog(MSG_ERROR_FILE_OPEN_READ);
    return file;
}

/**
 * Open specified file for write.
 * */
static FILE* openw(const char* path) {
    FILE *file = fopen(path,"w");
    if (file == NULL) writeErrorLog(MSG_ERROR_FILE_OPEN_WRITE);
    return file;
}

/**
 * Read an int value from the specified file (by path).
 * @returns the int value if success, or -1;
 * */
int readInt(const char* path, int def) {
    FILE *file = openr(path);
    int value = def;
    if(file != NULL && !fscanf(file,"%i",&value)) {
        value = def; writeErrorLog(MSG_ERROR_FILE_READ);
    }
    fclose(file);
    return value;
}

/**
 * Read a stirng (char*) value from the specified file (by path).
 * @returns the string (char*) value if success, or NULL;
 * */
const char* readStr(const char* path, int len) {
    FILE *file = openr(path);
    char *str = NULL;
    if(file != NULL) {
        str = malloc(len * sizeof(char));
        str = fgets(str, len, file);
        if (str == NULL) writeErrorLog(MSG_ERROR_FILE_READ);
        __android_log_write(ANDROID_LOG_DEBUG, TAG, str);
        fclose(file);
    }
    return str;
}