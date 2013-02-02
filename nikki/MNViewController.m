//
//  MNViewController.m
//  nikki
//
//  Created by Vladislav Korotnev on 2/2/13.
//  Copyright (c) 2013 Vladislav Korotnev. All rights reserved.
//

#import "MNViewController.h"

#import <QuartzCore/QuartzCore.h>


@interface MNViewController ()

@end

@implementation MNViewController
@synthesize upd;
static bool didChangeFuture=true;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Add"])
    {
        UITextField *username = [alertView textFieldAtIndex:0];
        [tableItems addObject:username.text];
        [upd performSelector:@selector(doAnimateForDelegate:) withObject:self afterDelay:1];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    upd = [[MNUpdateView alloc]initWithFrame:self.table.frame];
    [self.view addSubview:upd];
    [upd retain];
    tableItems = [[NSMutableArray alloc]init];
    [tableItems retain];
    [self performSelector:@selector(updateDiary) withObject:nil afterDelay:1];
    // Do any additional setup after loading the view from its nib.
}
-(void)animatedInCallback{
    
    [self.table reloadData];
    [self performSelector:@selector(updateDiary) withObject:nil afterDelay:3];

}
- (void)updateDiary {
    if (tableItems.count <= 4) {
        [upd doAnimateForDelegate:self];
        switch (tableItems.count) {
            case 0:
                [tableItems addObject:@"7/14 12:40  Going back from school"];
                break;
            case 1:
                [tableItems addObject:@"7/14 12:42  I see a strange person"];
                break;
            case 2:
                [tableItems addObject:@"7/14 12:43  WHAT!?"];
                break;
            case 3:
                [tableItems addObject:@"7/14 12:43  1st was killed by 2nd"];
                [tableItems addObject:@"     -=  DEAD END =-"];
                didChangeFuture = false;
                break;
                
            default:
                break;
        }
        [tableItems retain];
        return;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
    
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(didChangeFuture)return NO;
     NSMutableArray *ups = [NSMutableArray new];
  
    UITableViewCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
   
    for (UIView*v in cell.subviews) {
        if(v.tag == 1122) [ups addObject:v];
    }
    cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    for (UIView*v in cell.subviews) {
        if(v.tag == 1122) [ups addObject:v];
    }
    cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    for (UIView*v in cell.subviews) {
        if(v.tag == 1122) [ups addObject:v];
    }
    cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    for (UIView*v in cell.subviews) {
        if(v.tag == 1122) [ups addObject:v];
    }
    [tableItems replaceObjectAtIndex:1 withObject:@"7/14 12:42  Thinking of going another route"];
    [tableItems replaceObjectAtIndex:2 withObject:@"7/14 12:44  Nice weather, isn't it?"];
    [tableItems replaceObjectAtIndex:3 withObject:@"7/14 12:51  I'm back home"];
    [tableItems replaceObjectAtIndex:4 withObject:@"     -=  HAPPY END =-"];
     
    [tableItems retain];
    for (MNUpdateView *up  in ups) {
         [up doAnimateForDelegate:self];
    }
    didChangeFuture=true;
    return NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Identifier for retrieving reusable cells. static
    
    UITableViewCell *cell;
    // No cell available - create one.
   
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"a"];
    MNUpdateView*u=[[MNUpdateView alloc]initWithFrame:cell.frame];
    [u setTag:1122];
    [cell addSubview:u];
    
    // Set the text of the cell to the row index.
    cell.textLabel.text = [tableItems objectAtIndex:indexPath.row];
    cell.textLabel.lineBreakMode    = NSLineBreakByWordWrapping;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.opaque = YES;
    cell.contentView.opaque = YES;
    cell.textLabel.opaque = NO;

    
    cell.clipsToBounds = YES;
    cell.contentView.clipsToBounds = YES;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mainView release];
    [_table release];
    [super dealloc];
}

- (IBAction)stubFunction:(id)sender {
    [[[UIAlertView alloc]initWithTitle:@"Stub function" message:@"Not yet implemented" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
}

- (IBAction)addItem:(id)sender {
    UIAlertView* add = [[UIAlertView alloc]initWithTitle:@"Add item" message:@"Enter Item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [add setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [add show];
    
}
@end
