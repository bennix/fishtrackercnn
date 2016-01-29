/*
 * error.c
 *
 * Code generation for function 'error'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "error.h"

/* Variable Definitions */
static emlrtRTEInfo i_emlrtRTEI = { 17, 9, "error",
  "/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/error.m" };

/* Function Definitions */
void error(const emlrtStack *sp)
{
  static const char_T varargin_1[4] = { 's', 'q', 'r', 't' };

  emlrtErrorWithMessageIdR2012b(sp, &i_emlrtRTEI,
    "Coder:toolbox:ElFunDomainError", 3, 4, 4, varargin_1);
}

/* End of code generation (error.c) */
