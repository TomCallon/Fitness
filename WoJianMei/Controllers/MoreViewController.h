//
//  MoreViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/14/12.
//
//

#import <UIKit/UIKit.h>
#import "TomCallonViewController.h"

@interface MoreViewController : TomCallonViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

{
 
    NSArray *_listData;
    int whichAcctionSheet;


}

@property (nonatomic, retain) NSArray *listData;

- (IBAction)sinaWeiBlogshareButton:(id)sender;


@end
