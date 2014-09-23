#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import "BufferManager.h"
#import "DCRejectionFilter.h"


@interface AudioController : NSObject {
    
    AudioUnit               _rioUnit;
    BufferManager*          _bufferManager;
    DCRejectionFilter*      _dcRejectionFilter;
    AVAudioPlayer*          _audioPlayer;   // for button pressed sound
    BOOL                    _audioChainIsBeingReconstructed;
}

@property (nonatomic, assign) BOOL muteAudio;
@property (nonatomic, assign, readonly) BOOL audioChainIsBeingReconstructed;

- (BufferManager*) getBufferManagerInstance;
- (OSStatus)    startIOUnit;
- (OSStatus)    stopIOUnit;
- (void)        playButtonPressedSound;
- (double)      sessionSampleRate;

@end
