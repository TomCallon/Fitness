//
//  NutritionDetailCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 9/7/12.
//
//

#import "NutritionDetailCell.h"
#import "NutritionInfo.h"
#import "OHAttributedLabel.h"

@implementation NutritionDetailCell
@synthesize delegate;
@synthesize introductionImageButton=_introductionImageButton;
@synthesize nutritionTitleLabel=_nutritionTitleLabel;
@synthesize creatdDateLabel=_creatdDateLabel;
@synthesize clickedNumberLabel=_clickedNumberLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)dealloc{
    [super dealloc];
    [_introductionImageButton release];
    [_nutritionTitleLabel release];
    [_clickedNumberLabel release];
    [_creatdDateLabel release];

}

+ (NutritionDetailCell*) createCell:(id)delegate{
    
    return nil;
}

+ (NSString*)getCellIdentifier{
    
    return @"NutritionDetailCell";
    
}
+ (CGFloat)getCellHeight{
    
    return 23;
}

- (void)setCellInfo:(NutritionInfo *)nutritionInfo{

    
    [self.introductionImageButton setImage:[UIImage imageNamed:nutritionInfo.imageName] forState:UIControlStateNormal];
    
    /////set the title label's color
    self.nutritionTitleLabel.text = nutritionInfo.nutritionTitle;
    [self.nutritionTitleLabel setTextColor:[UIColor redColor]];
    [self.nutritionTitleLabel setTextAlignment:UITextAlignmentLeft];
    [self.nutritionTitleLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.creatdDateLabel.text=nutritionInfo.creatdDate;
    self.clickedNumberLabel.text=nutritionInfo.clickedNumber;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
