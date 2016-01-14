#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include "threefry.h"

int main(void) {

  threefry_t p, k;
  threefry_t c;

  p.c0 = 0x0;
  p.c1 = 0x0;
  k.c0 = 0x0;
  k.c1 = 0x0;


  k.c0 = 0xdeadbeef;
  k.c1 = 0xbadcafe;
  for (int i=0; i<10; i++) {
    p.c0 = i;
    p.c1 = 0x0;
    c = threefry(p, k);
    printf("%"PRIx64" %"PRIx64"\n", c.c0, c.c1);
  }

  return 0;
}
