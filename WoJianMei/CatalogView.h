//
//  CatalogView.h
//  MBook
//
//  Created by  on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Catalog;
@class CatalogView;

@protocol CatalogViewDelegate <NSObject>

@optional 
- (void) catalogView:(CatalogView *)catalogView didSelectCatalog:(Catalog *)catalog;

@end


@interface CatalogView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_catalogList;
}
@property(nonatomic, retain)NSArray *catalogList;
@property(nonatomic, assign)id<CatalogViewDelegate>catalogViewDelegate;
@end
