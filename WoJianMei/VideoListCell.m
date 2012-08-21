//
//  ProductDetailCell.m
//  groupbuy
//
//  Created by  on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "VideoListCell.h"
#import "OHAttributedLabel.h"
#import "Video.h"
#import "WorkOut.h"


@implementation VideoListCell
@synthesize productImageButton;
@synthesize timeLeghtLabel;
@synthesize repeatTimesLabel;
@synthesize setsLabel;
@synthesize upLabel;
@synthesize downLabel;
@synthesize priceLabel;
@synthesize VideoListCellDelegate;
@synthesize indexPath =_indexPath;
@synthesize followButton =_followButton;



- (void)dealloc {
    [productImageButton release];
    [timeLeghtLabel release];
    [repeatTimesLabel release];
    [setsLabel release];
    [upLabel release];
    [downLabel release];
    [priceLabel release];
    [_indexPath release];
    [_followButton release];
    [super dealloc];
}


- (void)setCellStyle
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;		   
}

- (void)awakeFromNib{
    [self setCellStyle];
}

// just replace ProductDetailCell by the new Cell Class Name
+ (VideoListCell*) createCell:(id)delegate
{
    
    //////in ios 5 because you are using the storyboard so you dont have to use this method anymore 
//    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailCell" owner:self options:nil];
//    
//    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
//    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
//        NSLog(@"create <ProductDetailCell> but cannot find cell object from Nib");
//        return nil;
//    }
//    
//    ((ProductDetailCell*)[topLevelObjects objectAtIndex:0]).delegate = delegate;
//    
//    return (ProductDetailCell*)[topLevelObjects objectAtIndex:0];
        
    return  nil;
    
    
}

+ (NSString*)getCellIdentifier
{
    static NSString *string = @"VideoListCell";
    return  string;
}

+ (CGFloat)getCellHeight
{
    return 123.0f;
}



- (void)setCellInfo:(Video *)video
{
    //set videos cells
    self.priceLabel.text =video.title;
    [self.priceLabel setTextColor:[UIColor redColor]];
    [self.productImageButton setImage:video.image forState:UIControlStateNormal];
    self.timeLeghtLabel.text = video.timeLenght;
    self.repeatTimesLabel.text = video.workOut.repeatTimes;
    self.setsLabel.text = video.workOut.sets;
    self.upLabel.text =@"Buy";
    self.downLabel.text= @"add";
    [self updateFollow:video];

}

-(void)updateFollow:(Video*)video{
    NSLog(@"Tell me again man %f,",[video.isFollow floatValue]);
    if(video.isFollow == [NSNumber numberWithBool:YES]){
        [self.followButton setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
    }else
        [self.followButton setBackgroundImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
}


- (IBAction)clickFollowButton:(id)sender
{
    if (VideoListCellDelegate && [VideoListCellDelegate respondsToSelector:@selector(didClickFollowButton:atIndex:)]) {
        [self.VideoListCellDelegate didClickFollowButton:sender atIndex:_indexPath];
    }
}

- (IBAction)clickBuyButton:(id)sender
{    
    if (VideoListCellDelegate && [VideoListCellDelegate respondsToSelector:@selector(didClickBuyButton:atIndex:)]) {
        [self.VideoListCellDelegate didClickBuyButton:sender atIndex:_indexPath];
    }
}
- (IBAction)clickSinaWeiBlogButton:(id)sender{
    if (VideoListCellDelegate && [VideoListCellDelegate respondsToSelector:@selector(didClickSinaWeiBlogButton:atIndex:)]) {
        [self.VideoListCellDelegate didClickSinaWeiBlogButton:sender atIndex:_indexPath];
    }

}

- (IBAction)clickShowBigImage:(id)sender{
    NSLog(@"click showbu %d",[sender retainCount]);
    if (VideoListCellDelegate && [VideoListCellDelegate respondsToSelector:@selector(clickShowBigImage:)]) {
        [self.VideoListCellDelegate clickShowBigImage:sender];
    }
    
}


@end
