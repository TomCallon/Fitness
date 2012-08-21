//
//  TomCallonViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TomCallonViewController.h"

@interface TomCallonViewController ()

@end

@implementation TomCallonViewController
@synthesize loadingView =_loadingView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
#pragma mark activity loading view

- (TKLoadingView*)getActivityViewWithText:(NSString*)loadingText withCenter:(CGPoint)point
{
	if (_loadingView == nil){
		self.loadingView = [[[TKLoadingView alloc] initWithTitle:@"" message:loadingText] autorelease];
        _loadingView.center = point;
		[self.view addSubview:_loadingView];
	}
	
	return _loadingView;
}

- (TKLoadingView*)getActivityViewWithText:(NSString*)loadingText
{
	if (_loadingView == nil){
		self.loadingView = [[[TKLoadingView alloc] initWithTitle:@"" message:loadingText] autorelease];
        _loadingView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2+10);
		[self.view addSubview:_loadingView];
	}
	
	return _loadingView;
}

- (void)showActivityWithText:(NSString*)loadingText withCenter:(CGPoint)point
{
	_loadingView = [self getActivityViewWithText:loadingText withCenter:point];
	[_loadingView setMessage:loadingText];
	[_loadingView startAnimating];
	_loadingView.hidden = NO;
}

- (void)showActivityWithText:(NSString*)loadingText
{
	_loadingView = [self getActivityViewWithText:loadingText];
	[_loadingView setMessage:loadingText];
	[_loadingView startAnimating];
	_loadingView.hidden = NO;
    [self.view bringSubviewToFront:_loadingView];
}

- (void)showActivity
{
    [self showActivityWithText:@""];;
}

- (void)hideActivity
{
	[_loadingView stopAnimating];
	_loadingView.hidden = YES;
}

#pragma mark background selector execution

- (void)performSelectorStopLoading:(NSString*)selectorString
{
	[self performSelector:NSSelectorFromString(selectorString) withObject:nil];
	[self hideActivity];
}

- (void)performSelectorWithLoading:(SEL)aSelector loadingText:(NSString*)loadingText
{	
	[self performSelector:@selector(performSelectorStopLoading:) withObject:NSStringFromSelector(aSelector) afterDelay:0.0];
	CGPoint point = CGPointMake(160, 290);
    [self showActivityWithText:loadingText withCenter:point];
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
