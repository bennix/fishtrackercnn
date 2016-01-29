/*
 * div.c
 *
 * Code generation for function 'div'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "div.h"

/* Function Definitions */
creal_T b_div(const creal_T x, real_T y)
{
  creal_T z;
  if (x.im == 0.0) {
    z.re = x.re / y;
    z.im = 0.0;
  } else if (x.re == 0.0) {
    z.re = 0.0;
    z.im = x.im / y;
  } else {
    z.re = x.re / y;
    z.im = x.im / y;
  }

  return z;
}

/* End of code generation (div.c) */
