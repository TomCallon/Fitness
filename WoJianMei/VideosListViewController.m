//
//  ProductListViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VideosListViewController.h"
#import "VideoListCell.h"
#import "Video.h"
#import "VideoManager.h"
#import "WorkOut.h"
#import "ShowBigImageViewController.h"
#import "ShowAlertTextViewController.h"
#import "UIBadgeView.h"

#import "MBProgressHUD.h"
#import "InAppFitnessIAPHelper.h"
#import "Reachability.h"


#import <StoreKit/StoreKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Social/Social.h>


#import "WeiBoHttpManager.h"
#import "WeiBoMessageManager.h"
#import "TwitterVC.h"
#import "ZJTGloble.h"
//#import "SHKActivityIndicator.h"


#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - action method
#define BODY_PART_BASE_BUTTON_TAG 1600
#define BODY_PART_MY_PLAN_TAG 1604

#define BODY_PART_END_BUTTON_TAG BODY_PART_MY_PLAN_TAG


#define HHNetDataCacheNotification @"HHNetDataCacheNotification"


@interface VideosListViewController ()

@end

@implementation VideosListViewController
@synthesize mainArray =_mainArray;
@synthesize selectedButton =_selectedButton;
@synthesize myFollowButton =_myFollowButton;
@synthesize myFollowCountView =_myFollowCountView;
@synthesize showBigImageViewController =_showBigImageViewController;
@synthesize hud =_hud;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}


-(void)dealloc{
    
    
    [_hud release];
     _hud = nil;
    [_mainArray release];
    [_myFollowButton release];
    [_selectedButton release];
    [_myFollowCountView  release];
    [_showBigImageViewController release];
    
    [super dealloc];

}


#pragma mark -
#pragma mark -in app purchasing method

- (void)dismissHUD:(id)arg {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.hud = nil;
    
}

- (void)productsLoaded:(NSNotification *)notification {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
//     self.tableView.hidden = FALSE;
//    [self.tableView reloadData];
    
}

- (void)timeout:(id)arg {
    
    _hud.labelText = @"Timeout!";
    _hud.detailsLabelText = @"Please try again later.";
    _hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	_hud.mode = MBProgressHUDModeCustomView;
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
    
}

- (void)updateInterfaceWithReachability: (Reachability*) curReach {
    
    NSLog(@"%@",[curReach description]);
}


#pragma mark -
#pragma mark -Send WeiBlog

-(void)sendWeiBlog{
    NSLog(@"hey you can write WeiBlog now");
    
    
}

-(void)initWeiBlogSettings{
  
    //如果未授权，则调入授权页面。
    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_ACCESS_TOKEN];
    NSLog([weiBoMessageManager isNeedToRefreshTheToken] == YES ? @"need to login":@"will login");
    if (authToken == nil || [weiBoMessageManager isNeedToRefreshTheToken])
    {
        shouldLoad = YES;
        OAuthWebView *webV = [[OAuthWebView alloc]initWithNibName:@"OAuthWebView" bundle:nil];
        webV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webV animated:YES];
        [webV release];
    }
    else
    {
        [weiBoMessageManager getUserID];
        [weiBoMessageManager getHomeLine:-1 maxID:-1 count:-1 page:-1 baseApp:-1 feature:-1];
//        [[SHKActivityIndicator currentIndicator] displayActivity:@"正在载入..." inView:self.view];
        [[ZJTStatusBarAlertWindow getInstance] showWithString:@"正在载入，请稍后..."];
    }
    [defaultNotifCenter addObserver:self selector:@selector(didGetUserID:)      name:MMSinaGotUserID            object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(didGetHomeLine:)    name:MMSinaGotHomeLine          object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(didGetUserInfo:)    name:MMSinaGotUserInfo          object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(relogin)            name:NeedToReLogin              object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(didGetUnreadCount:)                   name:MMSinaGotUnreadCount object:nil];


}




#pragma mark -
#pragma mark -View LifyStytle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
            

