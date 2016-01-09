#include"mex.h"
#include"gauss_elimination.cpp"
#include<stdlib.h>
#include<string.h>

#ifdef WINDOWS
#undef min
#undef max
#ifndef __cplusplus__
#define sqrtf(x) ((float)sqrt((double)x)
#define powf(x)  ((float)pow((double)x)
#define fabsf(x) ((float)fabs((double)x)
#endif
#endif

#define greater(a, b) ((a) > (b))
#define min(a, b)     (((a)<(b))?(a):(b))
#define max(a, b)     (((a)>(b))?(a):(b))
#define abs(a)       (((a)>0)?(a):(-a))

const int max_iter = 5 ;
#define at(dx, dy,ds) (*(pt + (dx)*xo + (dy)*yo + (ds)*so))
#define Aat(i, j) (A[(i)+(j)*3])
void mexFunction(int nout, mxArray *out[],
        int nin, const mxArray *in[]) {
    int M, N, S, H,K;
    const int* dimensions ;
    const double* P_pt ;
    const double* D_pt ;
    double* result ;
    enum {IN_P=0, IN_D} ;
    enum {OUT_Q=0} ;
    
    /* -----------------------------------------------------------------
     **                                               Check the arguments
     ** -------------------------------------------------------------- */
    if (nin < 2) {
        mexErrMsgTxt("At least 2 input arguments required.");
    } else if (nout > 1) {
        mexErrMsgTxt("Too many output arguments.");
    }
    if( !mxIsDouble(in[IN_D]) || mxGetNumberOfDimensions(in[IN_D]) != 3) {
        mexErrMsgTxt("G must be a three dimensional real array.") ;
    }
    
    dimensions = mxGetDimensions(in[IN_D]) ;
    M = dimensions[0] ;
    N = dimensions[1] ;
    S = dimensions[2] ;
    
    
    if(S < 3 || M < 3 || N < 3) {
        mexErrMsgTxt("All dimensions must be not less than 3.") ;
    }
    
    K = mxGetN(in[IN_P]) ;
    H = mxGetM(in[IN_P]) ;
    P_pt = mxGetPr(in[IN_P]) ;
    D_pt = mxGetPr(in[IN_D]) ;
    
    /* If the input array is empty, then output an empty array as well. */
    if( K == 0) {
        out[OUT_Q] = mxDuplicateArray(in[IN_P]) ;
        return ;
    }
    
    /* -----------------------------------------------------------------
     *                                                        Do the job
     * -------------------------------------------------------------- */
    {
        double* buffer = (double*) mxMalloc(K*H*sizeof(double)) ;
        double* buffer_iterator = buffer ;
        int p;
        const int yo = 1 ;
        const int xo = M ;
        const int so = M*N ;
        for(p = 0 ; p < K ; ++p) {
            double b[3] ;
            int x = ((int)*P_pt++) ;
            int y = ((int)*P_pt++) ;
            int s = ((int)*P_pt++) ;
            if(x < 1 || x > N-2 ||
                    y < 1 || y > M-2 ||
                    s < 1 || s > S-2) {
                continue ;
            }
            const double* pt = D_pt + y*yo + x*xo + s*so ;
            double Dx=0, Dy=0, Ds=0, Dxx=0, Dyy=0, Dss=0, Dxy=0, Dxs=0,Dys=0;
            double A[3*3] ;
            pt = D_pt + y*yo + x*xo + s*so ;
            
            /* Compute the gradient. */
            Dx = 0.5 * (at(+1, 0,0) - at(-1, 0,0)) ;
            Dy = 0.5 * (at(0, +1,0) - at(0, -1, 0));
            Ds = 0.5 * (at(0, 0,+1) - at(0, 0, -1)) ;
            
            /* Compute the Hessian. */
            Dxx = (at(+1, 0, 0) + at(-1, 0, 0) - 2.0 * at(0, 0, 0)) ;
            Dyy = (at(0, +1, 0) + at(0, -1, 0) - 2.0 * at(0, 0, 0)) ;
            Dss = (at(0, 0, +1) + at(0, 0, -1) - 2.0 * at(0, 0, 0)) ;
            
            Dxy = 0.25 * ( at(+1, +1,0) + at(-1, -1, 0) - at(-1, +1,0) - at(+1, -1,0) ) ;
            Dxs = 0.25 * ( at(+1, 0, +1) + at(-1, 0, -1) - at(-1, 0, +1) - at(+1, 0, -1) ) ;
            Dys = 0.25 * ( at(0, +1, +1) + at(0, -1,-1) - at(0, -1, +1) - at(0, +1, -1) ) ;
            /* Solve linear system. */
            Aat(0, 0) = Dxx ;
            Aat(1, 1) = Dyy ;
            Aat(2, 2) = Dss ;
            Aat(0, 1) = Aat(1, 0) = Dxy ;
            Aat(0, 2) = Aat(2, 0) = Dxs ;
            Aat(1, 2) = Aat(2, 1) = Dys ;
            b[0] = - Dx ;
            b[1] = - Dy ;
            b[2] = - Ds ;
            int ret = Gaussian_Elimination(A, 3, b);
            double xn = x  ;
            double yn = y ;
            double sn = s ;
            if(ret==0){
                xn+=b[0];
                yn+=b[1];
                sn+=b[2];
            }
            *buffer_iterator++ = xn ;
            *buffer_iterator++ = yn ;
            *buffer_iterator++ = sn  ;
        }
        int NL = (buffer_iterator - buffer)/H ;
        out[OUT_Q] = mxCreateDoubleMatrix(H, NL, mxREAL) ;
        result = mxGetPr(out[OUT_Q]);
        memcpy(result, buffer, sizeof(double) * H * NL) ;
        mxFree(buffer) ;
    }
}