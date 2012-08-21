//
//  ShowBigImageViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundView : UIView {
}
@end

@interface ShowBigImageViewController : UIViewController
{
    
    UIImageView *_showBigImageView;
    NSString *_imageName;
    UIImage *_image;

}

@property (nonatomic,retain) IBOutlet UIImageView *showBigImageView;
@property (nonatomic,retain) NSString *imageName;
@property (nonatomic,retain) UIImage *image;



@end
