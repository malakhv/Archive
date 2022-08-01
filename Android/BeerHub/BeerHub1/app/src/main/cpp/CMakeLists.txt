#
# Copyright (C) 2018 DevLear - All Rights Reserved.
#
# This file is a part of BeerHub application.
#
# Confidential and Proprietary.
# Unauthorized copying of this file, via any medium is strictly prohibited.
#

cmake_minimum_required(VERSION 3.4.1)

# Extarnal libs
set(external_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../../../external)
add_library(lib_crypto STATIC IMPORTED)
set_target_properties(lib_crypto PROPERTIES IMPORTED_LOCATION
        ${external_DIR}/crypto/lib/${ANDROID_ABI}/libcrypto.a)

# Application's shared lib
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
add_library( crypto_jni SHARED crypto_jni.cpp )
target_include_directories(crypto_jni PRIVATE ${external_DIR}/crypto/include)
target_link_libraries( crypto_jni lib_crypto log )
