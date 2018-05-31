cmake_minimum_required (VERSION 2.6)

project(xoroshiro128plus_m C Fortran)

add_library(xoroshiro128plus xoroshiro128plus.c)
set_property(TARGET xoroshiro128plus PROPERTY C_STANDARD 99)

set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)
include_directories(${CMAKE_Fortran_MODULE_DIRECTORY})

add_library(xoroshiro128plus_m xoroshiro128plus_m.f90)
target_link_libraries(xoroshiro128plus_m xoroshiro128plus)
