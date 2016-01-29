/*
 * pcaangle.h
 *
 * Code generation for function 'pcaangle'
 *
 */

#ifndef __PCAANGLE_H__
#define __PCAANGLE_H__

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
extern real_T pcaangle(const emlrtStack *sp, emxArray_real_T *x, emxArray_real_T
  *y);

#ifdef __WATCOMC__

#pragma aux pcaangle value [8087];

#endif
#endif

/* End of code generation (pcaangle.h) */
