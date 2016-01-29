/*
 * pcaangle_initialize.c
 *
 * Code generation for function 'pcaangle_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "pcaangle_initialize.h"
#include "_coder_pcaangle_mex.h"
#include "pcaangle_data.h"

/* Function Definitions */
void pcaangle_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (pcaangle_initialize.c) */
