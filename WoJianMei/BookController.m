//
//  BookController.m
//  MBook
//
//  Created by  on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookController.h"
#import "Pagination.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageManager.h"
#import "CatalogView.h"
#import "Catalog.h"
#import "Link.h"


#import "MusicScoreViewController.h"
#import "MScorePlayViewController.h"

@implementation BookController
@synthesize catalog;
@synthesize bookself;
@synthesize catalogView;


#define SHOW_FONT    [UIFont systemFontOfSize:16]
#define SHOW_BOUNDS CGRectMake(0, 0, 265, 390)
#define SHOW_FRAME CGRectMake(25, 60, 265, 390)


#define BOOKSELF_FRAME CGRectMake(230, 20, 71, 37)
#define CATALOG_FRAME CGRectMake(12, 12, 54, 54)
#define CATALOG_VIEW_FRAME CGRectMake(25, 60, 220, 300)
#define PAGE_NUMBER_FRAME CGRectMake(150, 440, 30, 30)
//#define MUSIC_DEMO_FRAME CGRectMake(0, 350, 76, 40)
//#define VIDEO_DEMO_FRAME CGRectMake(0, 190, 76, 40)

#define PERFORM_WIDTH 120
#define ANIMATION_DURATION 0.6

#define kDuration 0.7  // 立体翻页动画持续时间(秒)
 

 


-(void)showMScoreViewController{
    

   MScorePlayViewController *mScorePlayViewController = [[MScorePlayViewController alloc]initWithLink:2];
    [self.navigationController presentModalViewController:mScorePlayViewController animated:YES];
    
}



- (void)clickBookself:(id)sender {
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:kDuration];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
//    [UIView setAnimationDelegate:self];
//    
//    // 动画完毕后调用某个方法
//    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
//    [UIView commitAnimations];
    
    [self.navigationController popViewControllerAnimated:YES];


}

//-(void)animationFinished:(id)sender{
//    
//}


- (void)clickCatalog:(id)sender {
    if (self.catalogView.hidden) {
        self.catalogView.hidden = NO;
        [self.catalogView setAlpha:1];
//        self.catalogView.backgroundColor = [UIColor grayColor];
        [self.view bringSubviewToFront:self.catalogView];
        [self.catalogView reloadData];

        ////Animations 使得CatalogView 往左右边缓慢移动进入页面
        CGRect Originframe = CGRectMake(300, 50, 210, 250);
        [self.catalogView setFrame:Originframe];
        [self.catalogView.layer  setOpacity:0.0 ];
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.4];
         Originframe.origin.x -= 300 ;
        [self.catalogView setFrame:Originframe];
        [self.catalogView.layer  setOpacity:1.0 ];
        [UIView commitAnimations];
        
    }else{
        self.catalogView.hidden = YES;
    }
}


- (void)initViews
{
    self.bookself = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bookself setTitle:@"书柜" forState:UIControlStateNormal];
    [self.bookself setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.bookself setFrame:BOOKSELF_FRAME];
    [self.bookself.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.bookself setBackgroundImage:[ImageManager bookselfButton] forState:UIControlStateNormal];
    [self.bookself addTarget:self action:@selector(clickBookself:) forControlEvents:UIControlEventTouchUpInside];
    
    //init catalog button
    self.catalog = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.catalog setFrame:CATALOG_FRAME];
    [self.catalog setImage:[ImageManager catalogButton] forState:UIControlStateNormal];
    [self.catalog setImage:[ImageManager catalogButtonPress] forState:UIControlStateNormal];
    [self.catalog addTarget:self action:@selector(clickCatalog:) forControlEvents:UIControlEventTouchUpInside];
        
    
    //init catalog table view.
    self.catalogView = [[CatalogView alloc] initWithFrame:CATALOG_VIEW_FRAME];
    NSMutableArray *array = [NSMutableArray array];
    
    Catalog *c1 = [Catalog catalogWithIndex:0 chapter:@"第一章 音的概念"];
    Catalog *c2 = [Catalog catalogWithIndex:2 chapter:@"第二章 乐音体系和音级"];
    Catalog *c3 = [Catalog catalogWithIndex:3 chapter:@"第三章 半音和全音"];
    Catalog *c4 = [Catalog catalogWithIndex:3 chapter:@"第四章 音名和唱名"];
    Catalog *c5 = [Catalog catalogWithIndex:4 chapter:@"第五章 基本音级与变化音级"];

    [array addObject:c1];
    [array addObject:c2];
    [array addObject:c3];
    [array addObject:c4];
    [array addObject:c5];
    self.catalogView.catalogList = array;
    self.catalogView.catalogViewDelegate = self;
    
}

