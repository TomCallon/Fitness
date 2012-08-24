//
//  MyselfCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/23/12.
//
//

#import "MyselfCell.h"

@implementation MyselfCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}



+ (MyselfCell*) createCell:(id)delegate{
    
    return nil;
}

+ (NSString*)getCellIdentifier{
    
    return @"MyselfCell";

}
+ (CGFloat)getCellHeight{
    
    return 23;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
