# Random module

## What is this about?

This repository aims at providing a modular and version controlled
implementation of the Mersenne Twister algorithm for pseudo random number
generation.

The original code `mt19937ar` from Matsumoto and Nishimura is used as a starting
point and separated into a header and a library file. The state is stored as a
struct to remove global variables.

A Fortran module links via the `iso_c_binding` to this library.

## Licensing

The license for the original code is the 3-clause BSD license:

    Copyright (C) 1997 - 2002, Makoto Matsumoto and Takuji Nishimura

Other files and developments are under the 3-clause BSD license, Pierre de Buyl 2015

