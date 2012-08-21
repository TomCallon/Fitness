//
//  TomCallonViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKLoadingView.h"

@interface TomCallonViewController : UIViewController{

    TKLoadingView*          _loadingView;

}
@property (nonatomic, retain) TKLoadingView*        loadingView;



// this method helps you to performa an internal method with loading view
- (void)performSelectorWithLoading:(SEL)aSelector loadingText:(NSString*)loadingText;

- (void)showActivityWithText:(NSString*)loadingText withCenter:(CGPoint)point;
- (void)showActivityWithText:(NSString*)loadingText;
- (void)showActivity;
- (void)hideActivity;

@end