//    UITabBarItem *tab1 = [[UITabBarItem alloc] initWithTitle:@"视频"
//                                                       image:[UIImage imageNamed:@"b_menu_1.png"] tag:4];
//    [self setTabBarItem:tab1];
//    [tab1 setFinishedSelectedImage:[UIImage imageNamed:@"b_menu_1s.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"b_menu_1.png"]];
    

   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];

    
    
    ////init the follow count badge view
    [self myFollowCountBadgeViewInit];
        
    
    UIBarButtonItem *retwitterBtn = [[UIBarButtonItem alloc]initWithTitle:@"发微博" style:UIBarButtonItemStylePlain target:self action:@selector(sendWeiBlog)];
       
    
    self.navigationItem.rightBarButtonItem = retwitterBtn;
       
    [retwitterBtn release];
    
    [self  initWeiBlogSettings];
    
    
    [defaultNotifCenter addObserver:self selector:@selector(getAvatar:)         name:HHNetDataCacheNotification object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(mmRequestFailed:)   name:MMSinaRequestFailed object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(loginSucceed)       name:DID_GET_TOKEN_IN_WEB_VIEW object:nil];

    [[ZJTStatusBarAlertWindow getInstance] hide];

//    Upper Area
//    Trapezius ( neck ) >
//    Deltoid ( shoulders ) >
//    Biceps ( arms ) >
//    Triceps ( arms ) >
//    Forearm ( wrists ) >

    //////Upper Area  
    WorkOut *workOut =[[WorkOut alloc]init];
    workOut.workOutTimeLength = @"40minutes";
    workOut.repeatTimes = @"7 -12 次";
    workOut.sets = @"6-7组";
    Video *video1 = [[Video alloc]initWithId:@"1"
                                          title:@"Neck_exercises_s" 
                                      timeLeght:@"40minutes" 
                                          image:[UIImage imageNamed:@"neck_exercises_s.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    Video *video2 = [[Video alloc]initWithId:@"2" 
                                               title:@"Shoulder-Exercises" 
                                      timeLeght:@"40minutes" 
                                          image:[UIImage imageNamed:@"Shoulder-Exercises.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    
    Video *video3 = [[Video alloc]initWithId:@"3" 
                                       title:@"Biceps-Exercises" 
                                      timeLeght:@"40minutes" 
                                          image:[UIImage imageNamed:@"Biceps-Exercises.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    Video *video4 = [[Video alloc]initWithId:@"4" 
                                       title:@"Triceps-Exercises" 
                                      timeLeght:@"40minutes" 
                                          image:[UIImage imageNamed:@"Triceps-Exercises.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    Video *video5 = [[Video alloc]initWithId:@"5" 
                                       title:@"Forearm-exercises" 
                                      timeLeght:@"30minutes" 
                                          image:[UIImage imageNamed:@"forearm-exercises.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    //////Middle  Area
    //    Pectoral ( chest ) >
    //    Abs ( abdomen ) >
    //    Oblique Abs ( lateral abdomen ) >
    //    Dorsal ( back ) >
    //    Lumbar ( lower back ) >


    
    Video *video6 = [[Video alloc]initWithId:@"6" 
                                       title:@"Chest-Exercises_s" 
                                      timeLeght:@"40minutes" 
                                          image:[UIImage imageNamed:@"Chest-Exercises_s.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    Video *video7 = [[Video alloc]initWithId:@"7" 
                                       title:@"Abs-Exercises_s" 
                                      timeLeght:@"20minutes" 
                                          image:[UIImage imageNamed:@"Abs-Exercises_s.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    Video *video8 = [[Video alloc]initWithId:@"8" 
                                       title:@"Oblique-abdominal-exercises" 
                                      timeLeght:@"30minutes" 
                                          image:[UIImage imageNamed:@"Oblique-abdominal-exercises.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    Video *video9 = [[Video alloc]initWithId:@"9" 
                                       title:@"ack-Exercises" 
                                      timeLeght:@"40minutes" 
                                          image:[UIImage imageNamed:@"Back-Exercises.jpg"]
                                       isFollow:NO 
                                        workOut:workOut]; 
    Video *video10 = [[Video alloc]initWithId:@"10" 
                                        title:@"Lower-Back-Exercises" 
                                      timeLeght:@"50minutes" 
                                          image:[UIImage imageNamed:@"Lower-Back-Exercises.jpg"]
                                        isFollow:NO 
                                         workOut:workOut ]; 

                      
                      
    //    Lower Area
    //    Gluteus ( buttocks ) >
    //    Adductor ( internal thigh ) >
    //    Quadriceps ( legs ) >
    //    Femoral ( hamstring ) >
    //    Calf ( ankles )
                
                      
    Video *video11= [[Video alloc]initWithId:@"11" 
                                       title:@"buttocks-exercises" 
                                      timeLeght:@"12minutes" 
                                          image:[UIImage imageNamed:@"buttocks-exercises.jpg"]
                                          isFollow:NO 
                                        workOut:workOut ]; 
    Video *video12 = [[Video alloc]initWithId:@"12" 
                                        title:@"adductor-exercises" 
                                      timeLeght:@"34minutes" 
                                          image:[UIImage imageNamed:@"adductor-exercises.jpg"]
                                        isFollow:NO 
                                        workOut:workOut ]; 
    Video *video13 = [[Video alloc]initWithId:@"13" 
                                        title:@"Quadriceps-exercises" 
                                      timeLeght:@"45minutes" 
                                          image:[UIImage imageNamed:@"quadriceps-exercises.jpg"]
                                        isFollow:NO 
                                        workOut:workOut ]; 
    Video *video14 = [[Video alloc]initWithId:@"14" 
                                        title:@"Hamstring-exercises" 
                                      timeLeght:@"40minutes" 
                                          image:[UIImage imageNamed:@"hamstring-exercises.jpg"]
                                        isFollow:NO 
                                        workOut:workOut ]; 
    Video *video15 = [[Video alloc]initWithId:@"15" 
                                        title:@"Calf-exercises" 
                                      timeLeght:@"40minutes" 
                                          image:[UIImage imageNamed:@"calf-exercises.jpg"]
                                        isFollow:NO 
                                        workOut:workOut ]; 
    
    [workOut release];

    
    
    VideoManager *mangager =[VideoManager defaultManager];
    [mangager addVideo:video1];
    [mangager addVideo:video2];
    [mangager addVideo:video3];
    [mangager addVideo:video4];
    [mangager addVideo:video5];
    [mangager addVideo:video6];
    [mangager addVideo:video7];
    [mangager addVideo:video8];
    [mangager addVideo:video9];
    [mangager addVideo:video10];
    [mangager addVideo:video11];
    [mangager addVideo:video12];
    [mangager addVideo:video13];
    [mangager addVideo:video14];
    [mangager addVideo:video15];

    [video1 release];
    [video2 release];
    [video3 release];
    [video4 release];
    [video5 release];
    [video6 release];
    [video7 release];
    [video8 release];
    [video9 release];
    [video10 release];
    [video11 release];
    [video12 release];
    [video13 release];
    [video14 release];
    [video15 release];
      
    
    for (int i =0; i <[mangager.followVideoList  count]; i++) {
        ///get all the follow videos
        Video *video =[[mangager getAllFollowVideo] objectAtIndex:i];
        if (video.isFollow) {
            Video *notFollowVideo =[mangager getVideoById:video.videoId];
            notFollowVideo.isFollow =[NSNumber  numberWithBool:YES];
            NSLog(@"%d",[video.isFollow intValue]);
            NSLog(@"%d",[video.isFollow intValue]);
        }
    }

      
    [self clickButtons:self.selectedButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [defaultNotifCenter removeObserver:self name:MMSinaGotUserID            object:nil];
    [defaultNotifCenter removeObserver:self name:MMSinaGotHomeLine          object:nil];
    [defaultNotifCenter removeObserver:self name:MMSinaGotUserInfo          object:nil];
    [defaultNotifCenter removeObserver:self name:NeedToReLogin              object:nil];
    [defaultNotifCenter removeObserver:self name:MMSinaGotUnreadCount       object:nil];

    
    self.hud = nil;
    self.selectedButton = nil;
    self.myFollowButton =nil;
    self.tableView =nil;
    self.showBigImageViewController = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    //    self.tableView.hidden = TRUE;
    
       
    
    [super viewWillAppear:animated];
    ///// weiblog
    
    if (shouldLoad)
    {
        shouldLoad = NO;
        [weiBoMessageManager getUserID];
        [weiBoMessageManager getHomeLine:-1 maxID:-1 count:-1 page:-1 baseApp:-1 feature:-1];
        //        [[SHKActivityIndicator currentIndicator] displayActivity:@"正在载入..." inView:self.view];
        [[ZJTStatusBarAlertWindow getInstance] showWithString:@"正在载入，请稍后..."];
    }
    
    
    
    //////in app purchasing
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsLoaded:) name:kProductsLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(productPurchaseFailed:) name:kProductPurchaseFailedNotification object: nil];
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable) {
        NSLog(@"No internet connection!");
    } else {
        if ([InAppFitnessIAPHelper sharedHelper].products == nil) {
            
            [[InAppFitnessIAPHelper sharedHelper] requestProducts];
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _hud.labelText = @"Loading comics...";
            [self performSelector:@selector(timeout:) withObject:nil afterDelay:30.0];
            
        }
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showTabBar];
}





#pragma mark -
#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;		// default implementation
	
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [VideoListCell getCellIdentifier];
    VideoListCell *cell = (VideoListCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[[VideoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VideoListCell getCellIdentifier]] autorelease];
        
    }
    
    cell.VideoListCellDelegate = self;
    cell.indexPath = indexPath;
    Video *video  = [_dataList objectAtIndex:indexPath.row];
    if (video) {
        [cell setCellInfo:video];
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
//    UIViewController *viewController = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
//    
//    [self.navigationController pushViewController:viewController animated:YES];
//    NSLog(@"indexpath.row %d",indexPath.row);

  [self performSegueWithIdentifier:@"VideoSegue" sender:self];   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isPad) {
        return 210.f;
    }
    return  [VideoListCell getCellHeight];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{    // fixed font style. use custom view (UILabel) if you want something different
//
//    NSArray *titleForHeaderInSectionArray =[NSArray arrayWithObjects:@"Upper boddy",@"Middle body",@"Lower boddy", nil];
//    if (section==0) {
//        return [titleForHeaderInSectionArray objectAtIndex:0];
//    } else if (section==1) {
//        return [titleForHeaderInSectionArray objectAtIndex:1];
//    } else if (section==2) {
//        return [titleForHeaderInSectionArray objectAtIndex:2];
//    }
//    
    return nil;
}




#pragma mark -
#pragma mark MYFollowCountBadgeView Methods
- (void)myFollowCountBadgeViewInit
{
    NSInteger tagLen = 20;
    CGRect rect = [_myFollowButton bounds];
//    self.myFollowCountView = [[UIBadgeView alloc] initWithFrame:CGRectMake(rect.size.width-tagLen, -1, tagLen, tagLen)];
    
    UIBadgeView *badgeView = [[UIBadgeView alloc] initWithFrame:CGRectMake(rect.size.width-tagLen, -1, tagLen, tagLen)];
    self.myFollowCountView = badgeView;
    [badgeView release];
    
    [self.myFollowCountView setShadowEnabled:NO];
    [self.myFollowCountView setBadgeColor:[UIColor redColor]];
    [self.myFollowButton addSubview:_myFollowCountView];
    
    
    [self reloadMyFollowCount];
}

- (void)reloadMyFollowCount
{
    VideoManager *manager = [VideoManager defaultManager];
    int followMatchCount = [[manager getAllFollowVideo] count];
    self.myFollowCountView.badgeString = [NSString stringWithFormat:@"%d", followMatchCount];
    if (followMatchCount == -1) {
        [_myFollowCountView setHidden:YES];
    }
    else {
        [_myFollowCountView setHidden:NO];
    }
}

#pragma mark -
#pragma mark VideosDetailCellDelegate Methods

- (void)reloadMyFollowList
{
    VideoManager *manager = [VideoManager defaultManager];
    if ([manager getAllFollowVideo]==nil) {
        return;
        
        
    }
    self.dataList  = [manager getAllFollowVideo];
   [self.tableView reloadData];
}

- (void)didClickFollowButton:(id)sender atIndex:(NSIndexPath *)indexPath{
    
    VideoManager *manager  =[VideoManager defaultManager];
    Video* video = [_dataList objectAtIndex:indexPath.row];
    
    if (video.isFollow == [NSNumber numberWithBool:YES]){
//        [GlobalGetMatchService() unfollowMatch:[UserManager getUserId] match:match];
    [manager unfollowVideo:video];
    [ShowAlertTextViewController show:self.view message:@"已取消该计划"];
    }
    else{
//        [GlobalGetMatchService() followMatch:[UserManager getUserId] match:match]; 
    [manager followVideo:video];
    [ShowAlertTextViewController show:self.view message:@"已添加到计划中"];

    }
    
   if (matchSelectStatus == BODY_PART_MY_PLAN_TAG){
        // only unfollow is possible here... so just update data list and delete the row
        Video* videoInVideoArray = [manager getVideoById:video.videoId];
        [videoInVideoArray setIsFollow:[NSNumber numberWithBool:NO]];//because in 
      [self reloadMyFollowList];    // I am lazy today so I just reload the table view
    }
    else{
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                                  withRowAnimation:UITableViewRowAnimationNone];
    }
        [self reloadMyFollowCount];
}


- (void)didClickBuyButton:(id)sender atIndex:(NSIndexPath *)indexPath{
    
    //    UIAlertView *alertView  = [[UIAlertView alloc]initWithTitle:@"Buy This Video" message:@"Are you sure want to buy this Video ?" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"I buy it next time !",@"yeah babe, i want to buy it ! ",nil] ;
    //
    //    [alertView show];
    //    [alertView release];
    
    
    UIButton *buyButton = (UIButton *)sender;
    buyButton.tag = indexPath.row;
    if (buyButton.tag>2) {
        buyButton.tag = 2;
    }
    SKProduct *product = [[InAppFitnessIAPHelper  sharedHelper].products objectAtIndex:buyButton.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[InAppFitnessIAPHelper sharedHelper] buyProduct:product];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Buying comic...";
    [self performSelector:@selector(timeout:) withObject:nil afterDelay:60*5];
    
}
- (void)productPurchased:(NSNotification *)notification {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *productIdentifier = (NSString *) notification.object;
    NSLog(@"Purchased: %@", productIdentifier);
    
    //    [self.tableView reloadData];
    
}

- (void)productPurchaseFailed:(NSNotification *)notification {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    SKPaymentTransaction * transaction = (SKPaymentTransaction *) notification.object;
    if (transaction.error.code != SKErrorPaymentCancelled) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error!"
                                                         message:transaction.error.localizedDescription
                                                        delegate:nil
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"OK", nil] autorelease];
        
        [alert show];
    }
    
}




-(void)didClickSinaWeiBlogButton:(id)sender atIndex:(NSIndexPath *)indexPath{
  
    Video *video = [_dataList objectAtIndex:indexPath.row];

    if(kCFCoreFoundationVersionNumber >kCFCoreFoundationVersionNumber_iOS_5_1)
    {
        NSLog( @"After Version 5.0" );
        // 首先判断服务器是否可以访问
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
            NSLog(@"Available server of sinaWeiBlog");
            
            // 使用SLServiceTypeSinaWeibo来创建一个新浪微博view Controller
            SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
            
            // 写一个bolck，用于completionHandler的初始化
            SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
                if (result == SLComposeViewControllerResultCancelled) {
                    NSLog(@"cancelled\\");
                } else
                {
                    NSLog(@"done\\");
                }
                [socialVC dismissViewControllerAnimated:YES completion:Nil];
            };
            // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
            socialVC.completionHandler = myBlock;
            
            // 给view controller初始化默认的图片，url，文字信息
            UIImage *shareImage = video.image;
            
            NSURL *url = [NSURL URLWithString:@"www.zhonghuafitness.com"];
            NSString *workMethod = [NSString stringWithFormat:@"在中华健美客户端的帮助下,我练习了<<%@>>%@,每组%@,一共%@",video.title,video.workOut.sets,video.workOut.repeatTimes,video.workOut.workOutTimeLength];

            [socialVC setInitialText:workMethod];
            [socialVC addImage:shareImage];
            [socialVC addURL:url];
            
            // 以模态的方式展现view controller
            [self  presentViewController:socialVC animated:YES completion:Nil];
            
        } else {
            NSLog(@"UnAvailable\\");
        }
    }
    else
    {
        NSLog( @"Version 4.0 or earlier" );
        TwitterVC *tv = [[TwitterVC alloc]initWithNibName:@"TwitterVC" bundle:nil];
        tv.demoWorkOutImage = [video image];
        
        ///练习了3组，4次，共30分钟；
        tv.demoWorkOutMethods = [NSString stringWithFormat:@"<<%@>>%@,每组%@,一共%@",video.title,video.workOut.sets,video.workOut.repeatTimes,video.workOut.workOutTimeLength];
        
        [self.navigationController pushViewController:tv animated:YES];
        [tv release];

    }
    
//    NSLog( @"Version 4.0 or earlier" );
//    TwitterVC *tv = [[TwitterVC alloc]initWithNibName:@"TwitterVC" bundle:nil];
//    tv.demoWorkOutImage = [video image];
//    
//    ///练习了3组，4次，共30分钟；
//    tv.demoWorkOutMethods = [NSString stringWithFormat:@"<<%@>>%@,每组%@,一共%@",video.title,video.workOut.sets,video.workOut.repeatTimes,video.workOut.workOutTimeLength];
//    
//    [self.navigationController pushViewController:tv animated:YES];
//    [tv release];

}

