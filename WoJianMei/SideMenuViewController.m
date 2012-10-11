//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "DemoViewController.h"

@implementation SideMenuViewController
@synthesize sectionTitlesArray =_sectionTitlesArray;
@synthesize headerView =_headerView;


-(void)dealloc{
    [super dealloc];
    [_sectionTitlesArray release];
    [_headerView release];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIButton *femalebutton  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [femalebutton setBackgroundImage:[UIImage imageNamed:@"tabbar_whitebtn2.png"] forState:UIControlStateNormal];
    UIButton *malebutton  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [malebutton setBackgroundImage:[UIImage imageNamed:@"tabbar_whitebtn2.png"] forState:UIControlStateNormal];
    [malebutton setFrame:CGRectMake(40, 2, 80, 50)];
    [femalebutton setFrame:CGRectMake(150,2,80, 50)];

    [femalebutton setTitle:@"女生" forState:UIControlStateNormal];
    [malebutton setTitle:@"男生" forState:UIControlStateNormal];

    
    
    [view addSubview:femalebutton];
    [view addSubview:malebutton];
    self.headerView = view;
    [view release];
    [self.tableView setTableHeaderView:self.headerView];
}


#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %d", section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Item %d", indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    DemoViewController *demoController = [[[DemoViewController alloc] initWithNibName:@"DemoViewController" bundle:nil] autorelease];
//    demoController.title = [NSString stringWithFormat:@"Demo Controller #%d-%d", indexPath.section, indexPath.row];
//    
//    NSArray *controllers = [NSArray arrayWithObject:demoController];
//  [MFSideMenuManager sharedManager].navigationController.viewControllers = controllers;
 [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    
    
    
}

@end
