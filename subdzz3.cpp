#include"mex.h"
#include<stdlib.h>
#include<string.h>

#define AT(P,a, b, c)    (*((P) + (c)*M*N + (b) * M + (a)))

void mexFunction(int nout, mxArray *out[],
        int nin, const mxArray *in[]) {
    int M, N,K;
    const int* dimensions ;
    const double* P_pt ;
    double* result ;
    int s;
    int i,j,k;
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
    
    if( !mxIsDouble(in[IN_P]) || mxGetNumberOfDimensions(in[IN_P]) != 3) {
        mexErrMsgTxt("input must be a 3 dimensional real array.") ;
    }
    dimensions = mxGetDimensions(in[IN_P]) ;
    M = dimensions[0] ;
    N = dimensions[1] ;
    K = dimensions[2] ;
    s = (int)mxGetScalar(in[IN_S]) ;
    
    if(M < 3 || N < 3) {
        mexErrMsgTxt("All dimensions of DOG must be not less than 3.") ;
    }
    P_pt = mxGetPr(in[IN_P]) ;
    const mwSize dims[3]={M,N,K};
    out[OUT_Q]=mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);
    result = mxGetPr(out[OUT_Q]);
    //center
    for(k=2;k<K-2;k++){
        for(j=0;j<N;j++){
            for(i=0;i<M;i++){
                AT(result,i,j,k) = (AT(P_pt,i,j,k-2) + AT(P_pt,i,j,k+2) - 2*AT(P_pt,i,j,k) )/4;
            }
        }
    }
}