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



@interface MyselfViewController : TomCallonTableViewController<UITableViewDataSource,UITableViewDelegate,MyselfCellDelegate>

{

    
    WeiBoMessageManager  *weiBoMessageManager;
    User                                *user;
    NSString                          *userID;

    NSMutableArray                *statuesArr;

    
    BOOL                  shouldShowIndicator;
    BOOL                           shouldLoad;
    BOOL                     shouldLoadAvatar;
    
    UIImageView                *_headerVImageV;
    NSMutableDictionary      *imageDictionary;


}


@property (retain, nonatomic) IBOutlet      UIImageView *headerVImageV;
@property (nonatomic, retain) UIImage                     *avatarImage;
@property (nonatomic, retain) User                               *user;
@property (nonatomic,retain)  NSString                         *userID;
@property (nonatomic, retain)   NSMutableArray             *statuesArr;
@property (nonatomic, retain)   NSMutableDictionary    *imageDictionary;



@end
