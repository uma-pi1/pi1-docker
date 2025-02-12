// Auxiliary material for PI2 lecture, University of Mannheim
//
// Run with: clang while_unsigned.c && ./a.out
//
// Author: Rainer Gemulla

#include <stdint.h>
#include <stdio.h>
#include <sys/time.h>

double elapsed(struct timeval start, struct timeval stop) {
  return (double)(stop.tv_usec - start.tv_usec) / 1000000 +
         (double)(stop.tv_sec - start.tv_sec);
}

int main(int argc, char *argv[]) {
  struct timeval start, stop;

  gettimeofday(&start, NULL);
  unsigned char b = 0;
  while (b < (unsigned char)(b + 1))
    b++;
  gettimeofday(&stop, NULL);
  printf("After %fs, loop exited with b=%u and b+1=%u\n", elapsed(start, stop),
         b, (unsigned char)(b + 1));

  gettimeofday(&start, NULL);
  unsigned int i = 0;
  while (i < i + 1)
    i++;
  gettimeofday(&stop, NULL);
  printf("After %fs, loop exited with i=%u and i+1=%u\n", elapsed(start, stop),
         i, i + 1);

  return 0;
}
