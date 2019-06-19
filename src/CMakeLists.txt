cmake_minimum_required(VERSION 3.1)
project(libmpsse
    VERSION 1.3
)

add_library(mpsse "")
add_library(MPSSE::MPSSE ALIAS mpsse)

find_package(Ftdi1)

target_include_directories(mpsse PUBLIC ${CMAKE_CURRENT_LIST_DIR})

if(TARGET Ftdi1::Ftdi1)
    message(STATUS "Using Ftdi1 library")
    set(HAVE_LIBFTDI1 ON)
    target_compile_definitions(mpsse
        PRIVATE
            HAVE_LIBFTDI1=1
    )
endif()
target_link_libraries(mpsse PUBLIC Ftdi1::Ftdi1)

target_sources(mpsse
    PUBLIC
        mpsse.h
        support.h
    PRIVATE
        fast.c
        support.c
        mpsse.c
)

set(PACKAGE_VERSION "${PROJECT_VERSION}")

configure_file(config.h.in config.h @ONLY)
target_include_directories(mpsse PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
