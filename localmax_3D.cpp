#include"mex.h"
#include<stdlib.h>
#define abs(a)       (((a)>0)?(a):(-a))
#define greater(a,b) ((a) > (b)+threshold)
#define AT(i,j,k,s) ((i) + (j)*M + (k)*M*N + (s) * M*N*K)
void
        mexFunction(int nout, mxArray *out[],
        int nin, const mxArray *in[])
{
    int M, N, K,S;
    const double* F_pt ;
    int ndims ;
    int* offsets ;
    enum {F=0,THRESHOLD} ;
    enum {MAXIMA=0} ;
    double threshold = - mxGetInf() ;
    
    /* ------------------------------------------------------------------
     *                                                Check the arguments
     * --------------------------------------------------------------- */
    if (nin < 1) {
        mexErrMsgTxt("At least one input argument is required.");
    } else if (nin > 3) {
        mexErrMsgTxt("At most three arguments are allowed.") ;
    } else if (nout > 1) {
        mexErrMsgTxt("Too many output arguments");
    }
    
    /* The input must be a real matrix. */
    if (!mxIsDouble(in[F]) || mxIsComplex(in[F])) {
        mexErrMsgTxt("Input must be real matrix.");
    }
    
    if(nin > 1) {
        threshold = *mxGetPr(in[THRESHOLD]) ;
    }
    const int* dimensions ;
    dimensions = mxGetDimensions(in[F]) ;
    M = dimensions[0] ;
    N = dimensions[1] ;
    K = dimensions[2] ;
    S = dimensions[3] ;
    F_pt = mxGetPr(in[F]) ;
    int maxima_size = M*N;
    int* maxima_start = (int*) mxMalloc(sizeof(int) * maxima_size) ;
    int* maxima_iterator = maxima_start ;
    int* maxima_end = maxima_start + maxima_size ;
    const double* pt = F_pt ;
    int nn = 3*3*3*3-1;
    /* Compute the offsets between dimensions. */
    offsets = (int*) mxMalloc(sizeof(int) * nn) ;
    int o=0;
    for(int i=-1;i<2;i+=1){
        for(int j=-1;j<2;j+=1){
            for(int k=-1;k<2;k+=1){
                for(int s=-1;s<2;s+=1){
                    if(i==0&&j==0&&k==0&&s==0){
                        continue;
                    }else{
                        offsets[o++]=AT(i,j,k,s);
                    }
                }
            }
        }
    }
    for(int s=1;s<S-1;++s){
        for(int k=1;k<K-1;++k){
            for(int j=1;j<N-1;++j){
                for(int i=1;i<M-1;++i){
                  o = M*N*K*s +M*N*k+M*j +i;  
                    if(abs(pt[o])<abs(threshold)){
                        continue;
                    }
                    int ii;
                    
                    for(ii=0;ii<nn;++ii){
                        
                        if(pt[o]<pt[offsets[ii]+o]){
                            break;
                        }
                    }
                    if(ii==nn){
                        if(maxima_iterator == maxima_end) {
                            maxima_size += M*N ;
                            maxima_start = (int*) mxRealloc(maxima_start,
                                    maxima_size*sizeof(int)) ;
                            maxima_end = maxima_start  + maxima_size ;
                            maxima_iterator = maxima_end - M*N ;
                        }
                        *maxima_iterator++ = o + 1 ;   
                    }
                }
            }
        }
    }
    double* M_pt ;
    out[MAXIMA] = mxCreateDoubleMatrix
            (1, maxima_iterator-maxima_start, mxREAL) ;
    maxima_end = maxima_iterator ;
    maxima_iterator = maxima_start ;
    M_pt = mxGetPr(out[MAXIMA]) ;
    while(maxima_iterator != maxima_end) {
        *M_pt++ = *maxima_iterator++ ;
    }
    mxFree(offsets) ;
    mxFree(maxima_start) ;
}