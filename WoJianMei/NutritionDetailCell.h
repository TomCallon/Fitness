//
//  NutritionDetailCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 9/7/12.
//
//

#import <UIKit/UIKit.h>
#import "TomCallonTableViewCell.h"

@protocol NutritionDetailCellDelegate <NSObject>
@optional
- (void)didClickFollowButton:(id)sender atIndex:(NSIndexPath*)indexPath;
- (void)didClickBuyButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)didClickSinaWeiBlogButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)clickShowBigImage:(id)sender;

@end



@class NutritionInfo;
@class OHAttributedLabel;


@interface NutritionDetailCell : TomCallonTableViewCell

{
    id<NutritionDetailCellDelegate>delegate;
    
    UIButton *_introductionImageButton;
    OHAttributedLabel  *_nutritionTitleLabel;
    UILabel  *_creatdDateLabel;
    UILabel  *_clickedNumberLabel;

    
}
@property (nonatomic, assign) id<NutritionDetailCellDelegate>delegate;
@property (nonatomic, retain) IBOutlet      UIButton *introductionImageButton;
@property (nonatomic, retain) IBOutlet      OHAttributedLabel *nutritionTitleLabel;
@property (nonatomic, retain) IBOutlet      UILabel  *creatdDateLabel;
@property (nonatomic, retain) IBOutlet      UILabel  *clickedNumberLabel;




+ (NutritionDetailCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;


////set the NutritionInfo 
- (void)setCellInfo:(NutritionInfo *)nutritionInfo;


@end
