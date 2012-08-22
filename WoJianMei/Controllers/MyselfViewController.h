//
//  MyselfViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import <UIKit/UIKit.h>
#import "WeiBoMessageManager.h"


@class User;



@interface MyselfViewController : UIViewController
{

    
    WeiBoMessageManager *weiBoMessageManager;
     User *user;

}


@property (retain, nonatomic) IBOutlet UIImageView *headerVImageV;
@property (nonatomic, retain) UIImage *avatarImage;
@property (nonatomic, retain) User *user;


@end
