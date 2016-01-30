/*
 * pcaangle.c
 *
 * Code generation for function 'pcaangle'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "pcaangle_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "div.h"
#include "sort1.h"
#include "warning.h"
#include "xzggev.h"
#include "mean.h"
#include "pcaangle_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 27, "pcaangle",
  "/Users/xuzhiping/fishtrackercnn/pcaangle.m" };

static emlrtRSInfo b_emlrtRSI = { 28, "pcaangle",
  "/Users/xuzhiping/fishtrackercnn/pcaangle.m" };

static emlrtRSInfo c_emlrtRSI = { 31, "pcaangle",
  "/Users/xuzhiping/fishtrackercnn/pcaangle.m" };

static emlrtRSInfo d_emlrtRSI = { 32, "pcaangle",
  "/Users/xuzhiping/fishtrackercnn/pcaangle.m" };

static emlrtRSInfo h_emlrtRSI = { 45, "cov",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/cov.m" };

static emlrtRSInfo i_emlrtRSI = { 101, "cov",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/cov.m" };

static emlrtRSInfo j_emlrtRSI = { 94, "cov",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/cov.m" };

static emlrtRSInfo k_emlrtRSI = { 82, "cov",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/cov.m" };

static emlrtRSInfo l_emlrtRSI = { 78, "cov",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/cov.m" };

static emlrtRSInfo m_emlrtRSI = { 96, "eig",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/matfun/eig.m" };

static emlrtRSInfo n_emlrtRSI = { 103, "eig",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/matfun/eig.m" };

static emlrtRSInfo o_emlrtRSI = { 14, "xzgeev",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzgeev.m"
};

static emlrtRSInfo p_emlrtRSI = { 22, "xzgeev",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzgeev.m"
};

static emlrtRSInfo q_emlrtRSI = { 23, "xzgeev",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzgeev.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 18, "pcaangle",
  "/Users/xuzhiping/fishtrackercnn/pcaangle.m" };

static emlrtRTEInfo c_emlrtRTEI = { 27, 19, "cov",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/cov.m" };

static emlrtRTEInfo d_emlrtRTEI = { 43, 19, "cov",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/lib/matlab/datafun/cov.m" };

/* Function Definitions */
real_T pcaangle(const emlrtStack *sp, emxArray_real_T *x, emxArray_real_T *y)
{
  real_T angle;
  int32_T fm;
  int32_T coltop;
  int32_T b_x[1];
  emxArray_real_T c_x;
  real_T d;
  int32_T k;
  int32_T b_y[1];
  boolean_T b0;
  emxArray_real_T *d_x;
  int32_T m;
  real_T c[4];
  int32_T j;
  real_T s;
  boolean_T b1;
  boolean_T b2;
  creal_T At[4];
  creal_T V[4];
  creal_T beta1[2];
  creal_T alpha1[2];
  real_T absxk;
  real_T t;
  int32_T iidx[2];
  int32_T ind[2];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);

  /* PCAANGLE - Estimate main axis angle of a point cloud */
  /*    */
  /*    ANGLE = PCAANGLE(X, Y) estimates the angle of the main axis of */
  /*    variation from the points (X,Y). If (X,Y) defines an oval point */
  /*    cloud, the major axis of the ellipse is found. */
  /*  */
  /*    ANGLE = PCAANGLE(..., 'visualize') plots the points and the direction */
  /*    of the main axis. */
  /*  */
  /*    PCAANGLE with no arguments starts a demo of the function. */
  /*  */
  /*    If pcaangle is called with no arguments, the function enters */
  /*    demonstration mode.  */
  /* % AUTHOR    : Jï¿ger Hansegï¿rd  */
  /* % $DATE     : 06-Dec-2004 10:13:10 $  */
  /* % DEVELOPED : 7.0.1.24704 (R14) Service Pack 1  */
  /* % FILENAME  : pcaangle.m  */
  /* Remove the mean from the data */
  /*  x = x(:)-cx; */
  /*  y = y(:)-cy; */
  fm = x->size[0];
  coltop = x->size[0];
  b_x[0] = coltop;
  c_x = *x;
  c_x.size = (int32_T *)&b_x;
  c_x.numDimensions = 1;
  st.site = &emlrtRSI;
  d = mean(&st, &c_x);
  k = x->size[0];
  x->size[0] = fm;
  emxEnsureCapacity(sp, (emxArray__common *)x, k, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  for (k = 0; k < fm; k++) {
    x->data[k] -= d;
  }

  fm = y->size[0];
  coltop = y->size[0];
  b_y[0] = coltop;
  c_x = *y;
  c_x.size = (int32_T *)&b_y;
  c_x.numDimensions = 1;
  st.site = &b_emlrtRSI;
  d = mean(&st, &c_x);
  k = y->size[0];
  y->size[0] = fm;
  emxEnsureCapacity(sp, (emxArray__common *)y, k, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  for (k = 0; k < fm; k++) {
    y->data[k] -= d;
  }

  /* Apply PCA to retreive major axis */
  st.site = &c_emlrtRSI;
  if ((!(x->size[0] == 1)) || (!(y->size[0] == 1)) || (y->data[0] == 0.0) ||
      (y->data[0] == 1.0)) {
    b0 = true;
  } else {
    b0 = false;
  }

  if (b0) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &c_emlrtRTEI,
      "Coder:toolbox:cov_thirdInputRequired", 0);
  }

  if (x->size[0] == y->size[0]) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &d_emlrtRTEI,
      "MATLAB:cov:XYlengthMismatch", 0);
  }

  emxInit_real_T(&st, &d_x, 2, &emlrtRTEI, true);
  b_st.site = &h_emlrtRSI;
  coltop = x->size[0];
  fm = y->size[0];
  k = d_x->size[0] * d_x->size[1];
  d_x->size[0] = coltop;
  d_x->size[1] = 2;
  emxEnsureCapacity(&b_st, (emxArray__common *)d_x, k, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  for (k = 0; k < coltop; k++) {
    d_x->data[k] = x->data[k];
  }

  for (k = 0; k < fm; k++) {
    d_x->data[k + d_x->size[0]] = y->data[k];
  }

  fm = d_x->size[0];
  m = d_x->size[0];
  for (k = 0; k < 4; k++) {
    c[k] = 0.0;
  }

  if (d_x->size[0] == 0) {
    for (k = 0; k < 4; k++) {
      c[k] = rtNaN;
    }
  } else if (d_x->size[0] == 1) {
  } else {
    for (j = 0; j < 2; j++) {
      s = 0.0;
      c_st.site = &l_emlrtRSI;
      if (1 > m) {
        b1 = false;
      } else {
        b1 = (m > 2147483646);
      }

      if (b1) {
        d_st.site = &g_emlrtRSI;
        check_forloop_overflow_error(&d_st);
      }

      for (coltop = 1; coltop <= m; coltop++) {
        s += d_x->data[(coltop + d_x->size[0] * j) - 1];
      }

      s /= (real_T)fm;
      c_st.site = &k_emlrtRSI;
      for (coltop = 0; coltop + 1 <= m; coltop++) {
        d_x->data[coltop + d_x->size[0] * j] -= s;
      }
    }

    fm--;
    for (j = 0; j < 2; j++) {
      d = 0.0;
      c_st.site = &j_emlrtRSI;
      if (1 > m) {
        b2 = false;
      } else {
        b2 = (m > 2147483646);
      }

      if (b2) {
        d_st.site = &g_emlrtRSI;
        check_forloop_overflow_error(&d_st);
      }

      for (k = 0; k + 1 <= m; k++) {
        d += d_x->data[k + d_x->size[0] * j] * d_x->data[k + d_x->size[0] * j];
      }

      c[j + (j << 1)] = d / (real_T)fm;
      coltop = j + 2;
      while (coltop < 3) {
        s = 0.0;
        c_st.site = &i_emlrtRSI;
        for (k = 0; k + 1 <= m; k++) {
          s += d_x->data[k + d_x->size[0]] * d_x->data[k + d_x->size[0] * j];
        }

        c[1 + (j << 1)] = s / (real_T)fm;
        c[2 + j] = c[1 + (j << 1)];
        coltop = 3;
      }
    }
  }

  emxFree_real_T(&d_x);
  st.site = &d_emlrtRSI;
  b_st.site = &m_emlrtRSI;
  for (k = 0; k < 4; k++) {
    At[k].re = c[k];
    At[k].im = 0.0;
  }

  c_st.site = &o_emlrtRSI;
  xzggev(&c_st, At, &fm, alpha1, beta1, V);
  for (coltop = 0; coltop <= 3; coltop += 2) {
    c_st.site = &p_emlrtRSI;
    d = 0.0;
    s = 2.2250738585072014E-308;
    for (k = coltop; k + 1 <= coltop + 2; k++) {
      absxk = muDoubleScalarAbs(V[k].re);
      if (absxk > s) {
        t = s / absxk;
        d = 1.0 + d * t * t;
        s = absxk;
      } else {
        t = absxk / s;
        d += t * t;
      }

      absxk = muDoubleScalarAbs(V[k].im);
      if (absxk > s) {
        t = s / absxk;
        d = 1.0 + d * t * t;
        s = absxk;
      } else {
        t = absxk / s;
        d += t * t;
      }
    }

    d = s * muDoubleScalarSqrt(d);
    c_st.site = &q_emlrtRSI;
    for (j = coltop; j + 1 <= coltop + 2; j++) {
      V[j] = b_div(V[j], d);
    }
  }

  for (k = 0; k < 4; k++) {
    At[k].re = 0.0;
    At[k].im = 0.0;
  }

  for (k = 0; k < 2; k++) {
    if (beta1[k].im == 0.0) {
      if (alpha1[k].im == 0.0) {
        At[k + (k << 1)].re = alpha1[k].re / beta1[k].re;
        At[k + (k << 1)].im = 0.0;
      } else if (alpha1[k].re == 0.0) {
        At[k + (k << 1)].re = 0.0;
        At[k + (k << 1)].im = alpha1[k].im / beta1[k].re;
      } else {
        At[k + (k << 1)].re = alpha1[k].re / beta1[k].re;
        At[k + (k << 1)].im = alpha1[k].im / beta1[k].re;
      }
    } else if (beta1[k].re == 0.0) {
      if (alpha1[k].re == 0.0) {
        At[k + (k << 1)].re = alpha1[k].im / beta1[k].im;
        At[k + (k << 1)].im = 0.0;
      } else if (alpha1[k].im == 0.0) {
        At[k + (k << 1)].re = 0.0;
        At[k + (k << 1)].im = -(alpha1[k].re / beta1[k].im);
      } else {
        At[k + (k << 1)].re = alpha1[k].im / beta1[k].im;
        At[k + (k << 1)].im = -(alpha1[k].re / beta1[k].im);
      }
    } else {
      absxk = muDoubleScalarAbs(beta1[k].re);
      d = muDoubleScalarAbs(beta1[k].im);
      if (absxk > d) {
        s = beta1[k].im / beta1[k].re;
        d = beta1[k].re + s * beta1[k].im;
        At[k + (k << 1)].re = (alpha1[k].re + s * alpha1[k].im) / d;
        At[k + (k << 1)].im = (alpha1[k].im - s * alpha1[k].re) / d;
      } else if (d == absxk) {
        if (beta1[k].re > 0.0) {
          d = 0.5;
        } else {
          d = -0.5;
        }

        if (beta1[k].im > 0.0) {
          s = 0.5;
        } else {
          s = -0.5;
        }

        At[k + (k << 1)].re = (alpha1[k].re * d + alpha1[k].im * s) / absxk;
        At[k + (k << 1)].im = (alpha1[k].im * d - alpha1[k].re * s) / absxk;
      } else {
        s = beta1[k].re / beta1[k].im;
        d = beta1[k].im + s * beta1[k].re;
        At[k + (k << 1)].re = (s * alpha1[k].re + alpha1[k].im) / d;
        At[k + (k << 1)].im = (s * alpha1[k].im - alpha1[k].re) / d;
      }
    }
  }

  if (fm != 0) {
    b_st.site = &n_emlrtRSI;
    warning(&b_st);
  }

  for (j = 0; j < 2; j++) {
    alpha1[j] = At[j * 3];
  }

  sort(alpha1, iidx);
  for (coltop = 0; coltop < 2; coltop++) {
    ind[coltop] = iidx[coltop];
  }

  /* Extract the angle of the major axis */
  angle = muDoubleScalarAtan2(V[1 + ((ind[1] - 1) << 1)].re, V[(ind[1] - 1) << 1]
    .re) / 3.1415926535897931 * 180.0;
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return angle;
}

/* End of code generation (pcaangle.c) */
