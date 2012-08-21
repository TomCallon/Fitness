//
//  UIImage+UIImageUtil.m
//  WoJianMei
//
//  Created by Tom Callon on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImage+UIImageUtil.h"

@implementation UIImage (UIImageUtil)

- (UIImage*)defaultStretchableImage
{
    return [self stretchableImageWithLeftCapWidth:self.size.width/2 topCapHeight:self.size.height/2];
}

+ (UIImage*)strectchableImageName:(NSString*)name
{
    UIImage* image = [UIImage imageNamed:name];
    return [image defaultStretchableImage];
}

+ (UIImage*)strectchableTopImageName:(NSString*)name
{
    UIImage* image = [UIImage imageNamed:name];
    int topCapHeight = image.size.height/2;
    return [image stretchableImageWithLeftCapWidth:0 topCapHeight:topCapHeight];
}

+ (UIImage*)strectchableImageName:(NSString*)name leftCapWidth:(int)leftCapWidth
{
    UIImage* image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0];
}

+ (UIImage*)strectchableImageName:(NSString*)name topCapHeight:(int)topCapHeight
{
    UIImage* image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:0 topCapHeight:topCapHeight];    
}

+ (UIImage*)strectchableImageName:(NSString*)name leftCapWidth:(int)leftCapWidth topCapHeight:(int)topCapHeight
{
    UIImage* image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];    
}

+ (UIImageView*)strectchableImageView:(NSString*)name viewWidth:(int)viewWidth
{
    UIImage* image = [UIImage strectchableImageName:name];
    UIImageView* view = [[[UIImageView alloc] initWithImage:image] autorelease];
    view.frame = CGRectMake(0, 0, viewWidth, image.size.height);
    return view;
}


@end
