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
#import "ZJTGloble.h"


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
    
    [self.headerVImageV release];
    [self.avatarImage  release];
    [self.user release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//     weiBoMessageManager = [WeiBoMessageManager getInstance];
//    [weiBoMessageManager getGeocodeGeoToAddress:nil];

    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAvatar:)         name:HHNetDataCacheNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mmRequestFailed:)   name:MMSinaRequestFailed object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed)       name:DID_GET_TOKEN_IN_WEB_VIEW object:nil];
    

//    if (avatarImage) {
//        self.headerVImageV.image = avatarImage;
//    }
//    else {
//        [[HHNetDataCacheManager getInstance] getDataWithURL:user.profileLargeImageUrl];
//    }
//    

}

-(void)viewDidUnload{

    [super viewDidUnload];
    
    self.headerVImageV = nil;
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:HHNetDataCacheNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MMSinaRequestFailed        object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:DID_GET_TOKEN_IN_WEB_VIEW  object:nil];    
//
    
}


-(void)getAvatar:(NSNotification*)sender
{
    NSLog(@"getAvatar:(NSNotification*)sender");
   
}


-(void)mmRequestFailed:(id)sender{
    NSLog(@"mmRequestFailed:(id)sender");
}

-(void)loginSucceed
{
    shouldLoad = YES;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
