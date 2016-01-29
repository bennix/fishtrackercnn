/*
 * xzlartg.h
 *
 * Code generation for function 'xzlartg'
 *
 */

#ifndef __XZLARTG_H__
#define __XZLARTG_H__

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "pcaangle_types.h"

/* Function Declarations */
extern void xzlartg(const emlrtStack *sp, const creal_T f, const creal_T g,
                    real_T *cs, creal_T *sn);

#endif

/* End of code generation (xzlartg.h) */
