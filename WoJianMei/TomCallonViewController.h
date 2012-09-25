//
//  TomCallonViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKLoadingView.h"
#import <MessageUI/MessageUI.h>

@interface TomCallonViewController : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>{

    TKLoadingView*          _loadingView;
    
    UIAlertView				*_alertView;
    NSString*				_backgroundImageName;
    


}
@property (nonatomic, retain) TKLoadingView*        loadingView;
@property (nonatomic, retain) UIAlertView			*alertView;
@property (nonatomic, retain) NSString*				backgroundImageName;





// this method helps you to performa an internal method with loading view
- (void)performSelectorWithLoading:(SEL)aSelector loadingText:(NSString*)loadingText;

- (void)showActivityWithText:(NSString*)loadingText withCenter:(CGPoint)point;
- (void)showActivityWithText:(NSString*)loadingText;
- (void)showActivity;
- (void)hideActivity;


- (void)popupMessage:(NSString*)msg title:(NSString*)title;
- (void)popupHappyMessage:(NSString*)msg title:(NSString*)title;
- (void)popupUnhappyMessage:(NSString*)msg title:(NSString*)title;
- (void)dismissAlertView:(id)sender;


#pragma mark NavigationItems Methods
- (void)showBackgroundImage;
- (void)setNavigationRightButton:(NSString*)title imageName:(NSString*)imageName action:(SEL)action;
- (void)setNavigationLeftButton:(NSString*)title imageName:(NSString*)imageName action:(SEL)action;
- (void)setNavigationLeftButton:(NSString*)title action:(SEL)action;
- (void)setNavigationRightButton:(NSString*)title action:(SEL)action;
- (void)setNavigationRightButtonWithSystemStyle:(UIBarButtonSystemItem)systemItem action:(SEL)action;
- (void)setNavigationLeftButtonWithSystemStyle:(UIBarButtonSystemItem)systemItem action:(SEL)action;
- (void)setNavigationLeftButton:(NSString*)title imageName:(NSString*)imageName action:(SEL)action hasEdgeInSet:(BOOL)hasEdgeInSet;
- (void)setNavigationRightButton:(NSString*)title imageName:(NSString*)imageName action:(SEL)action hasEdgeInSet:(BOOL)hasEdgeInSet;
- (void)setNavigationRightButton:(NSString*)title image:(UIImage*)strectableImage action:(SEL)action hasEdgeInSet:(BOOL)hasEdgeInSet;


#pragma mark Email Methods

- (void)displayComposerSheetTo:(NSArray*)toRecipients
				  ccRecipients:(NSArray*)ccRecipients
				 bccRecipients:(NSArray*)bccRecipients
					   subject:(NSString*)subject
						  body:(NSString*)body
						isHTML:(BOOL)isHTML
					  delegate:(id)delegate;

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
// This method is mainly for copy & paste
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;

#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDeviceTo:(NSString*)toRecipient
				  ccRecipients:(NSArray*)ccRecipients
//				 bccRecipients:(NSArray*)bccRecipients
					   subject:(NSString*)subject
						  body:(NSString*)body;

- (BOOL)sendEmailTo:(NSArray*)toRecipients
	   ccRecipients:(NSArray*)ccRecipients
	  bccRecipients:(NSArray*)bccRecipients
			subject:(NSString*)subject
			   body:(NSString*)body
			 isHTML:(BOOL)isHTML
		   delegate:(id)delegate;


#pragma mark SMS Methods
-(void)sendSms:(NSString*)receiver body:(NSString*)body;
-(void)sendSmsWithReceivers:(NSArray*)receivers body:(NSString*)body;
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result;

#pragma mark Create buttons at scroll View
#pragma mark - static method
//if buttonSeparatorY < 0, we will use the default value.
+ (UIScrollView*)createButtonScrollViewByButtonArray:(NSArray*)buttons
                                      buttonsPerLine:(int)buttonsPerLine buttonSeparatorY:(CGFloat)buttonSeparatorY;


@end
