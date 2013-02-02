#import "AudioMaster.h"
 #import <dlfcn.h>
@implementation SoundCtrl
 
@synthesize soundFileURLRef;
@synthesize soundFileObject;
  
  #define AUDIO_TOOLBOX_PATH \
"/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox"

typedef void (*asss)(SystemSoundID inSystemSoundID);
static asss stop; 
  
  - (void)__AudioServicesStopSystemSound
{
    stop(kSystemSoundID_Vibrate);
}

- (void) vibrate {
 
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}
 
 - (void) playSystemSoundAtPath: (NSString *)path {
 NSFileManager *fm=[NSFileManager defaultManager];
if([fm fileExistsAtPath:path]){

     // Create the URL for the source audio file. The URLForResource:withExtension: method is
    //    new in iOS 4.0.
    NSURL *tapSound   = [NSURL fileURLWithPath:path];
 
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
 
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
    
        soundFileURLRef,
        &soundFileObject
    );
    
    AudioServicesPlaySystemSound (soundFileObject); 
    } 
    
    
    [fm release];
 }
 
 
 - (void) playAlertSoundAtPath: (NSString *)path { 
  NSFileManager *fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:path]){
     // Create the URL for the source audio file. The URLForResource:withExtension: method is
    //    new in iOS 4.0.
    NSURL *tapSound   = [NSURL fileURLWithPath:path];
 
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
 
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
    
        soundFileURLRef,
        &soundFileObject
    );
    
    AudioServicesPlayAlertSound (soundFileObject);
    } 
    [fm release];
 }
 
 - (void)haptic {
   NSFileManager *fm=[NSFileManager defaultManager];
   if([fm fileExistsAtPath:@"/var/mobile/Library/Preferences/isounds_haptic.flag"]){
 	    void *libHandle
    = dlopen(AUDIO_TOOLBOX_PATH, RTLD_LAZY);
    
    *(void **)(&stop)
    = dlsym(libHandle, "AudioServicesStopSystemSound");
    if (!stop) {return; }
    
    
    
    SEL sel = @selector(__AudioServicesStopSystemSound);
    [self performSelector:sel withObject:nil afterDelay:0.5f];
AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    dlclose(libHandle);
    }
    [fm release];
    //return;
 }
 
- (void) dealloc {
 
    AudioServicesDisposeSystemSoundID (soundFileObject);
    CFRelease (soundFileURLRef);
    [super dealloc];
}
 
@end