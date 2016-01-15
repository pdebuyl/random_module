cmake_minimum_required (VERSION 2.6)

project(rm_threefry C Fortran)

add_library(threefry threefry.c)

add_executable(threefry_simple_example simple_example.c)
target_link_libraries(threefry_simple_example threefry)

add_executable(threefry_int_double int_double.c)
target_link_libraries(threefry_int_double threefry)

set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)
include_directories(${CMAKE_Fortran_MODULE_DIRECTORY})

add_test(NAME threefry_reference_output
COMMAND ${CMAKE_COMMAND} -Dprog=$<TARGET_FILE:threefry_simple_example>
-Dtestfile=${CMAKE_BINARY_DIR}/test_deadbeef_badcafe.txt -Dreffile=${CMAKE_CURRENT_SOURCE_DIR}/Random123_deadbeef_badcafe.txt
-P ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/datafile_test.cmake)
