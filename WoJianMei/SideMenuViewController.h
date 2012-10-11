//
//  SideMenuViewController.h
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import <UIKit/UIKit.h>
//#import "TomCallonTableViewController.h"

@interface SideMenuViewController : UITableViewController

{
    NSArray *_sectionTitlesArray;
    UIView  *_headerView;
    
}
@property (nonatomic,retain) NSArray *sectionTitlesArray;
@property (nonatomic,retain) UIView *headerView;

@end