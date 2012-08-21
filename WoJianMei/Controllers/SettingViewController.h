//
//  SecondViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingViewController : UIViewController<MFMessageComposeViewControllerDelegate>



- (IBAction)sendMessageToRestaurant:(id)sender;
- (IBAction)callTheRestaurant:(id)sender;
- (IBAction)loginWithSinaWeiBlog:(id)sender;


@end
