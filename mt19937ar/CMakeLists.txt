cmake_minimum_required (VERSION 2.6)

project(rm_mt19937ar C)

add_library(mt19937ar mt19937ar.c)

add_executable(mt19937ar_original_test mt19937ar_original_test.c)
target_link_libraries(mt19937ar_original_test mt19937ar)

add_test(NAME mt19937ar_reference_output
COMMAND ${CMAKE_COMMAND} -Dprog=$<TARGET_FILE:mt19937ar_original_test>
-Dtestfile=${CMAKE_BINARY_DIR}/mt19937ar.test -Dreffile=${CMAKE_CURRENT_SOURCE_DIR}/mt19937ar.out
-P ${CMAKE_SOURCE_DIR}/cmake/datafile_test.cmake)
