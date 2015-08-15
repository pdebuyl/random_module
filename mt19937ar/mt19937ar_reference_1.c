#include <stdio.h>
#include "mt19937ar.h"

int main(void)
{
    int i;
    unsigned long init[4]={0x123, 0x234, 0x345, 0x456};
    int length=4;
    mt19937ar_t s;
    int j=0;
    init_by_array(&s, init, length);

    for (i=0; i<4; i++) {
      printf("%11lu\n", genrand_int32(&s));
    }
    for (i=0; i<2000; i++) {
      j = j + genrand_int32(&s);
    }
    for (i=0; i<4; i++) {
      printf("%11lu\n", genrand_int31(&s));
    }

    return 0;
}
