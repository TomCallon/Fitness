//
//  ProductListViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListCell.h"
#import "TomCallonViewController.h"
#import "TomCallonTableViewController.h"

#import "OAuthWebView.h"


@class UIBadgeView;
@class MBProgressHUD;
@class ShowBigImageViewController;


@class WeiBoMessageManager;

@interface VideosListViewController : TomCallonTableViewController<VideoListCellDelegate,UIAlertViewDelegate>
{
    
    int matchSelectStatus;   

    
    NSMutableArray *_mainArray;
    
    
    UIButton *_selectedButton;
    UIButton *_myFollowButton;

    
    
    UIBadgeView *_myFollowCountView;

    
    ShowBigImageViewController *_showBigImageViewController;
    
    MBProgressHUD *_hud;
    
    
    ////WeiBlog
    WeiBoMessageManager *weiBoMessageManager;
    NSNotificationCenter *defaultNotifCenter;
    BOOL                shouldLoad;

////////weibo
    NSString *userID;


    
    

}
@property (nonatomic ,retain) NSMutableArray *mainArray;
@property (nonatomic ,retain) IBOutlet UIButton *selectedButton;
@property (nonatomic ,retain) IBOutlet UIButton *myFollowButton;
@property (nonatomic ,retain) UIBadgeView *myFollowCountView;
@property (nonatomic ,retain) ShowBigImageViewController *showBigImageViewController;
@property (nonatomic ,retain)  MBProgressHUD *hud;

////////weibo
@property (nonatomic, copy)     NSString *userID;


- (IBAction)clickButtons:(id)sender;

- (void)clickUpperBodyButton:(id)sender;
- (void)clickMiddleBodyButton:(id)sender;
- (void)clickLowerBodyButton:(id)sender;
- (void)clickAllVideosButton:(id)sender;
- (void)clickMyPlanButton:(id)sender;

- (void)didDetectDoubleTap:(UITapGestureRecognizer *)tap;


@end
