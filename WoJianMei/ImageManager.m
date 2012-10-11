//
//  ImageManager.m
//  MBook
//
//  Created by  on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager

+ (UIImage *)stretchaleImageName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    CGSize size = image.size;
    return [image stretchableImageWithLeftCapWidth:size.width/2 topCapHeight:size.height/2];
}




/////BookImageview
+ (UIImage *)bookBgImage
{
    return [UIImage imageNamed:@"book_bg.png"];
}
+ (UIImage *)bookselfButton
{
    return [UIImage imageNamed:@"bookself_button.png"];
}
+ (UIImage *)bookselfButtonPress
{
    return [UIImage imageNamed:@"bookself_button_press.png"];
}

+ (UIImage *)catalogButton
{
    return [UIImage imageNamed:@"page_button.png"];
}

+ (UIImage *)catalogButtonPress
{
    return [UIImage imageNamed:@"page_button_press.png"];    
}

+ (UIImage *)musicButton
{
    return [UIImage imageNamed:@"music.png"];        
}
+ (UIImage *)videoButton
{
    return [UIImage imageNamed:@"video.png"];            
}





///////////关联页面

+(UIImage*)weiboImage{
    return [UIImage imageNamed:@"LOGO_16x16.png"];
}
+(UIImage*)qqImage{
    return [UIImage imageNamed:@"qq.png"];
}
+(UIImage*)renrenImage{
    return [UIImage imageNamed:@"renren.png"];
}
+(UIImage*)kaixinImage{
    return [UIImage imageNamed:@"48x48.png"];
}
+(UIImage*)tengxunWeiboImage{
    return [UIImage imageNamed:@"tengxunweibo.png"];
}
+(UIImage*)doubanImage{
    return [UIImage imageNamed:@"douban.png"];
}
+(UIImage*)loginEmailImage{
    return [UIImage imageNamed:@"email.png"];
}

///////AVATAR
+(UIImage*)avatarbackgroundImage{
    return [UIImage imageNamed:@"touxiang_40x40@2x.png"];
}


@end
