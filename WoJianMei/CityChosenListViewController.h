//
//  CityChosenListViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 10/10/12.
//
//

#import "TomCallonTableViewController.h"

@protocol CityChooseDelegate <NSObject>

-(void)didChooseCity:(id)city;

@end

@interface CityChosenListViewController : TomCallonTableViewController
{

    id<CityChooseDelegate>delegate;

}
@property (nonatomic, assign) id<CityChooseDelegate>delegate;


@end
