# Sets the minimum version of CMake required to build your native library. This ensures that a
# certain set of CMake features is available to your build.

cmake_minimum_required(VERSION 3.4.1)

# Added utils-native-lib library
add_library(utils_native SHARED utils_native.c)
target_link_libraries(utils_native android log)

# Added cpu-native-lib library
add_library(cpu_native SHARED cpu_native.c)
target_link_libraries(cpu_native utils_native android log)