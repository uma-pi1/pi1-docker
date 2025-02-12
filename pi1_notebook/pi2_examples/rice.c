// Auxiliary material for PI2 lecture, University of Mannheim
//
// Run with: clang rice.c && ./a.out
//
// Author: Rainer Gemulla

#include <stdio.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
  uint64_t grains = 0;       // total number of grain on board

  uint64_t next = 1;           // grains placed on next square
  for (int i = 1; i<=64; i++) {
    grains += next;
    next *= 2;
  }
  printf("There are %lu rice grains on the board.\n", grains);
  printf("After adding one more rice grain, "
         "there are %lu rice grains on the board.\n",
         grains+1);

  return 0;
}
