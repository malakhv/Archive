/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

#ifndef __CRYPTO_HPP__
#define __CRYPTO_HPP__

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Encodes the "in" file and stores result to "out" file.
 * */
int encode(const char* in, const char* out);

/**
 * Decodes the "in" file and stores result to "out" file.
 * */
int decode(const char* in, const char* out);

#ifdef __cplusplus
}
#endif

#endif //__CRYPTO_HPP__
