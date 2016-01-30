MATLAB="/Applications/MATLAB_R2015b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/xuzhiping/.matlab/R2015b"
OPTSFILE_NAME="./setEnv.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for pcaangle" > pcaangle_mex.mki
echo "CC=$CC" >> pcaangle_mex.mki
echo "CFLAGS=$CFLAGS" >> pcaangle_mex.mki
echo "CLIBS=$CLIBS" >> pcaangle_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> pcaangle_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> pcaangle_mex.mki
echo "CXX=$CXX" >> pcaangle_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> pcaangle_mex.mki
echo "CXXLIBS=$CXXLIBS" >> pcaangle_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> pcaangle_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> pcaangle_mex.mki
echo "LD=$LD" >> pcaangle_mex.mki
echo "LDFLAGS=$LDFLAGS" >> pcaangle_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> pcaangle_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> pcaangle_mex.mki
echo "Arch=$Arch" >> pcaangle_mex.mki
echo OMPFLAGS= >> pcaangle_mex.mki
echo OMPLINKFLAGS= >> pcaangle_mex.mki
echo "EMC_COMPILER=Xcode with Clang" >> pcaangle_mex.mki
echo "EMC_CONFIG=optim" >> pcaangle_mex.mki
"/Applications/MATLAB_R2015b.app/bin/maci64/gmake" -B -f pcaangle_mex.mk
