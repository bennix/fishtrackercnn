/*
 * xzlartg.c
 *
 * Code generation for function 'xzlartg'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "xzlartg.h"
#include "error.h"
#include "eml_int_forloop_overflow_check.h"
#include "pcaangle_data.h"

/* Variable Definitions */
static emlrtRSInfo fb_emlrtRSI = { 67, "xzlartg",
  "/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+reflapack/xzlartg.m"
};

static emlrtRSInfo gb_emlrtRSI = { 93, "xzlartg",
  "/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+reflapack/xzlartg.m"
};

static emlrtRSInfo hb_emlrtRSI = { 102, "xzlartg",
  "/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+reflapack/xzlartg.m"
};

static emlrtRSInfo ib_emlrtRSI = { 106, "xzlartg",
  "/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+reflapack/xzlartg.m"
};

/* Function Definitions */
void xzlartg(const emlrtStack *sp, const creal_T f, const creal_T g, real_T *cs,
             creal_T *sn)
{
  real_T scale;
  real_T f2s;
  real_T g2;
  real_T fs_re;
  real_T fs_im;
  real_T gs_re;
  real_T gs_im;
  int32_T count;
  int32_T rescaledir;
  boolean_T guard1 = false;
  real_T g2s;
  boolean_T b3;
  boolean_T b4;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  scale = muDoubleScalarAbs(f.re);
  f2s = muDoubleScalarAbs(f.im);
  if (f2s > scale) {
    scale = f2s;
  }

  f2s = muDoubleScalarAbs(g.re);
  g2 = muDoubleScalarAbs(g.im);
  if (g2 > f2s) {
    f2s = g2;
  }

  if (f2s > scale) {
    scale = f2s;
  }

  fs_re = f.re;
  fs_im = f.im;
  gs_re = g.re;
  gs_im = g.im;
  count = 0;
  rescaledir = 0;
  guard1 = false;
  if (scale >= 7.4428285367870146E+137) {
    do {
      count++;
      fs_re *= 1.3435752215134178E-138;
      fs_im *= 1.3435752215134178E-138;
      gs_re *= 1.3435752215134178E-138;
      gs_im *= 1.3435752215134178E-138;
      scale *= 1.3435752215134178E-138;
    } while (!(scale < 7.4428285367870146E+137));

    rescaledir = 1;
    guard1 = true;
  } else if (scale <= 1.3435752215134178E-138) {
    if ((g.re == 0.0) && (g.im == 0.0)) {
      *cs = 1.0;
      sn->re = 0.0;
      sn->im = 0.0;
    } else {
      do {
        count++;
        fs_re *= 7.4428285367870146E+137;
        fs_im *= 7.4428285367870146E+137;
        gs_re *= 7.4428285367870146E+137;
        gs_im *= 7.4428285367870146E+137;
        scale *= 7.4428285367870146E+137;
      } while (!(scale > 1.3435752215134178E-138));

      rescaledir = -1;
      guard1 = true;
    }
  } else {
    guard1 = true;
  }

  if (guard1) {
    scale = fs_re * fs_re + fs_im * fs_im;
    g2 = gs_re * gs_re + gs_im * gs_im;
    f2s = g2;
    if (1.0 > g2) {
      f2s = 1.0;
    }

    if (scale <= f2s * 2.0041683600089728E-292) {
      if ((f.re == 0.0) && (f.im == 0.0)) {
        *cs = 0.0;
        scale = muDoubleScalarHypot(gs_re, gs_im);
        sn->re = gs_re / scale;
        sn->im = -gs_im / scale;
      } else {
        st.site = &fb_emlrtRSI;
        if (g2 < 0.0) {
          b_st.site = &v_emlrtRSI;
          error(&b_st);
        }

        g2s = muDoubleScalarSqrt(g2);
        *cs = muDoubleScalarHypot(fs_re, fs_im) / g2s;
        f2s = muDoubleScalarAbs(f.re);
        g2 = muDoubleScalarAbs(f.im);
        if (g2 > f2s) {
          f2s = g2;
        }

        if (f2s > 1.0) {
          scale = muDoubleScalarHypot(f.re, f.im);
          fs_re = f.re / scale;
          fs_im = f.im / scale;
        } else {
          f2s = 7.4428285367870146E+137 * f.re;
          g2 = 7.4428285367870146E+137 * f.im;
          scale = muDoubleScalarHypot(f2s, g2);
          fs_re = f2s / scale;
          fs_im = g2 / scale;
        }

        gs_re /= g2s;
        gs_im = -gs_im / g2s;
        sn->re = fs_re * gs_re - fs_im * gs_im;
        sn->im = fs_re * gs_im + fs_im * gs_re;
      }
    } else {
      st.site = &gb_emlrtRSI;
      f2s = 1.0 + g2 / scale;
      if (f2s < 0.0) {
        b_st.site = &v_emlrtRSI;
        error(&b_st);
      }

      f2s = muDoubleScalarSqrt(f2s);
      *cs = 1.0 / f2s;
      scale += g2;
      fs_re = f2s * fs_re / scale;
      fs_im = f2s * fs_im / scale;
      sn->re = fs_re * gs_re - fs_im * -gs_im;
      sn->im = fs_re * -gs_im + fs_im * gs_re;
      if (rescaledir > 0) {
        st.site = &hb_emlrtRSI;
        if (1 > count) {
          b3 = false;
        } else {
          b3 = (count > 2147483646);
        }

        if (b3) {
          b_st.site = &g_emlrtRSI;
          check_forloop_overflow_error(&b_st);
        }
      } else {
        if (rescaledir < 0) {
          st.site = &ib_emlrtRSI;
          if (1 > count) {
            b4 = false;
          } else {
            b4 = (count > 2147483646);
          }

          if (b4) {
            b_st.site = &g_emlrtRSI;
            check_forloop_overflow_error(&b_st);
          }
        }
      }
    }
  }
}

/* End of code generation (xzlartg.c) */
