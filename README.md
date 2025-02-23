## Using the Toolchain ##

To utilize your wrlinux_toolchain.cmake file for cross-compiling your C++ code in the ~/wrlinux-source directory using CMake, follow these steps:

### 1. Ensure the Toolchain File is Correct:

Your wrlinux_toolchain.cmake file should accurately define the cross-compilation environment. Here's an example configuration:

```
# Specify the target system name and architecture
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Define the cross compiler executables
set(CMAKE_C_COMPILER arm-wrs-linux-gnueabi-gcc)
set(CMAKE_CXX_COMPILER arm-wrs-linux-gnueabi-g++)

# Specify the sysroot path
set(CMAKE_SYSROOT /opt/wrlinux-toolchain/sysroots/armv7at2hf-neon-wrs-linux-gnueabi)

# Adjust the search paths for the compiler
set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT})

# Configure the find commands to search only in the specified paths
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

```

### 2. Invoke CMake with the Toolchain File: 

Navigate to your build directory and run CMake, specifying your toolchain file:

```
cd ~/wrlinux-source
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../wrlinux_toolchain.cmake ..

```
This command directs CMake to use the specified toolchain file for configuring the project.

### 3. Build the Project:

After configuration, compile your project using:

```
make -j4 #(if you have a good PC this can be 16)
```

This process will generate binaries tailored for the target architecture defined in your toolchain file.

### Additional Considerations:

Environment Variables: Ensure that the cross-compilation tools (e.g., arm-wrs-linux-gnueabi-gcc) are accessible in your system's PATH. If they're located in a non-standard directory, you might need to adjust the CMAKE_PREFIX_PATH or update your PATH environment variable accordingly.

CMake Version: Verify that you're using a compatible version of CMake that supports the features required for your project.

