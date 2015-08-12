cmake_minimum_required (VERSION 2.6)

project(random_module NONE)
enable_testing()

add_subdirectory(mt19937ar)

add_test(reference_output
${CMAKE_COMMAND} -Dprog=/pierre/code/random_module/build/mt19937ar/mt19937ar
-Dtestfile=mt19937ar.test -Dreffile=${CMAKE_SOURCE_DIR}/mt19937ar/mt19937ar.out
-P ${CMAKE_SOURCE_DIR}/cmake/datafile_test.cmake)
