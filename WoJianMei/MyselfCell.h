//
//  MyselfCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/23/12.
//
//

#import <UIKit/UIKit.h>
#import "TomCallonTableViewCell.h"


@protocol MyselfCellDelegate <NSObject>


@optional
- (void)didClickFollowButton:(id)sender atIndex:(NSIndexPath*)indexPath;
- (void)didClickBuyButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)didClickSinaWeiBlogButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)clickShowBigImage:(id)sender;

@end



@interface MyselfCell : TomCallonTableViewCell

{
    id<MyselfCellDelegate>delegate;

}
@property (nonatomic, assign) id<MyselfCellDelegate>delegate;


+ (MyselfCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;
@end
