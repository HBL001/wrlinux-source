cmake_minimum_required(VERSION 3.10)

project(CoreScanSoftware LANGUAGES CXX C)

# Add options for performing code coverage tests.
include(CMake/Coverage.cmake)

enable_testing()

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Storyboard
set(MDB_STORYBOARD_DIR "/opt/crank/runtimes/linux-raspberry-aarch64-opengles_2.0-drm-obj" CACHE PATH "Path to SotryBoard's SDK.")

message(STATUS "Storyboard runtime: ${MDB_STORYBOARD_DIR}")

# pkg-config, required for detecting libgpiod.
find_package(PkgConfig REQUIRED)

# libgpiod
pkg_check_modules(GPIOD REQUIRED libgpiod)
# sqlite3
pkg_check_modules(SQLITE3 REQUIRED sqlite3)

include(FetchContent)
FetchContent_Declare(
  googletest
  # Specify the commit you depend on and update it regularly.
  # Currently pointing at the release 1.11.0.
  URL https://github.com/google/googletest/archive/e2239ee6043f73722e7aa812a459f54a28552929.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# Versioning ####

# Application version.
# \todo Either use the VERSION file or use this macros.
set(CORESCANSOFTWARE_MAJOR_VERSION "0")
set(CORESCANSOFTWARE_MINOR_VERSION "0")
set(CORESCANSOFTWARE_PATCH_VERSION "0")
# Release/beta candidate, keep empty on official versions.
set(CORESCANSOFTWARE_RC_VERSION "~")

set(CORESCANSOFTWARE_VERSION "${CORESCANSOFTWARE_MAJOR_VERSION}.${CORESCANSOFTWARE_MINOR_VERSION}.${CORESCANSOFTWARE_PATCH_VERSION}${CORESCANSOFTWARE_RC_VERSION}")
set(CORESCANSOFTWARE_VERSION_STRING "${CORESCANSOFTWARE_VERSION}")

# If git is installed add the revision to CORESCANSOFTWARE_VERSION_STRING.
# This is useful to detect development builds, as final builds will not have
# git available.
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.git")
  find_program(GIT_EXECUTABLE NAMES git)
  if(GIT_EXECUTABLE)
    message(STATUS "Found git: ${GIT_EXECUTABLE}")
    execute_process(COMMAND ${GIT_EXECUTABLE} describe
	    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                    OUTPUT_VARIABLE CORESCANSOFTWARE_GIT_DESCRIBE)
    string(REGEX REPLACE "\n" "" CORESCANSOFTWARE_GIT_DESCRIBE "${CORESCANSOFTWARE_GIT_DESCRIBE}")
    string(REGEX REPLACE "${CORESCANSOFTWARE_VERSION}-" "" CORESCANSOFTWARE_GIT_DESCRIBE "${CORESCANSOFTWARE_GIT_DESCRIBE}")
    set(CORESCANSOFTWARE_GIT_DESCRIBE ${CORESCANSOFTWARE_GIT_DESCRIBE})
    set(CORESCANSOFTWARE_VERSION_STRING "${CORESCANSOFTWARE_VERSION_STRING} revision ${CORESCANSOFTWARE_GIT_DESCRIBE}")
  endif()
endif()

# Create the definitions.
add_definitions(
    -DCORESCANSOFTWARE_MAJOR_VERSION="${CORESCANSOFTWARE_MAJOR_VERSION}"
    -DCORESCANSOFTWARE_MINOR_VERSION="${CORESCANSOFTWARE_MINOR_VERSION}"
    -DCORESCANSOFTWARE_PATCH_VERSION="${CORESCANSOFTWARE_PATCH_VERSION}"
    -DCORESCANSOFTWARE_RC_VERSION="${CORESCANSOFTWARE_RC_VERSION}"
    -DCORESCANSOFTWARE_GIT_DESCRIBE="${CORESCANSOFTWARE_GIT_DESCRIBE}"
    -DCORESCANSOFTWARE_VERSION="${CORESCANSOFTWARE_VERSION}"
    -DCORESCANSOFTWARE_VERSION_STRING="${CORESCANSOFTWARE_VERSION_STRING}"
    -DVERSION="${CORESCANSOFTWARE_VERSION}"
)

# Conditionally set RPi 3 ARM64 support.
if(BOARD_RPI3_ARM64)
    add_definitions(-DBOARD_RPI3_ARM64=1)
endif()

# Log the versions.
message(STATUS "CoreScanSoftware version: ${CORESCANSOFTWARE_VERSION}")
message(STATUS "Git describe: ${CORESCANSOFTWARE_GIT_DESCRIBE}")

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

# Other directories.

add_subdirectory(db)
add_subdirectory(lmfit-c6.3)
add_subdirectory(MeComAPI)
add_subdirectory(helpers)
add_subdirectory(logging)
add_subdirectory(InstrumentSoftware)
add_subdirectory(assay-manager)
add_subdirectory(system-manager)
add_subdirectory(data-manager)
#add_subdirectory(unit-tests)
add_subdirectory(viscoprocessing)

#### Doxygen ####
# Thanks http://majewsky.wordpress.com/2010/08/14/tip-of-the-day-cmake-and-doxygen/

# Agrego un target para generar la documentación con Doxygen.
# Target for generating documentation with Doxygen.
find_package(Doxygen)
if(DOXYGEN_FOUND)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in
        ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY
    )

#    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/doc/main.dox.in
#        ${CMAKE_CURRENT_BINARY_DIR}/dox/main.dox @ONLY
#    )

    add_custom_target(doc ${DOXYGEN_EXECUTABLE}
        ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating API documentation with Doxygen" VERBATIM
    )

    # Mark the install target as OPTIONAL so it won't fail if doc has not been generated.
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/doc/ DESTINATION share/assay_manager/doc/ OPTIONAL)
endif(DOXYGEN_FOUND)
