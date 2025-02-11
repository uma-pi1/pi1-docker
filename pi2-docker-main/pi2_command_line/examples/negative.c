// Auxiliary material for PI2 lecture, University of Mannheim
//
// Run with: clang negative.c && ./a.out
//
// Author: Rainer Gemulla

#include <stdio.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
  // bytes
  printf("BYTES:\n");
  for (int8_t i = -3; i <= 3; i++) {
    // %1$ -> first argument
    // hhd -> interpret as signed byte
    // hhu -> interpret as unsigned byte
    printf("signed: %1$2hhd = unsigned: %1$3hhu\n", i);
  }

  // words
  printf("\n32-BIT-WORDS:\n");
  for (int32_t i = -3; i <= 3; i++) {
    // d -> interpret as signed 32-bit word
    // u -> interpret as unsigned 32-bit word
    printf("signed: %1$2d = unsigned: %1$10u\n", i);
  }

  return 0;
}
