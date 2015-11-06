#ifndef __aurioTouch3__FFTHelper__
#define __aurioTouch3__FFTHelper__

#include <Accelerate/Accelerate.h>

class FFTHelper
{
public:
    FFTHelper( UInt32 inMaxFramesPerSlice );
    ~FFTHelper();
    
    void ComputeFFT ( Float32* inAudioData, Float32* outFFTData );
    
private:
    FFTSetup            mSpectrumAnalysis;
    DSPSplitComplex     mDspSplitComplex;
    Float32             mFFTNormFactor;
    UInt32              mFFTLength;
    UInt32              mLog2N;
};

#endif /* defined(__aurioTouch3__FFTHelper__) */
