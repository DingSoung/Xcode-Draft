#ifndef __aurioTouch3__DCRejectionFilter__
#define __aurioTouch3__DCRejectionFilter__

#include <AudioToolbox/AudioToolbox.h>

class DCRejectionFilter
{
public:
	DCRejectionFilter();
	~DCRejectionFilter();
	
	void ProcessInplace(Float32* ioData, UInt32 numFrames);
	
private:
	Float32 mY1;
	Float32 mX1;
};

#endif /* defined(__aurioTouch3__DCRejectionFilter__) */
