//
//  AvailViewController.m
//  GHSidebarNav
//
//  Created by Brad Grifffith on 3/4/13.
//
//

#import "AvailViewController.h"
#import "GHRootViewController.h"

@interface AvailViewController ()

@end

@implementation AvailViewController

float availBorder = 2.0;

#pragma mark AvailableSeats
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock
{
    if(self = [super initWithTitle:title withRevealBlock:revealBlock]){
        CGRect seatsViewFrame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
        UITableView *seatsView = [[UITableView alloc] initWithFrame:seatsViewFrame];
        seatsView.dataSource = self;
        seatsView.delegate = self;
        
        seatsView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:seatsView];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.contentView setBackgroundColor:[UIColor redColor]];
    
    [cell.contentView setFrame:CGRectMake(0,0,tableView.frame.size.width,160)];
    
    UIView *frameView = [[UIView alloc] initWithFrame:CGRectMake(availBorder,availBorder,cell.contentView.frame.size.width-(2*availBorder),cell.contentView.frame.size.height-(2*availBorder))];
    [frameView setBackgroundColor:[UIColor whiteColor]];
    [cell.contentView addSubview:(frameView)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // return numberAvailable.count;
    return 5;
}

@end
