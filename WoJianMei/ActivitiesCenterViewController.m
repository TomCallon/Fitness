//
//  ActivitiesCenterViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 9/29/12.
//
//

#import "ActivitiesCenterViewController.h"

@interface ActivitiesCenterViewController ()

@end

@implementation ActivitiesCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    UIViewController *nv =[self.navigationController topViewController];
    [nv.navigationItem setTitle:@"活动中心"];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:nil];
    [nv.navigationItem setLeftBarButtonItem:nil];
    [nv.navigationItem setRightBarButtonItem:rightBarButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
