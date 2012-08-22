//
//  MyselfViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import "MyselfViewController.h"
#import "WeiBoMessageManager.h"
////处理图片缓存
#import "HHNetDataCacheManager.h"
#import "user.h"



@interface MyselfViewController ()

@end

@implementation MyselfViewController
@synthesize avatarImage;
@synthesize headerVImageV;
@synthesize user;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


-(void)dealloc{
    [super dealloc];
//    self.avatarImage = nil;
//    self.user = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//     weiBoMessageManager = [WeiBoMessageManager getInstance];
//    [weiBoMessageManager getGeocodeGeoToAddress:nil];

//    ////获取用户微博个人信息
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAvatar:)         name:HHNetDataCacheNotification object:nil];
//
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetGeocodeGeoToAddress:) name:MMSinaGotGeocodeGeoToAddress object:nil];
//    
//    if (avatarImage) {
//        self.headerVImageV.image = avatarImage;
//    }
//    else {
//        [[HHNetDataCacheManager getInstance] getDataWithURL:user.profileLargeImageUrl];
//    }
    

}

-(void)viewDidUnload{

    [super viewDidUnload];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MMSinaGotUserStatus        object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:MMSinaGotGeocodeGeoToAddress object:nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];

}


-(void)didGetGeocodeGeoToAddress:(NSNotification*)sender{
    
    NSLog(@"%@",[sender description]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
