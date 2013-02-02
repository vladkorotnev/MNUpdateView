//
//  MNUpdateView.h
//  nikki
//
//  Created by Vladislav Korotnev on 2/2/13.
//  Copyright (c) 2013 Vladislav Korotnev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MNUpdateViewDelegate;
@interface MNUpdateView : UIImageView
-(void)animateIn;
-(void)animateOut;
-(void)doAnimateForDelegate:(NSObject<MNUpdateViewDelegate>*)del;
@property (nonatomic,retain) NSObject<MNUpdateViewDelegate>*delegate;
@end
@protocol MNUpdateViewDelegate <NSObject>

-(void)animatedInCallback;

@end
