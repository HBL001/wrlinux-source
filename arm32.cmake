SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_PROCESSOR cortex-a8)

SET(SDK_PATH "/opt/windriver/wrlinux/24.33")
SET(CMAKE_SYSROOT "${SDK_PATH}/sysroots/cortexa8hf-neon-wrs-linux-gnueabi")

SET(CMAKE_C_COMPILER "${SDK_PATH}/sysroots/x86_64-wrlinuxsdk-linux/usr/bin/cortexa8hf-neon-wrs-linux-gnueabi-gcc")
SET(CMAKE_CXX_COMPILER "${SDK_PATH}/sysroots/x86_64-wrlinuxsdk-linux/usr/bin/cortexa8hf-neon-wrs-linux-gnueabi-g++")

# Specify the cross-compilers
set(CMAKE_C_COMPILER "${SDK_PATH}/sysroots/x86_64-wrlinuxsdk-linux/usr/bin/arm-wrs-linux-gnueabi-gcc")
set(CMAKE_CXX_COMPILER "${SDK_PATH}/sysroots/x86_64-wrlinuxsdk-linux/usr/bin/arm-wrs-linux-gnueabi-g++")

# Set compiler flags for the target architecture
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --sysroot=${CMAKE_SYSROOT} -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --sysroot=${CMAKE_SYSROOT} -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard")

# Define the path for finding libraries and headers
set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)