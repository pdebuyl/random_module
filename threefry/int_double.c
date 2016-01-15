#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include "threefry.h"

int main(void) {

  threefry_t p, k;

  p.c0 = 0x0;
  p.c1 = 0x0;
  k.c0 = 0x0;
  k.c1 = 0x0;

  printf("%20.16g\n", threefry_double(&p, &k));
  printf("%20.16g\n", threefry_double(&p, &k));
  printf("%20.16g\n", threefry_double(&p, &k));
  printf("%20.16g\n", threefry_double(&p, &k));

  return 0;
}
