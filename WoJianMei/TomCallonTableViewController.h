//
//  TomCallonTableViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TomCallonViewController.h"
#import "EGORefreshTableHeaderView.h"



@interface TomCallonTableViewController : TomCallonViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>
{


    UITableView *_tableView;
    NSArray *_dataList;

    // for pull refresh	
    EGORefreshTableHeaderView *_refreshTableHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
    BOOL supportRefreshHeader;///show the RefreshHeaderView or not




}
@property (nonatomic ,retain) IBOutlet UITableView *tableView;
@property (nonatomic ,retain) NSArray *dataList;
@property (nonatomic ,retain) EGORefreshTableHeaderView *refreshTableHeaderView;



// for pull refresh
@property(assign,getter=isReloading) BOOL reloading;
@property (nonatomic, assign,getter = isRefreshHeaderViewEnable) BOOL              refreshHeaderViewEnable;
@property(nonatomic,assign) BOOL supportRefreshHeader;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;



@end










