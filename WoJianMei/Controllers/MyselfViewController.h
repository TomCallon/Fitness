//
//  MyselfViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import <UIKit/UIKit.h>
#import "WeiBoMessageManager.h"
#import "TomCallonTableViewController.h"
#import "User.h"
#import "MyselfCell.h"



@interface MyselfViewController : TomCallonTableViewController<UITableViewDataSource,UITableViewDelegate,MyselfCellDelegate,UINavigationControllerDelegate>

{

    
    NSNotificationCenter *defaultNotifCenter;    
    WeiBoMessageManager  *weiBoMessageManager;
    User                                *_user;
    NSString                          *_userID;

    NSMutableArray                *statuesArr;
    NSMutableDictionary       *imageDictionary;

    
    BOOL                  shouldShowIndicator;
    BOOL                           shouldLoad;
    BOOL                     shouldLoadAvatar;
    
    UIButton                *_headerVImageButton;
    UIImageView                *_footerVImageV;
    UIImage                     *_avatarImage;
    
    UIView                      *myHeaderView;
	UIView                      *myFooterView;
    
    UILabel                    *_userNameLabel;


}


@property (retain, nonatomic) UIButton *headerVImageButton;
@property (retain, nonatomic) UIImageView *footerVImageV;

@property (nonatomic, retain) UIImage                     *avatarImage;
@property (nonatomic, retain) User                               *user;
@property (nonatomic,retain)  NSString                         *userID;
@property (nonatomic, retain)   NSMutableArray             *statuesArr;
@property (nonatomic, retain)   NSMutableDictionary    *imageDictionary;


@property (nonatomic, retain)  UIView *myHeaderView;
@property (nonatomic, retain)  UIView *myFooterView;
@property (nonatomic, retain)  UILabel *userNameLabel;



@end
