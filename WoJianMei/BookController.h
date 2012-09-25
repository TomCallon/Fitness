//
//  BookController.h
//  MBook
//
//  Created by  on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeavesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CatalogView.h"
#import "MusicScoreViewController.h"




@class Pagination;


@interface BookController : LeavesViewController<CatalogViewDelegate,showMScoreViewControllerDelegate>
{
    Pagination *pagination;
}
@property (retain, nonatomic) UIButton *bookself;

@property (retain, nonatomic)  UIButton *catalog;
@property (retain, nonatomic)  CatalogView *catalogView;
@end
