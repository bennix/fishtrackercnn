/*
 * _coder_pcaangle_api.c
 *
 * Code generation for function '_coder_pcaangle_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "_coder_pcaangle_api.h"
#include "pcaangle_emxutil.h"
#include "pcaangle_data.h"

/* Variable Definitions */
static emlrtRTEInfo b_emlrtRTEI = { 1, 1, "_coder_pcaangle_api", "" };

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static const mxArray *c_emlrt_marshallOut(const real_T u);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *x, const
  char_T *identifier, emxArray_real_T *y);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  c_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  int32_T iv3[1];
  boolean_T bv0[1] = { true };

  static const int32_T dims[1] = { -1 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims, &bv0[0],
    iv3);
  ret->size[0] = iv3[0];
  ret->allocatedSize = ret->size[0];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static const mxArray *c_emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m3;
  y = NULL;
  m3 = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m3);
  return y;
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *x, const
  char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(x), &thisId, y);
  emlrtDestroyArray(&x);
}

void pcaangle_api(const mxArray *prhs[2], const mxArray *plhs[1])
{
  emxArray_real_T *x;
  emxArray_real_T *y;
  real_T angle;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T1(&st, &x, 1, &b_emlrtRTEI, true);
  emxInit_real_T1(&st, &y, 1, &b_emlrtRTEI, true);
  prhs[0] = emlrtProtectR2012b(prhs[0], 0, false, -1);
  prhs[1] = emlrtProtectR2012b(prhs[1], 1, false, -1);

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "x", x);
  emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "y", y);

  /* Invoke the target function */
  angle = pcaangle(&st, x, y);

  /* Marshall function outputs */
  plhs[0] = c_emlrt_marshallOut(angle);
  y->canFreeData = false;
  emxFree_real_T(&y);
  x->canFreeData = false;
  emxFree_real_T(&x);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_pcaangle_api.c) */
