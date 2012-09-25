//
//  NutritionInfo.m
//  WoJianMei
//
//  Created by Tom Callon  on 9/9/12.
//
//

#import "NutritionInfo.h"

@implementation NutritionInfo
@synthesize nutritionId =_nutritionId;
@synthesize nutritionTitle =_nutritionTitle;
@synthesize imageName =_imageName;
@synthesize creatdDate =_creatdDate;
@synthesize clickedNumber= _clickedNumber;


-(id)initWithNutritionId:(NSString *)aNutritionId
          nutritionTitle:(NSString *)aNutritionTitle
               imageName:(NSString *)aImageName
              creatdDate:(NSString *)aCreatdDate
           clickedNumber:(NSString *)aClickedNumber

{
    if (self = [super init]) {
        self.nutritionId = aNutritionId;
        self.nutritionTitle = aNutritionTitle;
        self.imageName = aImageName;
        self.creatdDate = aCreatdDate;
        self.clickedNumber = aClickedNumber;
    }
    return  self;
}

-(void)dealloc{
    [super dealloc];
    
    [_nutritionId release];
    [_nutritionTitle release];
    [_imageName release];
    [_creatdDate release];
    [_clickedNumber release];
}
@end
