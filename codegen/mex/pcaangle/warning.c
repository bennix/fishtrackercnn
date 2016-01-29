/*
 * warning.c
 *
 * Code generation for function 'warning'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "warning.h"

/* Variable Definitions */
static emlrtMCInfo emlrtMCI = { 14, 25, "warning",
  "/usr/local/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/warning.m"
};

static emlrtMCInfo b_emlrtMCI = { 14, 9, "warning",
  "/usr/local/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/warning.m"
};

static emlrtRSInfo yb_emlrtRSI = { 14, "warning",
  "/usr/local/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/warning.m"
};

/* Function Declarations */
static void b_feval(const emlrtStack *sp, const mxArray *b, const mxArray *c,
                    emlrtMCInfo *location);
static const mxArray *feval(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, emlrtMCInfo *location);

/* Function Definitions */
static void b_feval(const emlrtStack *sp, const mxArray *b, const mxArray *c,
                    emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  pArrays[0] = b;
  pArrays[1] = c;
  emlrtCallMATLABR2012b(sp, 0, NULL, 2, pArrays, "feval", true, location);
}

static const mxArray *feval(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m4;
  pArrays[0] = b;
  pArrays[1] = c;
  return emlrtCallMATLABR2012b(sp, 1, &m4, 2, pArrays, "feval", true, location);
}

void warning(const emlrtStack *sp)
{
  int32_T i1;
  static const char_T cv1[7] = { 'w', 'a', 'r', 'n', 'i', 'n', 'g' };

  char_T u[7];
  const mxArray *y;
  static const int32_T iv0[2] = { 1, 7 };

  const mxArray *m0;
  static const char_T cv2[7] = { 'm', 'e', 's', 's', 'a', 'g', 'e' };

  char_T b_u[7];
  const mxArray *b_y;
  static const int32_T iv1[2] = { 1, 7 };

  static const char_T msgID[24] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'e', 'i',
    'g', ':', 'N', 'o', 'C', 'o', 'n', 'v', 'e', 'r', 'g', 'e', 'n', 'c', 'e' };

  char_T c_u[24];
  const mxArray *c_y;
  static const int32_T iv2[2] = { 1, 24 };

  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  for (i1 = 0; i1 < 7; i1++) {
    u[i1] = cv1[i1];
  }

  y = NULL;
  m0 = emlrtCreateCharArray(2, iv0);
  emlrtInitCharArrayR2013a(sp, 7, m0, &u[0]);
  emlrtAssign(&y, m0);
  for (i1 = 0; i1 < 7; i1++) {
    b_u[i1] = cv2[i1];
  }

  b_y = NULL;
  m0 = emlrtCreateCharArray(2, iv1);
  emlrtInitCharArrayR2013a(sp, 7, m0, &b_u[0]);
  emlrtAssign(&b_y, m0);
  for (i1 = 0; i1 < 24; i1++) {
    c_u[i1] = msgID[i1];
  }

  c_y = NULL;
  m0 = emlrtCreateCharArray(2, iv2);
  emlrtInitCharArrayR2013a(sp, 24, m0, &c_u[0]);
  emlrtAssign(&c_y, m0);
  st.site = &yb_emlrtRSI;
  b_feval(&st, y, feval(&st, b_y, c_y, &emlrtMCI), &b_emlrtMCI);
}

/* End of code generation (warning.c) */
