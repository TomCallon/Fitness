//
//  GymListsViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 10/10/12.
//
//

#import "GymListsViewController.h"
#import "CityChosenListViewController.h"

@interface GymListsViewController ()

@end

@implementation GymListsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)locateCity:(UIButton *)sender{
    
    CityChosenListViewController *vc = [[CityChosenListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *cityButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(locateCity:)];
    self.navigationItem.rightBarButtonItem  = cityButton;
    [cityButton release];
    
    
   self.dataList  = [NSArray arrayWithObjects:@"力美健健身俱乐部",@"青鸟健身俱乐部",@"鸿星健身俱乐部",@"0.618 健身俱乐部",@"英派斯健身俱乐部",@"中体倍力健身俱乐部", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataList count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.dataList objectAtIndex:indexPath.row]] ;
    
    
    return cell;
}


@end
