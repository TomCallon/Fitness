//
//  AppDelegate.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TomCallonTabBarController;



enum
{
    TAB_REALTIME_SCORE = 0,
};





@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

{
      TomCallonTabBarController	*_tabBarController;
      UINavigationController *_navigationController;

}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) UINavigationController *navigationController;


@property (nonatomic, retain)   TomCallonTabBarController	*tabBarController;


@end
