#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#include <AudioToolbox/AudioToolbox.h>
 
@interface SoundCtrl : NSObject {
 
    CFURLRef        soundFileURLRef;
    SystemSoundID   soundFileObject;
 
}
 
@property (readwrite)   CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID   soundFileObject;
 
- (void) playSystemSoundAtPath: (NSString *)path;
 - (void) playAlertSoundAtPath: (NSString *)path;
 - (void)vibrate;
 - (void)haptic;
@end