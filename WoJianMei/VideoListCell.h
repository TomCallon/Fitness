//
//  ProductDetailCell.h
//  groupbuy
//
//  Created by  on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//



@class Video;
@class OHAttributedLabel;

@protocol VideoListCellDelegate <NSObject>

- (void)didClickFollowButton:(id)sender atIndex:(NSIndexPath*)indexPath;
- (void)didClickBuyButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)didClickSinaWeiBlogButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)clickShowBigImage:(id)sender;


@end
@interface VideoListCell : UITableViewCell
{
    id<VideoListCellDelegate>VideoListCellDelegate;
    
     NSIndexPath *_indexPath;    
    UIButton *_followButton;
    
    
}
@property (retain, nonatomic) IBOutlet UIButton *productImageButton;
@property (retain, nonatomic) IBOutlet UILabel *timeLeghtLabel;
@property (retain, nonatomic) IBOutlet UILabel *repeatTimesLabel;
@property (retain, nonatomic) IBOutlet UILabel *setsLabel;
@property (retain, nonatomic) IBOutlet UILabel *upLabel;
@property (retain, nonatomic) IBOutlet UILabel *downLabel;
@property (retain, nonatomic) IBOutlet OHAttributedLabel *priceLabel;
@property (retain, nonatomic) IBOutlet UIButton *followButton;


@property (nonatomic, retain) NSIndexPath *indexPath;


@property (nonatomic, assign) id<VideoListCellDelegate>VideoListCellDelegate;

+ (VideoListCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;
- (void)setCellInfo:(Video *)Video;



- (IBAction)clickFollowButton:(id)sender;
- (IBAction)clickBuyButton:(id)sender;
- (IBAction)clickSinaWeiBlogButton:(id)sender;
- (IBAction)clickShowBigImage:(id)sender;



@end
