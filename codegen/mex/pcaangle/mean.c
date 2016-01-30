/*
 * mean.c
 *
 * Code generation for function 'mean'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "mean.h"
#include "eml_int_forloop_overflow_check.h"
#include "isequal.h"
#include "pcaangle_data.h"

/* Variable Definitions */
static emlrtRSInfo e_emlrtRSI = { 34, "mean",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/mean.m" };

static emlrtRSInfo f_emlrtRSI = { 36, "combine_vector_elements",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/private/combine_vector_elements.m"
};

static emlrtRTEInfo e_emlrtRTEI = { 29, 5, "mean",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/mean.m" };

static emlrtRTEInfo f_emlrtRTEI = { 20, 5, "mean",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/mean.m" };

static emlrtRTEInfo g_emlrtRTEI = { 16, 15, "mean",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/mean.m" };

/* Function Definitions */
real_T mean(const emlrtStack *sp, const emxArray_real_T *x)
{
  real_T y;
  boolean_T overflow;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  if ((x->size[0] == 1) || (x->size[0] != 1)) {
    overflow = true;
  } else {
    overflow = false;
  }

  if (overflow) {
  } else {
    emlrtErrorWithMessageIdR2012b(sp, &g_emlrtRTEI,
      "Coder:toolbox:autoDimIncompatibility", 0);
  }

  overflow = !isequal(x);
  if (overflow) {
  } else {
    emlrtErrorWithMessageIdR2012b(sp, &f_emlrtRTEI,
      "Coder:toolbox:UnsupportedSpecialEmpty", 0);
  }

  overflow = !isequal(x);
  if (overflow) {
  } else {
    emlrtErrorWithMessageIdR2012b(sp, &e_emlrtRTEI,
      "Coder:toolbox:UnsupportedSpecialEmpty", 0);
  }

  st.site = &e_emlrtRSI;
  if (x->size[0] == 0) {
    y = 0.0;
  } else {
    y = x->data[0];
    b_st.site = &f_emlrtRSI;
    if (2 > x->size[0]) {
      overflow = false;
    } else {
      overflow = (x->size[0] > 2147483646);
    }

    if (overflow) {
      c_st.site = &g_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = 2; k <= x->size[0]; k++) {
      y += x->data[k - 1];
    }
  }

  y /= (real_T)x->size[0];
  return y;
}

/* End of code generation (mean.c) */
