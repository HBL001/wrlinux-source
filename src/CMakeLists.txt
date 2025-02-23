set(ASSAY_MANAGER_SRC
    ../include/platform_definitions.h
    assaymanager.cpp
    assaymanager.h
    calibrator.cpp
    calibrator.h
    curve_fit.cpp
    curve_fit.h
    data_processing.cpp
    data_processing.h
    main.cpp
    scan_controller.cpp
    scan_controller.h
    scan_fsm.cpp
    scan_fsm.h
    scan_queues.cpp
    scan_queues.h
    sensor_sequence.cpp
    sensor_sequence.h
)

include_directories(
    ../include
    ../helpers
    ../logging
    ../lmfit-c6.3/lib
    ../InstrumentSoftware
    ${MDB_STORYBOARD_DIR}/include
)

add_executable(assay_manager ${ASSAY_MANAGER_SRC})
target_link_libraries(assay_manager
    ${MDB_STORYBOARD_DIR}/lib/libgreio.a
    ${CMAKE_BINARY_DIR}/lmfit-c6.3/lib/liblmfit.a
    logging
    mecomapi
    instrumentsoftware
    helpers
    -lrt
    dl
    pthread
    ${GPIOD_LIBRARIES}
)

add_dependencies(assay_manager lmfit logging mecomapi instrumentsoftware helpers)

install(TARGETS assay_manager RUNTIME DESTINATION bin)

# Debugging variables. Use cmake-gui to easily change them in cache.
set(DEBUG_CALIBRATOR OFF CACHE BOOL "Enables debugging calibrator.cpp")
if(DEBUG_CALIBRATOR)
    add_definitions(-DCALIBRATOR_DEBUG=1)
endif()

set(DEBUG_CURVE_FIT OFF CACHE BOOL "Enables debugging curve_fit.cpp")
if(DEBUG_CURVE_FIT)
    add_definitions(-DCURVE_FIT_DEBUG=1)
endif()

set(DEBUG_DATA_PROCESSING OFF CACHE BOOL "Enables debugging data_processing.cpp")
if(DEBUG_DATA_PROCESSING)
    add_definitions(-DDATA_PROCESSING_DEBUG=1)
endif()

set(DEBUG_SCAN_CONTROLLER OFF CACHE BOOL "Enables debugging scan_controller.cpp")
if(DEBUG_SCAN_CONTROLLER)
    add_definitions(-DSCAN_CONTROLLER_DEBUG=1)
endif()

set(DEBUG_SCAN_STATE_MACHINE OFF CACHE BOOL "Enables debugging scan_fsm.cpp")
if(DEBUG_SCAN_STATE_MACHINE)
    add_definitions(-DSCAN_STATE_MACHINE_DEBUG=1)
endif()

set(DEBUG_SCAN_QUEUES OFF CACHE BOOL "Enables debugging scan_queues.cpp")
if(DEBUG_SCAN_QUEUES)
    add_definitions(-DSCAN_QUEUES_DEBUG=1)
endif()

set(DEBUG_SENSOR_SEQUENCE OFF CACHE BOOL "Enables debugging sensor_sequence.cpp")
if(DEBUG_SENSOR_SEQUENCE)
    add_definitions(-DSENSOR_SEQUENCE_DEBUG=1)
endif()

set(DEBUG_VISCOELASTIC_PROCESSING OFF CACHE BOOL "Enables debugging viscoelastic_processing.cpp")
if(DEBUG_VISCOELASTIC_PROCESSING)
    add_definitions(-DVISCOELASTIC_PROCESSING_DEBUG=1)
endif()
