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

#include <jni.h>
#include <android/log.h>
#include "utils_native.h"

/** The tag for LogCat. */
static const char *TAG = "CpuInfoNative";

/** The node includes information about max cpu number. */
static const char *CPU_COUNT_NODE = "/sys/devices/system/cpu/kernel_max";

/**  */
const char *CPU_FREQ_NODE = "/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq";

//static int[] getCpuNumbersFromStr(char *str) {
    //if (str == NULL) return new int[];
    //int first = *str[0];
    //int

//}



int getCpuNumbers() {

}

/**
 * Returns the number of available CPUs on device.
 * */
JNIEXPORT jint JNICALL
Java_com_malakhv_util_CpuInfo_getCount_1native(JNIEnv *env, jclass type) {
    return readInt(CPU_COUNT_NODE, 0);
}

/**
 * Returns the frequency on specified CPU (by number), or -1, if CPU with specified number does
 * not available.
 * */
JNIEXPORT jint JNICALL
Java_com_malakhv_util_CpuInfo_getFreq_1native(JNIEnv *env, jclass type, jint number) {
    /*char *n = its(number);
    char *node = "/sys/devices/system/cpu/cpu";
    strcat(node, n);
    strcat(node, "/cpufreq/scaling_cur_freq");
    return readInt(node, -1);*/
    return 0;
}

/**
 * Returns number of CPUs whitch now are online.
 * */
JNIEXPORT jint JNICALL
Java_com_malakhv_util_CpuInfo_getOnline_1native(JNIEnv *env, jclass type) {

    // TODO

}

/**
 * Returns number of CPUs whitch now are offline.
 * */
JNIEXPORT jint JNICALL
Java_com_malakhv_util_CpuInfo_getOffline_1native(JNIEnv *env, jclass type) {

    // TODO

}

/**
 * Returns number of possible CPUs on device.
 * */
JNIEXPORT jint JNICALL
Java_com_malakhv_util_CpuInfo_getPossible_1native(JNIEnv *env, jclass type) {
    const char *returnValue = readStr("/sys/devices/system/cpu/possible", 16);
    return (*env)->NewStringUTF(env, returnValue);
}

JNIEXPORT jstring JNICALL
Java_com_malakhv_util_CpuInfo_getAll(JNIEnv *env, jclass type) {
    const char *returnValue = readStr("/sys/devices/system/cpu/possible", 16);
    __android_log_write(ANDROID_LOG_DEBUG, TAG, returnValue);
    return (*env)->NewStringUTF(env, returnValue);
}

JNIEXPORT jint JNICALL
Java_com_malakhv_util_CpuInfo_strToInt_1native(JNIEnv *env, jclass type) {
    int n = sti("2 147 483 647", 0);
    return n;
}