- (void)viewDidLoad
{
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
	NSString *txtContent = [NSString stringWithContentsOfFile:contentPath encoding:NSUTF8StringEncoding error:nil];
	pagination = [[Pagination alloc] initWithContent:txtContent withFont:SHOW_FONT inRect:SHOW_BOUNDS];
    [super viewDidLoad];
    [leavesView setPreferredTargetWidth:PERFORM_WIDTH];
    [self initViews];
    [self.view addSubview:self.bookself];
    [self.view addSubview:catalog];
    [self.view addSubview:self.catalogView];
    [self.catalogView setHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hideTabBar];

}


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


#pragma mark - button animation.
#define HIDE_ANIMATION_ID @"HideButton"



- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:HIDE_ANIMATION_ID]) {
        NSLog(@"animationDidStop");
        self.bookself.hidden = self.catalog.hidden = self.catalogView.hidden = YES;        
    }
}

- (void)hideButtons:(BOOL)animated
{
    if (!self.bookself.hidden) {
        if (animated) {
            [UIView beginAnimations:HIDE_ANIMATION_ID context:NULL];
            [UIView setAnimationDuration:ANIMATION_DURATION];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            [self.bookself setAlpha:0];
            self.catalog.alpha = 0;
            self.catalogView.alpha = 0;
            [UIView commitAnimations];            
        }else{
            self.bookself.hidden = self.catalog.hidden = self.catalogView.hidden = YES;        
        }
    }
}

- (void)showButtons:(BOOL)animated
{
    if (self.bookself.hidden) {
        [self.view bringSubviewToFront:self.bookself];
        [self.view bringSubviewToFront:self.catalog];        
            self.bookself.hidden = self.catalog.hidden = NO;         
        if (animated) {
            self.bookself.alpha = 0;
            self.catalog.alpha = 0;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:ANIMATION_DURATION];
            [self.bookself setAlpha:1];
            self.catalog.alpha = 1;
            [UIView commitAnimations];
        }
    }
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return pagination.totalPageCount;
}

- (void) leavesView:(LeavesView *)leavesView didClickPageAtIndex:(NSUInteger)pageIndex
{
    if (self.bookself.hidden) {
        [self showButtons:YES];
    }else{
        [self hideButtons:YES];
    }
}


- (void) leavesView:(LeavesView *)leavesView didBeginTouchPageAtIndex:(NSUInteger)pageIndex
{
    [self hideButtons:YES];
}

- (void) leavesView:(LeavesView *)leavesView didClickLink:(Link *)link atPageIndex:(NSUInteger)pageIndex
{
    
    MScorePlayViewController *mc = [[MScorePlayViewController alloc] initWithLink:pageIndex + 2];
    [self.navigationController pushViewController:mc animated:YES];
    [mc release];
    
    
    // TODO show the music playing controller
//    NSLog(@"Click %d page link!",pageIndex);
//    MusicScoreViewController *musicScoreController = [[MusicScoreViewController alloc]initWithNibName:@"MusicScoreViewController" bundle:nil];
//    musicScoreController.delegate = self;
//    
//    [self.navigationController pushViewController:musicScoreController animated:YES];
}


- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
    NSString *text = [pagination contentForPage:index+1];
    
    
    Link *link = [Link linkWithString:text];
    if(link != nil){
        NSLog(@"Link:[range = (%d,%d), type = %d, linkId = %d ,name = %@]",link.range.location,link.range.length,link.type,link.linkId, link.name);
        text = [Link replaceRangeString:text withLink:link];
    }
    
    CGContextTranslateCTM(ctx, 0,leavesView.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    UIGraphicsPushContext(ctx);
    UIImage *bg = [ImageManager bookBgImage];
    [bg drawInRect:self.view.bounds];
    [text drawInRect:SHOW_FRAME withFont:SHOW_FONT];
    
        
    NSString *page = [NSString stringWithFormat:@"%d/%d",index + 1, pagination.totalPageCount];
    [page drawInRect:PAGE_NUMBER_FRAME withFont:[UIFont systemFontOfSize:12]];
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    //draw link 
    if (link) {
        NSString *showStr = [NSString stringWithFormat:@"①——《%@》",link.name];
        if (link.type == LinkTypeMusic) {
            [[ImageManager musicButton] drawInRect:MUSIC_DEMO_FRAME];
            [showStr drawAtPoint:CGPointMake(60, 360) withFont:[UIFont systemFontOfSize:18]];
        }else{
            [[ImageManager videoButton] drawInRect:VIDEO_DEMO_FRAME];            
            [showStr drawAtPoint:CGPointMake(60, 200) withFont:[UIFont systemFontOfSize:18]];
        }
    }

    
    UIGraphicsPopContext();
}


- (void)dealloc {
    [bookself release];
    [catalog release];
    [catalogView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBookself:nil];
    [self setCatalog:nil];
    [super viewDidUnload];
}

- (void) catalogView:(CatalogView *)catalogView didSelectCatalog:(Catalog *)catalog
{
    [leavesView setCurrentPageIndex:catalog.index];
//    catalogView.hidden = YES;
    [self hideButtons:YES];
}

@end
