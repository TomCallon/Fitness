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




@class Pagination;


@interface BookController : LeavesViewController<CatalogViewDelegate>
{
    Pagination *pagination;
}
@property (retain, nonatomic)  UIButton *bookself;
@property (retain, nonatomic)  UIButton *catalogButton;
@property (retain, nonatomic)  CatalogView *catalogView;
@end
