//
//  FirstViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "PPSegmentControl.h"
#import "UIImage+UIImageUtil.h"
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>

@implementation FirstViewController

@synthesize categoryName;
@synthesize categoryId;
@synthesize titlePPSegControl =_titlePPSegControl;
@synthesize theMovie=_theMovie;

enum WORKOUT_TIME_TYPE {
   TOP_10,
   TOP_15,
   TOP_20,
   TOP_25,
   TOP_30
};




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    
    switch (self.titlePPSegControl.selectedSegmentIndex) {
        case TOP_10:
        {
           
        }
            break;
        case TOP_15:
        {
                  
        }
            break;
        case TOP_20:
        {
           
        }
            break;
        case TOP_25:
        {
                   
        }
            break;
        case TOP_30:
        {
            
        }
            break;
            
        default:
            break;
    } 
    
    [_theMovie release];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"10分钟", @"15分钟", @"20分钟", @"25分钟",@"30分钟", nil];
    
    UIImage *bgImage = [UIImage strectchableImageName:@"tu_46.png"];
    UIImage *selectImage = [UIImage strectchableImageName:@"tu_39-15.png"];
    
    _titlePPSegControl = [[PPSegmentControl alloc]initWithItems:titleArray defaultSelectIndex:0 frame:CGRectMake(7, 40, 306, 33)];
    
    [self.titlePPSegControl setBackgroundImage:bgImage];
    [self.titlePPSegControl setSelectedSegmentImage:selectImage];
    [self.titlePPSegControl setTextFont:[UIFont boldSystemFontOfSize:12]];
    [self.titlePPSegControl setSelectedSegmentTextFont:[UIFont boldSystemFontOfSize:12]];
    
    [self.titlePPSegControl setTextColor:
     [UIColor colorWithRed:111/255.0 green:104/255.0 blue:94/255.0 alpha:1]];
    [self.titlePPSegControl setSelectedSegmentTextColor:
     [UIColor colorWithRed:134/255.0 green:148/255.0 blue:67/255.0 alpha:1.0]];
    
    [self.titlePPSegControl setDelegate:self];
    [self.view addSubview:_titlePPSegControl];
    [self clickSegControl:_titlePPSegControl];
    
    
    
    [self hideTabBar];
    
    [self.navigationItem.backBarButtonItem  setTitle:@"back"];
    
//    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonClick)] autorelease];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                      
                                      initWithTitle:@"刷新"
                                      
                                      style:UIBarButtonItemStylePlain
                                      
                                      target:self
                                      
                                      action:nil];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     
                                     initWithTitle:@"撤退"
                                     
                                     style:UIBarButtonItemStylePlain
                                     
                                     target:self
                                     
                                     action:@selector(backButtonClick)];
    
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
}

-(void)backButtonClick{
    
    
    [self.theMovie stop];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark -
#pragma mark Hide and Show TabBar Methods

- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.titlePPSegControl = nil;
    [self.theMovie pause];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [self.theMovie pause];

}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    [self.theMovie pause];

}



#pragma mark -  PlayMovie Methods

- (void)video_play:(NSString*)filename
{
    NSString *s = [[NSBundle mainBundle] pathForResource:filename ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:s];
    NSLog(@"Playing URL: %@",url);
    [self playMovieAtURL:url];
}

- (void)playMovieAtURL:(NSURL*)theURL
{
    
    
    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:theURL];
    
    self.theMovie= moviePlayer;
    [moviePlayer release];
     //theMovie.scalingMode=MPMovieScalingModeAspectFill;
    //    theMovie.userCanShowTransportControls=NO;
    
    // Register for the playback finished notification.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_theMovie];
    
    self.theMovie.controlStyle = MPMovieControlStyleEmbedded;
//    self.theMovie.scalingMode = MPMovieScalingModeFill;
    
    self.theMovie.view.frame = CGRectMake(0, 100, 320, 250);
    self.theMovie.view.backgroundColor = [UIColor clearColor];
    self.theMovie.shouldAutoplay =NO;
    self.theMovie.scalingMode = MPMovieScalingModeAspectFit;

    
    [self.view addSubview:self.theMovie.view];
    
//    双击屏幕全屏
     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFullScreen"];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDetectDoubleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.theMovie.view addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    
    ////Animations 使得MovieView 往左右边缓慢移动进入页面
    CGRect Originframe = CGRectMake(300, 100, 320, 250);
    [self.theMovie.view setFrame:Originframe];
    [self.theMovie.view.layer  setOpacity:0.0 ];
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:1.0];
    Originframe.origin.x -= 300 ;
    [self.theMovie.view setFrame:Originframe];
    [self.theMovie.view.layer  setOpacity:1.0 ];
    [UIView commitAnimations];

    
    // Movie playback is asynchronous, so this method returns immediately.
    //set it play automatically
      [self.theMovie play];
    
}


- (void)didDetectDoubleTap:(UITapGestureRecognizer *)tap{
     [self.theMovie setFullscreen:YES];
}


// When the movie is done,release the controller.
- (void)myMovieFinishedCallback:(NSNotification*)aNotification
{
    
    MPMoviePlayerController* theMovie=[aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    self.theMovie.fullscreen = NO;
    // Release the movie instance created in playMovieAtURL
//    [theMovie release];

}





#pragma mark -  PPSegmentControl Delegate

-(void)didSegmentValueChange:(PPSegmentControl *)seg
{
    [self clickSegControl:seg];
    
}

- (void)clickSegControl:(id)sender{

    PPSegmentControl* segControl = sender;
    switch ([segControl selectedSegmentIndex]) {
        case TOP_10:
            NSLog(@"show  10");
            [self video_play:@"01"];
            break;
        case TOP_15:
            NSLog(@"show  15");
            [self video_play:@"02"];
            break;
        case TOP_20:
            NSLog(@"show 20");
            [self video_play:@"03"];

            break;
        case TOP_25:
            NSLog(@"show 25");
            [self video_play:@"04"];
            break;
        case TOP_30:
            NSLog(@"show 30");
            [self video_play:@"05"];

            break;

        default:
            break;
    }


}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||interfaceOrientation ==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

@end
