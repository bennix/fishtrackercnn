/*
 * mod.c
 *
 * Code generation for function 'mod'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "mod.h"

/* Variable Definitions */
static emlrtRSInfo ac_emlrtRSI = { 50, "mod",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+scalar/mod.m"
};

/* Function Declarations */
static int32_T div_s32(const emlrtStack *sp, int32_T numerator, int32_T
  denominator);

/* Function Definitions */
static int32_T div_s32(const emlrtStack *sp, int32_T numerator, int32_T
  denominator)
{
  int32_T quotient;
  uint32_T absNumerator;
  uint32_T absDenominator;
  boolean_T quotientNeedsNegation;
  if (denominator == 0) {
    if (numerator >= 0) {
      quotient = MAX_int32_T;
    } else {
      quotient = MIN_int32_T;
    }

    emlrtDivisionByZeroErrorR2012b(NULL, sp);
  } else {
    if (numerator >= 0) {
      absNumerator = (uint32_T)numerator;
    } else {
      absNumerator = (uint32_T)-numerator;
    }

    if (denominator >= 0) {
      absDenominator = (uint32_T)denominator;
    } else {
      absDenominator = (uint32_T)-denominator;
    }

    quotientNeedsNegation = ((numerator < 0) != (denominator < 0));
    absNumerator /= absDenominator;
    if (quotientNeedsNegation) {
      quotient = -(int32_T)absNumerator;
    } else {
      quotient = (int32_T)absNumerator;
    }
  }

  return quotient;
}

int32_T b_mod(const emlrtStack *sp, int32_T x)
{
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &ac_emlrtRSI;
  return x - div_s32(&st, x, 10) * 10;
}

/* End of code generation (mod.c) */
