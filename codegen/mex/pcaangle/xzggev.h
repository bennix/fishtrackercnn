/*
 * xzggev.h
 *
 * Code generation for function 'xzggev'
 *
 */

#ifndef __XZGGEV_H__
#define __XZGGEV_H__

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
extern void xzggev(const emlrtStack *sp, creal_T A[4], int32_T *info, creal_T
                   alpha1[2], creal_T beta1[2], creal_T V[4]);

#endif

/* End of code generation (xzggev.h) */
