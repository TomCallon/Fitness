//
//  AppDelegate.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <StoreKit/StoreKit.h>
#import "InAppFitnessIAPHelper.h"
#import "TomCallonTabBarController.h"


#import "VideosListViewController.h"
#import "MyselfViewController.h"
#import "NutritionViewController.h"
#import "FitnssPlanViewController.h"
#import "MoreViewController.h"



#import "FirstViewController.h"
#import "SettingViewController.h"

#import "UIUtils.h"




@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController=_tabBarController ;

- (void)dealloc
{
    [_tabBarController release];
    [_window release];
    [super dealloc];
}

- (void)initTabViewControllers
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    TomCallonTabBarController *tomCallonTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"FisrtTabBarController"];

    
    self.tabBarController = tomCallonTabBarController;
    self.tabBarController.delegate = self;
    
    

	NSMutableArray* controllers = [[NSMutableArray alloc] init];
    
	VideosListViewController* videosListViewController = (VideosListViewController*)[storyboard instantiateViewControllerWithIdentifier:@"VideoListViewController"];
    [UIUtils addViewControllerFromStoryBoard:videosListViewController
					 viewTitle:@"健身视频"
					 viewImage:@"b_menu_1.png"
			  hasNavController:YES
			   viewControllers:controllers];
    
    
    MyselfViewController *myselfViewController = (MyselfViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    
    [UIUtils addViewControllerFromStoryBoard:myselfViewController
                                   viewTitle:@"我健美"
                                   viewImage:@"b_menu_3.png"
                            hasNavController:YES
                             viewControllers:controllers];
    
    
    NutritionViewController * nutritionViewController = (NutritionViewController*)[storyboard instantiateViewControllerWithIdentifier:@"NutritionViewController"];
    [UIUtils addViewControllerFromStoryBoard:nutritionViewController
                     viewTitle:@"健身营养"
                     viewImage:@"b_menu_2.png"
              hasNavController:NO
               viewControllers:controllers];
    
    
 	
	
    FitnssPlanViewController *fitnssPlanViewController =(FitnssPlanViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FitnssPlanViewController"];
	[UIUtils addViewControllerFromStoryBoard:fitnssPlanViewController
					 viewTitle:@"健身计划"
					 viewImage:@"b_menu_4.png"
			  hasNavController:YES
			   viewControllers:controllers];
    
    
    MoreViewController *moreViewController =(MoreViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MoreViewController"];
	[UIUtils addViewControllerFromStoryBoard:moreViewController
                                   viewTitle:@"更多"
                                   viewImage:@"b_menu_5.png"
                            hasNavController:YES
                             viewControllers:controllers];
    
    [self.tabBarController setSelectedImageArray:[NSArray arrayWithObjects:
                                                  @"b_menu_1s.png",
                                                  @"b_menu_2s.png",
                                                  @"b_menu_3s.png",
                                                  @"b_menu_4s.png",
                                                  @"b_menu_5s.png",
                                                  nil]];
    
    self.tabBarController.viewControllers = controllers;
    self.tabBarController.selectedIndex = TAB_REALTIME_SCORE ;
    
	[controllers release];
    
    
}



- (void)customizeInterface
{
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selection-tab.png"]];
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[InAppFitnessIAPHelper sharedHelper]];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
   [self customizeInterface];
   [self initTabViewControllers];
   [self.window setRootViewController:self.tabBarController];
   [self.window makeKeyAndVisible];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