#pragma mark --
#pragma mark alertViewDelegate Method


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    
    enum BUTTON_INDEX_TYPE {
        BUY_IT_NEXT_TIME,
        BUT_IT_NOW,
        CANCEL
        
    }
    
    
    BUTTON_INDEX_TYPE = buttonIndex;
    switch (BUTTON_INDEX_TYPE) {
        case BUY_IT_NEXT_TIME:
            NSLog(@"This is the %d",buttonIndex);
            break;
        case BUT_IT_NOW:
            NSLog(@"This is the %d",buttonIndex);
            
            if ([SKPaymentQueue canMakePayments]) {
                // Display a store to the user.
                
                
                
            } else {
                // Warn the user that purchases are disabled.
                NSLog(@"Your store kit is not avaiable  ");
            }
            break;
        case CANCEL:
            NSLog(@"This is the %d",buttonIndex);
            break;
        default:
            break;
    }
}



-(void)clickShowBigImage:(id)sender{
      
    UIButton *button = (UIButton *)sender;
    UIImage *image = (UIImage *) button.imageView.image;
    self.showBigImageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowBigImage"];
    self.showBigImageViewController.image = image;
    NSLog(@"WHAT THE THE COUNT OF THE IMAGES %d",[image retainCount]);
    
    
    //  双击显示大图片
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFullScreen"];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDetectDoubleTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.showBigImageViewController.view addGestureRecognizer:tapGesture];
    [tapGesture release];
        
    [_showBigImageViewController.view setFrame:CGRectMake(0, -40, 320, 440)];
    [self hideTabBar];
    [self.view addSubview:self.showBigImageViewController.view];
}

