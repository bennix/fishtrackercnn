/*
 * xzlangeM.c
 *
 * Code generation for function 'xzlangeM'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "xzlangeM.h"

/* Function Definitions */
real_T xzlangeM(const creal_T x[4])
{
  real_T y;
  int32_T k;
  boolean_T exitg1;
  real_T absxk;
  y = 0.0;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 4)) {
    absxk = muDoubleScalarHypot(x[k].re, x[k].im);
    if (muDoubleScalarIsNaN(absxk)) {
      y = rtNaN;
      exitg1 = true;
    } else {
      if (absxk > y) {
        y = absxk;
      }

      k++;
    }
  }

  return y;
}

/* End of code generation (xzlangeM.c) */
