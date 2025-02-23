cmake_minimum_required(VERSION 3.10)

# Set the name of the target operating system
set(CMAKE_SYSTEM_NAME Linux)

# Specify the target architecture
set(CMAKE_SYSTEM_PROCESSOR arm)

# Define the cross compiler executables
set(CMAKE_C_COMPILER arm-wrs-linux-gnueabi-gcc)
set(CMAKE_CXX_COMPILER arm-wrs-linux-gnueabi-g++)

# Define the path to the Wind River SDK
set(WR_SDK_PATH /opt/wrlinux-toolchain)

# Specify the sysroot path
set(CMAKE_SYSROOT ${WR_SDK_PATH}/sysroots/armv7at2hf-neon-wrs-linux-gnueabi)

# Adjust the search paths for the compiler
set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT})

# Configure the find commands to search only in the specified paths
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
