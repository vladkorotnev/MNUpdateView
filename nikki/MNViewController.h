//
//  MNViewController.h
//  nikki
//
//  Created by Vladislav Korotnev on 2/2/13.
//  Copyright (c) 2013 Vladislav Korotnev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNUpdateView.h"
@interface MNViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MNUpdateViewDelegate,UIAlertViewDelegate>{
    NSMutableArray * tableItems;
}
@property (retain, nonatomic) IBOutlet UIView *mainView;

@property (retain, nonatomic) IBOutlet UITableView *table;
- (IBAction)stubFunction:(id)sender;
- (IBAction)addItem:(id)sender;
@property (nonatomic,retain) MNUpdateView*upd;
@end
