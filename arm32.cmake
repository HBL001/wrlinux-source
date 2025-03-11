SET(CMAKE_SYSTEM_NAME "Linux")

SET(CMAKE_SYSTEM_PROCESSOR cortex-a8)

SET(SDK_PATH "/opt/windriver/wrlinux/24.33")

SET(CMAKE_SYSROOT "${SDK_PATH}/sysroots/cortexa8hf-neon-wrs-linux-gnueabi")

SET(CMAKE_C_COMPILER "${SDK_PATH}/sysroots/x86_64-wrlinuxsdk-linux/usr/bin/cortexa8hf-neon-wrs-linux-gnueabi-gcc")
SET(CMAKE_CXX_COMPILER "${SDK_PATH}/sysroots/x86_64-wrlinuxsdk-linux/usr/bin/cortexa8hf-neon-wrs-linux-gnueabi-g++")
SET(CMAKE_FIND_ROOT_PATH "${SDK_PATH}/sysroots/cortexa8hf-neon-wrs-linux-gnueabi")
