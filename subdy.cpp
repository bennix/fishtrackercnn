#include"mex.h"

#include<stdlib.h>
#include<string.h>

#define AT(C,a, b)    (*((C) + (b) * M + (a)))

void mexFunction(int nout, mxArray *out[],
        int nin, const mxArray *in[]) {
    int M, N;
    const int* dimensions ;
    const double* P_pt ;
    double* result ;
    int s;
    int i,j;
    enum {IN_P=0, IN_S} ;
    enum {OUT_Q=0} ;
    /* -----------------------------------------------------------------
     **                                               Check the arguments
     ** -------------------------------------------------------------- */
    if (nin != 2) {
        mexErrMsgTxt("2 input arguments required.");
    } else if (nout != 1) {
        mexErrMsgTxt("1 output arguments.");
    }
    
    if( !mxIsDouble(in[IN_P]) || mxGetNumberOfDimensions(in[IN_P]) != 2) {
        mexErrMsgTxt("input must be a 2 dimensional real array.") ;
    }
    
    dimensions = mxGetDimensions(in[IN_P]) ;
    M = dimensions[0] ;
    N = dimensions[1] ;
    s = (int)mxGetScalar(in[IN_S]) ;
    if(M < 3 || N < 3) {
        mexErrMsgTxt("All dimensions of DOG must be not less than 3.") ;
    }
    P_pt = mxGetPr(in[IN_P]) ;
    out[OUT_Q] = mxCreateDoubleMatrix(M, N, mxREAL) ;
    result = mxGetPr(out[OUT_Q]);
//center
    
    for(j=0;j<N;j++){
        for(i=s;i<M-s;i++){
            AT(result,i,j) = (AT(P_pt,i+s,j) - AT(P_pt,i-s,j)) /2/s;
        }
    }
    
    //top
    for(j=0;j<N;j++){
        for(i=0;i<s;i++){
            AT(result,i,j) = (AT(P_pt,i+s,j) - AT(P_pt,i,j))/s;
        }
    }
    
    //bottom
    for(j=0;j<N;j++){
        for(i=M-s;i<M;i++){
            AT(result,i,j) = (AT(P_pt,i,j) - AT(P_pt,i-s,j))/s;
        }
    }
    
}