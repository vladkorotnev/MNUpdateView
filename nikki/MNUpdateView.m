//
//  MNUpdateView.m
//  nikki
//
//  Created by Vladislav Korotnev on 2/2/13.
//  Copyright (c) 2013 Vladislav Korotnev. All rights reserved.
//

#import "MNUpdateView.h"
#import <AVFoundation/AVFoundation.h>
@implementation MNUpdateView
@synthesize delegate;
static int previ;
static bool isDrawing;
static bool stopDrawing=false;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}



-(void)animateIn {
    [self setUserInteractionEnabled:TRUE];
    NSError *e;
    AVAudioPlayer * a = [[AVAudioPlayer alloc]initWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"update" withExtension:@"wav"] error:&e];
  //  [a prepareToPlay];
    [a play];
    NSLog(@"%@",e.description);
    stopDrawing = false;
    [self drawShit];
    void (^animations)(void) = nil;
    animations = ^{
        [self setAlpha:1];
    };
    [UIView animateWithDuration:0.7 animations:animations];
    [self.delegate performSelector:@selector(animatedInCallback) withObject:nil afterDelay:0.6];
}

-(void)animateOut {
    
    void (^animations)(void) = nil;
    animations = ^{
        [self setAlpha:0];
    };
    [UIView animateWithDuration:0.7 animations:animations];
    [self performSelector:@selector(_didFinishAnimateOut) withObject:nil afterDelay:0.6];
}
- (void)_didFinishAnimateOut {
    stopDrawing = true;
    [self setUserInteractionEnabled:FALSE];
}
-(void)doAnimateForDelegate:(NSObject<MNUpdateViewDelegate>*)del {
    [self setAlpha:0.7];
    [self setDelegate:del];
    [delegate retain];
    [self animateIn];
    [self performSelector:@selector(animateOut) withObject:nil afterDelay:0.75];
}
- (void)drawShit
{
    isDrawing=true;
    int i = arc4random() % 4;
    while (i == previ) {
        i = arc4random() % 4;
    }
    previ = i;
    [self setContentMode:UIViewContentModeScaleAspectFill];
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"noise%i.png",i]]];
    [self setNeedsDisplay];
  if(!stopDrawing)  [self performSelector:@selector(drawShit) withObject:nil afterDelay:0.07];
}
@end
