//
//  ShowBigImageViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShowBigImageViewController.h"
#import "UIView+TKCategory.h"


@implementation BackgroundView

- (void)drawRect:(CGRect)rect
{
    
//    [[UIColor colorWithWhite:0 alpha:0.8] set];
//	[UIView drawRoundRectangleInRect:rect withRadius:10];
//	[[UIColor whiteColor] set];
    //	[_text drawInRect:_messageRect withFont:[UIFont boldSystemFontOfSize:14] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
	
    //	CGRect r = CGRectZero;
    //	r.origin.y = 15;
    //	r.origin.x = (rect.size.width-_image.size.width)/2;
    //	r.size = _image.size;
    //	
    //	[_image drawInRect:r];
}

@end





@interface ShowBigImageViewController ()

@end

@implementation ShowBigImageViewController
@synthesize showBigImageView =_showBigImageView;
@synthesize imageName =_imageName;
@synthesize image =_image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)dealloc{


    [super dealloc];
    [_showBigImageView release];
    [_imageName release];
    [_image release];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    self.showBigImageView.image = [UIImage imageNamed:self.imageName];
    
    self.showBigImageView.image = _image;
    NSLog(@"Tell me the retaincount %d",[_image retainCount]);

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.showBigImageView = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
