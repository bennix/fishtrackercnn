/*
 * pcaangle_terminate.c
 *
 * Code generation for function 'pcaangle_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "pcaangle_terminate.h"
#include "_coder_pcaangle_mex.h"
#include "pcaangle_data.h"

/* Function Definitions */
void pcaangle_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void pcaangle_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (pcaangle_terminate.c) */
