//
//  NutritionInfo.h
//  WoJianMei
//
//  Created by Tom Callon  on 9/9/12.
//
//

#import <Foundation/Foundation.h>

@interface NutritionInfo : NSObject
{
    
    NSString *_nutritionId;
    NSString *_nutritionTitle;
    NSString *_imageName;
    NSString *_creatdDate;
    NSString *_clickedNumber;
    
    
}
@property (nonatomic,retain)     NSString *nutritionId;
@property (nonatomic,retain)     NSString *nutritionTitle;
@property (nonatomic,retain)     NSString *imageName;
@property (nonatomic,retain)     NSString *creatdDate;
@property (nonatomic,retain)     NSString *clickedNumber;


-(id)initWithNutritionId:(NSString *)aNutritionId
          nutritionTitle:(NSString *)aNutritionTitle
               imageName:(NSString *)aImageName
              creatdDate:(NSString *)aCreatdDate
           clickedNumber:(NSString *)aClickedNumber;
@end
