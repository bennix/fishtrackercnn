/*
 * xzhgeqz.c
 *
 * Code generation for function 'xzhgeqz'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "xzhgeqz.h"
#include "mod.h"
#include "error.h"
#include "eml_int_forloop_overflow_check.h"
#include "xzlartg.h"
#include "sqrt.h"
#include "div.h"
#include "pcaangle_data.h"

/* Variable Definitions */
static emlrtRSInfo jb_emlrtRSI = { 10, "xzrot_rows",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzrot_rows.m"
};

static emlrtRSInfo kb_emlrtRSI = { 10, "xzrot_cols",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzrot_cols.m"
};

static emlrtRSInfo lb_emlrtRSI = { 447, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

static emlrtRSInfo mb_emlrtRSI = { 435, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

static emlrtRSInfo nb_emlrtRSI = { 423, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

static emlrtRSInfo ob_emlrtRSI = { 421, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

static emlrtRSInfo pb_emlrtRSI = { 412, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

static emlrtRSInfo qb_emlrtRSI = { 402, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

static emlrtRSInfo rb_emlrtRSI = { 110, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

static emlrtRSInfo sb_emlrtRSI = { 37, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

static emlrtRSInfo tb_emlrtRSI = { 20, "xzlanhs",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzlanhs.m"
};

static emlrtRSInfo ub_emlrtRSI = { 21, "xzlanhs",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzlanhs.m"
};

static emlrtRSInfo vb_emlrtRSI = { 57, "xzlanhs",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzlanhs.m"
};

static emlrtRSInfo bc_emlrtRSI = { 332, "xzhgeqz",
  "/Applications/MATLAB_R2015b.app/toolbox/eml/eml/+coder/+internal/+reflapack/xzhgeqz.m"
};

/* Function Definitions */
void xzhgeqz(const emlrtStack *sp, creal_T A[4], int32_T ilo, int32_T ihi,
             creal_T Z[4], int32_T *info, creal_T alpha1[2], creal_T beta1[2])
{
  int32_T i;
  real_T eshift_re;
  real_T eshift_im;
  creal_T ctemp;
  real_T rho_re;
  real_T rho_im;
  real_T anorm;
  real_T scale;
  real_T sumsq;
  boolean_T firstNonZero;
  boolean_T b_ilo;
  int32_T j;
  int32_T jp1;
  boolean_T c_ilo;
  real_T reAij;
  real_T imAij;
  real_T temp2;
  real_T b_atol;
  boolean_T failed;
  boolean_T guard1 = false;
  boolean_T guard2 = false;
  int32_T ifirst;
  int32_T istart;
  int32_T ilast;
  int32_T ilastm1;
  int32_T iiter;
  int32_T maxit;
  boolean_T goto60;
  boolean_T goto70;
  boolean_T goto90;
  boolean_T b5;
  int32_T jiter;
  int32_T exitg1;
  boolean_T exitg3;
  boolean_T b_guard1 = false;
  creal_T b_A;
  creal_T t1;
  creal_T d;
  boolean_T exitg2;
  boolean_T b6;
  boolean_T b7;
  boolean_T b8;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  *info = 0;
  for (i = 0; i < 2; i++) {
    alpha1[i].re = 0.0;
    alpha1[i].im = 0.0;
    beta1[i].re = 1.0;
    beta1[i].im = 0.0;
  }

  eshift_re = 0.0;
  eshift_im = 0.0;
  ctemp.re = 0.0;
  ctemp.im = 0.0;
  rho_re = 0.0;
  rho_im = 0.0;
  st.site = &sb_emlrtRSI;
  anorm = 0.0;
  if (ilo > ihi) {
  } else {
    scale = 0.0;
    sumsq = 0.0;
    firstNonZero = true;
    b_st.site = &tb_emlrtRSI;
    if (ilo > ihi) {
      b_ilo = false;
    } else {
      b_ilo = (ihi > 2147483646);
    }

    if (b_ilo) {
      c_st.site = &g_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (j = ilo; j <= ihi; j++) {
      jp1 = j + 1;
      if (ihi < j + 1) {
        jp1 = ihi;
      }

      b_st.site = &ub_emlrtRSI;
      if (ilo > jp1) {
        c_ilo = false;
      } else {
        c_ilo = (jp1 > 2147483646);
      }

      if (c_ilo) {
        c_st.site = &g_emlrtRSI;
        check_forloop_overflow_error(&c_st);
      }

      for (i = ilo; i <= jp1; i++) {
        reAij = A[(i + ((j - 1) << 1)) - 1].re;
        imAij = A[(i + ((j - 1) << 1)) - 1].im;
        if (reAij != 0.0) {
          anorm = muDoubleScalarAbs(reAij);
          if (firstNonZero) {
            sumsq = 1.0;
            scale = anorm;
            firstNonZero = false;
          } else if (scale < anorm) {
            temp2 = scale / anorm;
            sumsq = 1.0 + sumsq * temp2 * temp2;
            scale = anorm;
          } else {
            temp2 = anorm / scale;
            sumsq += temp2 * temp2;
          }
        }

        if (imAij != 0.0) {
          anorm = muDoubleScalarAbs(imAij);
          if (firstNonZero) {
            sumsq = 1.0;
            scale = anorm;
            firstNonZero = false;
          } else if (scale < anorm) {
            temp2 = scale / anorm;
            sumsq = 1.0 + sumsq * temp2 * temp2;
            scale = anorm;
          } else {
            temp2 = anorm / scale;
            sumsq += temp2 * temp2;
          }
        }
      }
    }

    b_st.site = &vb_emlrtRSI;
    if (sumsq < 0.0) {
      c_st.site = &v_emlrtRSI;
      error(&c_st);
    }

    anorm = scale * muDoubleScalarSqrt(sumsq);
  }

  reAij = 2.2204460492503131E-16 * anorm;
  b_atol = 2.2250738585072014E-308;
  if (reAij > 2.2250738585072014E-308) {
    b_atol = reAij;
  }

  reAij = 2.2250738585072014E-308;
  if (anorm > 2.2250738585072014E-308) {
    reAij = anorm;
  }

  imAij = 1.0 / reAij;
  failed = true;
  for (j = ihi; j + 1 < 3; j++) {
    alpha1[j] = A[j + (j << 1)];
  }

  guard1 = false;
  guard2 = false;
  if (ihi >= ilo) {
    ifirst = ilo;
    istart = ilo;
    ilast = ihi - 1;
    ilastm1 = ihi - 2;
    iiter = 0;
    maxit = 30 * ((ihi - ilo) + 1);
    goto60 = false;
    goto70 = false;
    goto90 = false;
    st.site = &rb_emlrtRSI;
    if (1 > maxit) {
      b5 = false;
    } else {
      b5 = (maxit > 2147483646);
    }

    if (b5) {
      b_st.site = &g_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    jiter = 1;
    do {
      exitg1 = 0;
      if (jiter <= maxit) {
        if (ilast + 1 == ilo) {
          goto60 = true;
        } else if (muDoubleScalarAbs(A[ilast + (ilastm1 << 1)].re) +
                   muDoubleScalarAbs(A[ilast + (ilastm1 << 1)].im) <= b_atol) {
          A[ilast + (ilastm1 << 1)].re = 0.0;
          A[ilast + (ilastm1 << 1)].im = 0.0;
          goto60 = true;
        } else {
          j = ilastm1;
          exitg3 = false;
          while ((!exitg3) && (j + 1 >= ilo)) {
            if (j + 1 == ilo) {
              firstNonZero = true;
            } else if (muDoubleScalarAbs(A[j + ((j - 1) << 1)].re) +
                       muDoubleScalarAbs(A[j + ((j - 1) << 1)].im) <= b_atol) {
              A[j + ((j - 1) << 1)].re = 0.0;
              A[j + ((j - 1) << 1)].im = 0.0;
              firstNonZero = true;
            } else {
              firstNonZero = false;
            }

            if (firstNonZero) {
              ifirst = j + 1;
              goto70 = true;
              exitg3 = true;
            } else {
              j--;
            }
          }
        }

        if (goto60 || goto70) {
          firstNonZero = true;
        } else {
          firstNonZero = false;
        }

        if (!firstNonZero) {
          for (i = 0; i < 2; i++) {
            alpha1[i].re = rtNaN;
            alpha1[i].im = 0.0;
            beta1[i].re = rtNaN;
            beta1[i].im = 0.0;
          }

          for (jp1 = 0; jp1 < 4; jp1++) {
            Z[jp1].re = rtNaN;
            Z[jp1].im = 0.0;
          }

          *info = 1;
          exitg1 = 1;
        } else {
          b_guard1 = false;
          if (goto60) {
            goto60 = false;
            alpha1[ilast] = A[ilast + (ilast << 1)];
            ilast = ilastm1;
            ilastm1--;
            if (ilast + 1 < ilo) {
              failed = false;
              guard2 = true;
              exitg1 = 1;
            } else {
              iiter = 0;
              eshift_re = 0.0;
              eshift_im = 0.0;
              b_guard1 = true;
            }
          } else {
            if (goto70) {
              goto70 = false;
              iiter++;
              st.site = &bc_emlrtRSI;
              if (b_mod(&st, iiter) != 0) {
                b_A.re = -(A[ilast + (ilast << 1)].re - A[ilastm1 + (ilastm1 <<
                            1)].re);
                b_A.im = -(A[ilast + (ilast << 1)].im - A[ilastm1 + (ilastm1 <<
                            1)].im);
                t1 = b_div(b_A, 2.0);
                d.re = (t1.re * t1.re - t1.im * t1.im) + (A[ilastm1 + (ilast <<
                  1)].re * A[ilast + (ilastm1 << 1)].re - A[ilastm1 + (ilast <<
                  1)].im * A[ilast + (ilastm1 << 1)].im);
                d.im = (t1.re * t1.im + t1.im * t1.re) + (A[ilastm1 + (ilast <<
                  1)].re * A[ilast + (ilastm1 << 1)].im + A[ilastm1 + (ilast <<
                  1)].im * A[ilast + (ilastm1 << 1)].re);
                b_sqrt(&d);
                rho_re = A[ilastm1 + (ilastm1 << 1)].re - (t1.re - d.re);
                rho_im = A[ilastm1 + (ilastm1 << 1)].im - (t1.im - d.im);
                anorm = A[ilastm1 + (ilastm1 << 1)].re - (t1.re + d.re);
                reAij = A[ilastm1 + (ilastm1 << 1)].im - (t1.im + d.im);
                if (muDoubleScalarHypot(rho_re - A[ilast + (ilast << 1)].re,
                                        rho_im - A[ilast + (ilast << 1)].im) <=
                    muDoubleScalarHypot(anorm - A[ilast + (ilast << 1)].re,
                                        reAij - A[ilast + (ilast << 1)].im)) {
                  anorm = rho_re;
                  reAij = rho_im;
                  rho_re = t1.re - d.re;
                  rho_im = t1.im - d.im;
                } else {
                  rho_re = t1.re + d.re;
                  rho_im = t1.im + d.im;
                }
              } else {
                eshift_re += A[ilast + (ilastm1 << 1)].re;
                eshift_im += A[ilast + (ilastm1 << 1)].im;
                anorm = eshift_re;
                reAij = eshift_im;
              }

              j = ilastm1;
              jp1 = ilastm1 + 1;
              exitg2 = false;
              while ((!exitg2) && (j + 1 > ifirst)) {
                istart = 2;
                ctemp.re = A[3].re - anorm;
                ctemp.im = A[3].im - reAij;
                scale = imAij * (muDoubleScalarAbs(ctemp.re) + muDoubleScalarAbs
                                 (ctemp.im));
                temp2 = imAij * (muDoubleScalarAbs(A[2 + jp1].re) +
                                 muDoubleScalarAbs(A[2 + jp1].im));
                sumsq = scale;
                if (temp2 > scale) {
                  sumsq = temp2;
                }

                if ((sumsq < 1.0) && (sumsq != 0.0)) {
                  scale /= sumsq;
                  temp2 /= sumsq;
                }

                if ((muDoubleScalarAbs(A[1].re) + muDoubleScalarAbs(A[1].im)) *
                    temp2 <= scale * b_atol) {
                  goto90 = true;
                  exitg2 = true;
                } else {
                  jp1 = 1;
                  j = 0;
                }
              }

              if (!goto90) {
                istart = ifirst;
                if (ifirst == ilastm1 + 1) {
                  ctemp.re = rho_re;
                  ctemp.im = rho_im;
                } else {
                  ctemp.re = A[(ifirst + ((ifirst - 1) << 1)) - 1].re - anorm;
                  ctemp.im = A[(ifirst + ((ifirst - 1) << 1)) - 1].im - reAij;
                }

                goto90 = true;
              }
            }

            if (goto90) {
              goto90 = false;
              st.site = &qb_emlrtRSI;
              xzlartg(&st, ctemp, A[istart + ((istart - 1) << 1)], &scale, &t1);
              for (j = istart; j < ilast + 1; j++) {
                st.site = &pb_emlrtRSI;
                b_st.site = &jb_emlrtRSI;
                for (jp1 = j - 1; jp1 + 1 < 3; jp1++) {
                  d.re = scale * A[jp1 << 1].re + (t1.re * A[j + (jp1 << 1)].re
                    - t1.im * A[j + (jp1 << 1)].im);
                  d.im = scale * A[jp1 << 1].im + (t1.re * A[j + (jp1 << 1)].im
                    + t1.im * A[j + (jp1 << 1)].re);
                  anorm = A[jp1 << 1].im;
                  reAij = A[jp1 << 1].re;
                  A[j + (jp1 << 1)].re = scale * A[j + (jp1 << 1)].re - (t1.re *
                    A[jp1 << 1].re + t1.im * A[jp1 << 1].im);
                  A[j + (jp1 << 1)].im = scale * A[j + (jp1 << 1)].im - (t1.re *
                    anorm - t1.im * reAij);
                  A[jp1 << 1] = d;
                }

                t1.re = -t1.re;
                t1.im = -t1.im;
                jp1 = j + 2;
                if (ilast + 1 < j + 2) {
                  jp1 = ilast + 1;
                }

                st.site = &ob_emlrtRSI;
                b_st.site = &kb_emlrtRSI;
                if (1 > jp1) {
                  b6 = false;
                } else {
                  b6 = (jp1 > 2147483646);
                }

                if (b6) {
                  c_st.site = &g_emlrtRSI;
                  check_forloop_overflow_error(&c_st);
                }

                for (i = 0; i + 1 <= jp1; i++) {
                  d.re = scale * A[i + (j << 1)].re + (t1.re * A[i].re - t1.im *
                    A[i].im);
                  d.im = scale * A[i + (j << 1)].im + (t1.re * A[i].im + t1.im *
                    A[i].re);
                  anorm = A[i + (j << 1)].im;
                  reAij = A[i + (j << 1)].re;
                  A[i].re = scale * A[i].re - (t1.re * A[i + (j << 1)].re +
                    t1.im * A[i + (j << 1)].im);
                  A[i].im = scale * A[i].im - (t1.re * anorm - t1.im * reAij);
                  A[i + (j << 1)] = d;
                }

                st.site = &nb_emlrtRSI;
                b_st.site = &kb_emlrtRSI;
                for (i = 0; i < 2; i++) {
                  d.re = scale * Z[i + (j << 1)].re + (t1.re * Z[i].re - t1.im *
                    Z[i].im);
                  d.im = scale * Z[i + (j << 1)].im + (t1.re * Z[i].im + t1.im *
                    Z[i].re);
                  anorm = Z[i + (j << 1)].im;
                  reAij = Z[i + (j << 1)].re;
                  Z[i].re = scale * Z[i].re - (t1.re * Z[i + (j << 1)].re +
                    t1.im * Z[i + (j << 1)].im);
                  Z[i].im = scale * Z[i].im - (t1.re * anorm - t1.im * reAij);
                  Z[i + (j << 1)] = d;
                }
              }
            }

            b_guard1 = true;
          }

          if (b_guard1) {
            jiter++;
          }
        }
      } else {
        guard2 = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);
  } else {
    guard1 = true;
  }

  if (guard2) {
    if (failed) {
      *info = ilast + 1;
      st.site = &mb_emlrtRSI;
      if (1 > ilast + 1) {
        b7 = false;
      } else {
        b7 = (ilast + 1 > 2147483646);
      }

      if (b7) {
        b_st.site = &g_emlrtRSI;
        check_forloop_overflow_error(&b_st);
      }

      for (jp1 = 0; jp1 + 1 <= ilast + 1; jp1++) {
        alpha1[jp1].re = rtNaN;
        alpha1[jp1].im = 0.0;
        beta1[jp1].re = rtNaN;
        beta1[jp1].im = 0.0;
      }

      for (jp1 = 0; jp1 < 4; jp1++) {
        Z[jp1].re = rtNaN;
        Z[jp1].im = 0.0;
      }
    } else {
      guard1 = true;
    }
  }

  if (guard1) {
    st.site = &lb_emlrtRSI;
    if (1 > ilo - 1) {
      b8 = false;
    } else {
      b8 = (ilo - 1 > 2147483646);
    }

    if (b8) {
      b_st.site = &g_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (j = 0; j + 1 < ilo; j++) {
      alpha1[j] = A[j + (j << 1)];
    }
  }
}

/* End of code generation (xzhgeqz.c) */
