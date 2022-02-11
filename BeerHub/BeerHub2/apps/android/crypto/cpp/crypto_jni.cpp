/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub project.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

#include <jni.h>
#include <android/log.h>
#include <crypto.h>

#define LOGE(...) \
  ((void)__android_log_print(ANDROID_LOG_ERROR, "Crypto", __VA_ARGS__))

//
// Decodes the "in" file and stores result to "out" file.
//
extern "C"
JNIEXPORT jint JNICALL
Java_com_devlear_libs_crypto_Crypto_decode_1native (JNIEnv *env, jclass thiz,
        jstring in, jstring out) {
    const char* in_path = env->GetStringUTFChars(in, 0);
    const char* out_path = env->GetStringUTFChars(out, 0);
    int result = decode(in_path, out_path);
    if (result > 0) {
        LOGE("Decode error...");
    }
    env->ReleaseStringUTFChars(in, in_path);
    env->ReleaseStringUTFChars(out, out_path);
    return result;
}