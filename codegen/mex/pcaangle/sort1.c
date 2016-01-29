/*
 * sort1.c
 *
 * Code generation for function 'sort1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "sort1.h"
#include "relop.h"

/* Function Definitions */
void sort(creal_T x[2], int32_T idx[2])
{
  creal_T b_x[2];
  int32_T i;
  boolean_T p;
  for (i = 0; i < 2; i++) {
    b_x[i] = x[i];
  }

  if (relop(x[0], x[1]) || (muDoubleScalarIsNaN(x[1].re) || muDoubleScalarIsNaN
       (x[1].im))) {
    p = true;
  } else {
    p = false;
  }

  if (p) {
    idx[0] = 1;
    idx[1] = 2;
  } else {
    idx[0] = 2;
    idx[1] = 1;
    b_x[0] = x[1];
    b_x[1] = x[0];
  }

  for (i = 0; i < 2; i++) {
    x[i] = b_x[i];
  }
}

/* End of code generation (sort1.c) */
