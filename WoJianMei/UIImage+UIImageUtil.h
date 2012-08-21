//
//  UIImage+UIImageUtil.h
//  WoJianMei
//
//  Created by Tom Callon on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageUtil)


+ (UIImage*)strectchableImageName:(NSString*)name;
+ (UIImage*)strectchableTopImageName:(NSString*)name;
+ (UIImageView*)strectchableImageView:(NSString*)name viewWidth:(int)viewWidth;
+ (UIImage*)strectchableImageName:(NSString*)name leftCapWidth:(int)leftCapWidth;
+ (UIImage*)strectchableImageName:(NSString*)name topCapHeight:(int)topCapHeight;
+ (UIImage*)strectchableTopImageName:(NSString*)name;
+ (UIImage*)strectchableImageName:(NSString*)name leftCapWidth:(int)leftCapWidth topCapHeight:(int)topCapHeight;

- (UIImage*)defaultStretchableImage;
@end
