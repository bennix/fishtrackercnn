/*
 * relop.c
 *
 * Code generation for function 'relop'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pcaangle.h"
#include "relop.h"

/* Function Definitions */
boolean_T relop(const creal_T a, const creal_T b)
{
  boolean_T p;
  real_T absbi;
  real_T y;
  real_T absxk;
  int32_T exponent;
  real_T absar;
  real_T absbr;
  real_T Ma;
  int32_T b_exponent;
  int32_T c_exponent;
  int32_T d_exponent;
  if ((muDoubleScalarAbs(a.re) > 8.9884656743115785E+307) || (muDoubleScalarAbs
       (a.im) > 8.9884656743115785E+307) || (muDoubleScalarAbs(b.re) >
       8.9884656743115785E+307) || (muDoubleScalarAbs(b.im) >
       8.9884656743115785E+307)) {
    absbi = muDoubleScalarHypot(a.re / 2.0, a.im / 2.0);
    y = muDoubleScalarHypot(b.re / 2.0, b.im / 2.0);
  } else {
    absbi = muDoubleScalarHypot(a.re, a.im);
    y = muDoubleScalarHypot(b.re, b.im);
  }

  absxk = y / 2.0;
  if ((!muDoubleScalarIsInf(absxk)) && (!muDoubleScalarIsNaN(absxk))) {
    if (absxk <= 2.2250738585072014E-308) {
      absxk = 4.94065645841247E-324;
    } else {
      frexp(absxk, &exponent);
      absxk = ldexp(1.0, exponent - 53);
    }
  } else {
    absxk = rtNaN;
  }

  if ((muDoubleScalarAbs(y - absbi) < absxk) || (muDoubleScalarIsInf(absbi) &&
       muDoubleScalarIsInf(y) && ((absbi > 0.0) == (y > 0.0)))) {
    p = true;
  } else {
    p = false;
  }

  if (p) {
    absar = muDoubleScalarAbs(a.re);
    absxk = muDoubleScalarAbs(a.im);
    absbr = muDoubleScalarAbs(b.re);
    absbi = muDoubleScalarAbs(b.im);
    if (absar > absxk) {
      Ma = absar;
      absar = absxk;
    } else {
      Ma = absxk;
    }

    if (absbr > absbi) {
      absxk = absbr;
      absbr = absbi;
    } else {
      absxk = absbi;
    }

    if (Ma > absxk) {
      if (absar < absbr) {
        absbi = Ma - absxk;
        y = (absar / 2.0 + absbr / 2.0) / (Ma / 2.0 + absxk / 2.0) * (absbr -
          absar);
      } else {
        absbi = Ma;
        y = absxk;
      }
    } else if (Ma < absxk) {
      if (absar > absbr) {
        y = absxk - Ma;
        absbi = (absar / 2.0 + absbr / 2.0) / (Ma / 2.0 + absxk / 2.0) * (absar
          - absbr);
      } else {
        absbi = Ma;
        y = absxk;
      }
    } else {
      absbi = absar;
      y = absbr;
    }

    absxk = muDoubleScalarAbs(y / 2.0);
    if ((!muDoubleScalarIsInf(absxk)) && (!muDoubleScalarIsNaN(absxk))) {
      if (absxk <= 2.2250738585072014E-308) {
        absxk = 4.94065645841247E-324;
      } else {
        frexp(absxk, &b_exponent);
        absxk = ldexp(1.0, b_exponent - 53);
      }
    } else {
      absxk = rtNaN;
    }

    if ((muDoubleScalarAbs(y - absbi) < absxk) || (muDoubleScalarIsInf(absbi) &&
         muDoubleScalarIsInf(y) && ((absbi > 0.0) == (y > 0.0)))) {
      p = true;
    } else {
      p = false;
    }

    if (p) {
      absbi = muDoubleScalarAtan2(a.im, a.re);
      y = muDoubleScalarAtan2(b.im, b.re);
      absxk = muDoubleScalarAbs(y / 2.0);
      if ((!muDoubleScalarIsInf(absxk)) && (!muDoubleScalarIsNaN(absxk))) {
        if (absxk <= 2.2250738585072014E-308) {
          absxk = 4.94065645841247E-324;
        } else {
          frexp(absxk, &c_exponent);
          absxk = ldexp(1.0, c_exponent - 53);
        }
      } else {
        absxk = rtNaN;
      }

      if ((muDoubleScalarAbs(y - absbi) < absxk) || (muDoubleScalarIsInf(absbi) &&
           muDoubleScalarIsInf(y) && ((absbi > 0.0) == (y > 0.0)))) {
        p = true;
      } else {
        p = false;
      }

      if (p) {
        if (absbi > 0.78539816339744828) {
          if (absbi > 2.3561944901923448) {
            absbi = -a.im;
            y = -b.im;
          } else {
            absbi = -a.re;
            y = -b.re;
          }
        } else if (absbi > -0.78539816339744828) {
          absbi = a.im;
          y = b.im;
        } else if (absbi > -2.3561944901923448) {
          absbi = a.re;
          y = b.re;
        } else {
          absbi = -a.im;
          y = -b.im;
        }

        absxk = muDoubleScalarAbs(y / 2.0);
        if ((!muDoubleScalarIsInf(absxk)) && (!muDoubleScalarIsNaN(absxk))) {
          if (absxk <= 2.2250738585072014E-308) {
            absxk = 4.94065645841247E-324;
          } else {
            frexp(absxk, &d_exponent);
            absxk = ldexp(1.0, d_exponent - 53);
          }
        } else {
          absxk = rtNaN;
        }

        if ((muDoubleScalarAbs(y - absbi) < absxk) || (muDoubleScalarIsInf(absbi)
             && muDoubleScalarIsInf(y) && ((absbi > 0.0) == (y > 0.0)))) {
          p = true;
        } else {
          p = false;
        }

        if (p) {
          absbi = 0.0;
          y = 0.0;
        }
      }
    }
  }

  return absbi <= y;
}

/* End of code generation (relop.c) */
