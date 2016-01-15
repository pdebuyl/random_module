# Random module

## What is this about?

This repository aims at providing a modular and version controlled implementation of several
pseudo random number generation (PRNG) algorithms. All implementations are done in C, for
convenience with respect to integer arithmetics, and made available to Fortran via the
`iso_c_binding` feature.

The first algorithm that was implemented in this repository is the Mersenne Twister. Now,
the [threefry](http://www.deshawresearch.com/resources_random123.html) PRNG is also
available.

The original code `mt19937ar` from Matsumoto and Nishimura, downloaded from
http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html, is used as a starting point and
separated into a header and a library file. The state is stored as a struct to remove global
variables.

## Licensing

The license for the original code of `mt19937ar` is the 3-clause BSD license:

    Copyright (C) 1997 - 2002, Makoto Matsumoto and Takuji Nishimura

Other files and developments are under the 3-clause BSD license, Pierre de Buyl 2015-2016

