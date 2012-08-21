//
//  FitnssPlanViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import <UIKit/UIKit.h>

@class KalViewController;

@interface FitnssPlanViewController : UIViewController <UITableViewDelegate>
{
    
    KalViewController *kal;
    id dataSource;
}

@end
