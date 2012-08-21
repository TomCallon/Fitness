//
//  FitnssPlanViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import "FitnssPlanViewController.h"
#import "EventKitDataSource.h"
#import "Kal.h"

#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>


@interface FitnssPlanViewController ()

@end

@implementation FitnssPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    
    
    [kal release];
    [dataSource release];
    [super dealloc];
}

-(void)initNativeCal{
    
    /*
     *    Kal Initialization
     *
     * When the calendar is first displayed to the user, Kal will automatically select today's date.
     * If your application requires an arbitrary starting date, use -[KalViewController initWithSelectedDate:]
     * instead of -[KalViewController init].
     */
    kal = [[KalViewController alloc] init];
    kal.title = @"NativeCal";
    /*
     *    Kal Configuration
     *
     */
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)] autorelease];
    
    kal.delegate = self;
    dataSource = [[EventKitDataSource alloc] init];
    kal.dataSource = dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    [self  initNativeCal];
    
    
    
    [self.view addSubview:kal.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Action handler for the navigation bar's right bar button item.
- (void)showAndSelectToday
{
    [kal showAndSelectDate:[NSDate date]];
}

#pragma mark UITableViewDelegate protocol conformance

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Display a details screen for the selected event/row.
//    EKEventViewController *vc = [[[EKEventViewController alloc] init] autorelease];
//    vc.event = [dataSource eventAtIndexPath:indexPath];
//    vc.allowsEditing = NO;
//    [self.navigationController pushViewController:vc animated:YES];
    UIViewController *vc = [[[UIViewController alloc]init]autorelease];
    [self.navigationController pushViewController:vc animated:YES];

}




@end