- (void)didDetectDoubleTap:(UITapGestureRecognizer *)tap{
    
    [tap.view removeFromSuperview];
    NSLog(@"Dismiss the ImageView");
}



#pragma mark -
#pragma mark Hide and Show TabBar Methods

- (void)showTabBar {
     UITabBar *tabBar = self.tabBarController.tabBar;
     UIView *parent = tabBar.superview; // UILayoutContainerView
     UIView *content = [parent.subviews objectAtIndex:0]; // UITransitionView
     UIView *window = parent.superview;
     [UIView animateWithDuration:0.5
          animations:^{
          CGRect tabFrame = tabBar.frame;
          tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
          tabBar.frame = tabFrame;
          CGRect contentFrame = content.frame;
          contentFrame.size.height -= tabFrame.size.height;
          }];
}


- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
    
}



#pragma mark -
#pragma mark BodyButtons Methods




- (IBAction)clickButtons:(id)sender{
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
    for (int i = BODY_PART_BASE_BUTTON_TAG; i <= BODY_PART_MY_PLAN_TAG; ++ i) {
        if (i != button.tag) {
            UIButton *unselectedButton = (UIButton *)[self.view viewWithTag:i];
            unselectedButton.selected = NO;
        }
    }
    enum BODDY_PART_TAG {
        ALL_AREA_PART= BODY_PART_BASE_BUTTON_TAG,
        UPPER_BODY_PART ,
        MIDDLE_BODY_PART,
        LOWER_BODY_PART,
        MY_PLAN_PART
    }
    
    BODDY_PART_TAG = button.tag;
    ///at the my plan_button
    matchSelectStatus = BODDY_PART_TAG;

    switch (BODDY_PART_TAG) {
        case ALL_AREA_PART:
            [self clickAllVideosButton:nil];
            break;
        case UPPER_BODY_PART:
            [self clickUpperBodyButton:nil];
            break;
        case MIDDLE_BODY_PART:
            [self clickMiddleBodyButton:nil];
            break;
        case LOWER_BODY_PART:
            [self clickLowerBodyButton:nil];
            break;
        case MY_PLAN_PART:
            [self clickMyPlanButton:nil];
            break;
        default:
            break;
    }
    
}
- (void)clickUpperBodyButton:(id)sender
{
    VideoManager *manager =[VideoManager defaultManager];
    self.dataList =manager.videoList;
    NSMutableArray *upperBodyArray  =[[NSMutableArray alloc]init];
    [upperBodyArray addObjectsFromArray: [_dataList objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)]]];
    self.dataList =upperBodyArray;
    [upperBodyArray release];
    [self.tableView reloadData];
}
- (void)clickMiddleBodyButton:(id)sender {
    VideoManager *manager =[VideoManager defaultManager];
    self.dataList =manager.videoList;
    NSMutableArray *middleBodyArray =[[NSMutableArray alloc]init] ;
    [middleBodyArray addObjectsFromArray:[_dataList objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 5)]]];
    self.dataList =middleBodyArray;
    [middleBodyArray release];
    [self.tableView reloadData];
}
- (void)clickLowerBodyButton:(id)sender {
    VideoManager *manager =[VideoManager defaultManager];
    self.dataList =manager.videoList;
    NSMutableArray *lowerBoddyArray =[[NSMutableArray alloc]init];
    for (int i=10; i<=14; i++) {
        [lowerBoddyArray addObject:[_dataList objectAtIndex:i]];
    }
    self.dataList = lowerBoddyArray;
    [lowerBoddyArray release];
    [self.tableView reloadData];
}

- (void)clickAllVideosButton:(id)sender {
    
    VideoManager *manager =[VideoManager defaultManager];
    self.dataList =manager.videoList;
    [self.tableView reloadData];
}

- (void)clickMyPlanButton:(id)sender {
    
   [self reloadMyFollowList];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
