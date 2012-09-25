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
#import "ZJTGloble.h"
#import "ZJTHelpler.h"
#import "Status.h"

#import "OAuthWebView.h"
#import "MyselfCell.h"



@interface MyselfViewController ()

@end

@implementation MyselfViewController
@synthesize avatarImage;
@synthesize headerVImageV;
@synthesize user;
@synthesize userID;
@synthesize statuesArr;
@synthesize imageDictionary;
@synthesize myFooterView;
@synthesize myHeaderView;


-(void)dealloc{
    
    
    [super dealloc];
    
    [_headerVImageV release];
    [_footerVImageV release];
    [_avatarImage  release];
    [_user release];
    [_userID release];
    [statuesArr release];
    [imageDictionary release];
    [myHeaderView release];
    [myFooterView release];
}



-(void)setUp{
    
    weiBoMessageManager = [WeiBoMessageManager getInstance];
    defaultNotifCenter = [NSNotificationCenter defaultCenter];
    self.headerVImageV = [[UIImageView alloc] init];
}


   
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setUp];
    
    //如果未授权，则调入授权页面。
    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_ACCESS_TOKEN];
    NSLog([weiBoMessageManager isNeedToRefreshTheToken] == YES ? @"need to login":@"will login");
    if (authToken == nil || [weiBoMessageManager isNeedToRefreshTheToken])
    {
        shouldLoad = YES;
        OAuthWebView *webV = [[OAuthWebView alloc]initWithNibName:@"OAuthWebView" bundle:nil];
        webV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webV animated:NO];
        [webV release];
    }
    else
    {
        ///获取当前登陆用户的ID；
        [weiBoMessageManager getUserID];
//        [[SHKActivityIndicator currentIndicator] displayActivity:@"正在载入..." inView:self.view];
        [weiBoMessageManager getHomeLine:-1 maxID:-1 count:-1 page:-1 baseApp:-1 feature:-1];
        [[ZJTStatusBarAlertWindow getInstance] showWithString:@"正在载入，请稍后..."];
    }
    
    
    [defaultNotifCenter addObserver:self selector:@selector(didGetHomeLine:)      name:MMSinaGotHomeLine            object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(didGetUserInfo:)    name:MMSinaGotUserInfo          object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(didGetUserID:)      name:MMSinaGotUserID            object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(relogin)            name:NeedToReLogin              object:nil];
    
    
    
   /////////first
    [defaultNotifCenter addObserver:self selector:@selector(getAvatar:)         name:HHNetDataCacheNotification object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(mmRequestFailed:)   name:MMSinaRequestFailed object:nil];
    [defaultNotifCenter addObserver:self selector:@selector(loginSucceed)       name:DID_GET_TOKEN_IN_WEB_VIEW object:nil];
    
    
    
    if (avatarImage) {
        self.headerVImageV.image = avatarImage;
    }
    else {
        [[HHNetDataCacheManager getInstance] getDataWithURL:user.profileLargeImageUrl];
    }
    
    if (userID == nil) {
        userID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
    }
    if (!self.user) {
        self.user = [ZJTHelpler getInstance].user;
        NSLog(@"The user is %@",self.user);
    }

    
     
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    self.dataList = [NSArray arrayWithObjects:@"唐亮-Tom",@"性别",@"区域",@"个性签名", nil];
    

    UIView *headerView =[[UIView alloc]init];
    UIView *footerView =[[UIView alloc]init];
       
    [headerView setFrame: CGRectMake(0, 0, 100, 100)];
    [footerView setFrame: CGRectMake(0, 0, 100, 100)];

    self.myHeaderView = headerView;
    self.myFooterView = footerView;

    [headerView release];
    [footerView release];
    
    // set up the table's header view based on our UIView 'myHeaderView' outlet
	CGRect newFrame = CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, self.myHeaderView.frame.size.height);
    
	self.myHeaderView.backgroundColor = [UIColor clearColor];
	self.myHeaderView.frame = newFrame;
    
    
    
    ////在heade上添加头像图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touxiang_40x40@2x.png"]];
    [imageView setFrame:CGRectMake(20, 16, 60, 60)];
    [self.myHeaderView addSubview:imageView];
    [imageView release];
	[self.tableView setTableHeaderView: self.myHeaderView];
    // note this will override UITableView's 'sectionHeaderHeight' property
	
    
    
    
    
    
	// set up the table's footer view based on our UIView 'myFooterView' outlet
	newFrame = CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, self.myFooterView.frame.size.height);
	self.myFooterView.backgroundColor = [UIColor clearColor];
	self.myFooterView.frame = newFrame;
    
    ////在heade上添加头像图片
    self.footerVImageV = [[UIImageView alloc]initWithImage:avatarImage];
    [self.myFooterView   addSubview:_footerVImageV];

	self.tableView.tableFooterView = self.myFooterView;	// note this will override UITableView's 'sectionFooterHeight' property

}

-(void)viewDidUnload{

    [super viewDidUnload];
    self.headerVImageV = nil;
    ////first 
    [defaultNotifCenter removeObserver:self name:HHNetDataCacheNotification object:nil];
    [defaultNotifCenter removeObserver:self name:MMSinaRequestFailed        object:nil];
    [defaultNotifCenter removeObserver:self name:DID_GET_TOKEN_IN_WEB_VIEW  object:nil];
    
    
    ///later
    [defaultNotifCenter removeObserver:self name:MMSinaGotUserStatus        object:nil];
    [defaultNotifCenter removeObserver:self name:MMSinaGotUserID        object:nil];
    [defaultNotifCenter removeObserver:self name:MMSinaGotUserInfo        object:nil];
    [defaultNotifCenter removeObserver:self name:MMSinaGotHomeLine        object:nil];



}
#pragma mark - Methods


#pragma mark - Methods
-(void)loginSucceed
{
    shouldLoad = YES;
}
//异步加载图片
-(void)getImages
{
    //下载头像图片
    [[HHNetDataCacheManager getInstance] getDataWithURL:user.profileLargeImageUrl];
    
    //得到文字数据后，开始加载图片
    for(int i=0;i<[statuesArr count];i++)
    {
        Status * member=[statuesArr objectAtIndex:i];
        NSNumber *indexNumber = [NSNumber numberWithInt:i];
        
        //下载博文图片
        if (member.thumbnailPic && [member.thumbnailPic length] != 0)
        {
            [[HHNetDataCacheManager getInstance] getDataWithURL:member.thumbnailPic withIndex:i];
        }
        else
        {
            [imageDictionary setObject:[NSNull null] forKey:indexNumber];
        }
        
        //下载转发的图片
        if (member.retweetedStatus.thumbnailPic && [member.retweetedStatus.thumbnailPic length] != 0)
        {
            [[HHNetDataCacheManager getInstance] getDataWithURL:member.retweetedStatus.thumbnailPic withIndex:i];
        }
        else
        {
            [imageDictionary setObject:[NSNull null] forKey:indexNumber];
        }
    }
}

//得到图片
-(void)getAvatar:(NSNotification*)sender
{
    NSDictionary * dic = sender.object;
    NSString * url          = [dic objectForKey:HHNetDataCacheURLKey];
    NSNumber *indexNumber   = [dic objectForKey:HHNetDataCacheIndex];
    NSInteger index = [indexNumber intValue];
    
    if([url isEqualToString:self.user.profileLargeImageUrl])
    {
        UIImage * image     = [UIImage imageWithData:[dic objectForKey:HHNetDataCacheData]];
        self.avatarImage = image;
        
        
        UIImageView *imageView = [[UIImageView alloc]init];
        self.headerVImageV = imageView;
        
        
        self.headerVImageV.image = image;
        [self.headerVImageV setFrame:CGRectMake(20, 16, 60, 60)];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        [view addSubview:self.headerVImageV];
        [self.tableView setTableHeaderView:view];
        [view release];
        
        [self.tableView reloadData];

        
    }
    
    
    
    //当下载大图过程中，后退，又返回，如果此时收到大图的返回数据，会引起crash，在此做预防。
    if (indexNumber == nil) {
        NSLog(@"indexNumber = nil");
        return;
    }
    
    if (index >= [statuesArr count]) {
     NSLog(@"statues arr error ,index = %d,count = %d",index,[statuesArr count]);
        return;
    }
    
    Status *sts = [statuesArr objectAtIndex:index];
    
    //得到的是博文图片
    if([url isEqualToString:sts.thumbnailPic])
    {
        [imageDictionary setObject:[dic objectForKey:HHNetDataCacheData] forKey:indexNumber];
    }
    
    //得到的是转发的图片
    if (sts.retweetedStatus && ![sts.retweetedStatus isEqual:[NSNull null]])
    {
        if ([url isEqualToString:sts.retweetedStatus.thumbnailPic])
        {
            [imageDictionary setObject:[dic objectForKey:HHNetDataCacheData] forKey:indexNumber];
        }
    }
    
    //reload table
//    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index inSection:0];
//    NSArray     *arr        = [NSArray arrayWithObject:indexPath];
//    [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:NO];
}

-(void)didGetUserID:(NSNotification*)sender
{
    self.userID = sender.object;
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:USER_STORE_USER_ID];
    [weiBoMessageManager getUserInfoWithUserID:[userID longLongValue]];
}

-(void)didGetUserInfo:(NSNotification*)sender
{
    User *aUser = sender.object;
    if (self.title != @"我的微博") {
        self.title = aUser.screenName;
    }
    [ZJTHelpler getInstance].user = aUser;
    self.user =[ZJTHelpler getInstance].user;
    [[NSUserDefaults standardUserDefaults] setObject:user.screenName forKey:USER_STORE_USER_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}
-(void)didGetHomeLine:(NSNotification*)sender
{
    if ([sender.object count] == 1) {
        NSDictionary *dic = [sender.object objectAtIndex:0];
        NSString *error = [dic objectForKey:@"error"];
        if (error && ![error isEqual:[NSNull null]]) {
            if ([error isEqualToString:@"expired_token"])
            {
                //[[SHKActivityIndicator currentIndicator] hide];
                [[ZJTStatusBarAlertWindow getInstance] hide];
                shouldLoad = YES;
                OAuthWebView *webV = [[OAuthWebView alloc]initWithNibName:@"OAuthWebView" bundle:nil];
                webV.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webV animated:NO];
                [webV release];
            }
            return;
        }
    }
    
//    [self stopLoading];
    [self doneLoadingTableViewData];
    
    [statuesArr removeAllObjects];
    self.statuesArr = sender.object;
    [self.tableView reloadData];
    
    //    [[SHKActivityIndicator currentIndicator] hide];
    [[ZJTStatusBarAlertWindow getInstance] hide];
    
//    [headDictionary  removeAllObjects];
    [imageDictionary removeAllObjects];
    
    [self getImages];
//    
//    if (timer == nil) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(timerOnActive) userInfo:nil repeats:YES];
//    }
}




-(void)mmRequestFailed:(id)sender
{
//    [self stopLoading];
    //    [[SHKActivityIndicator currentIndicator] hide];
    [[ZJTStatusBarAlertWindow getInstance] hide];
}


#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    switch (section) {
        case 0:
            NSLog(@"This is Section one");
            return 1;
            break;
        case 1:
            NSLog(@"This is Section two");
            return 2;
            break;
        case 2:
            NSLog(@"This is Section three");
            return 3;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *CellIdentifier = [MyselfCell getCellIdentifier];

   MyselfCell *cell = (MyselfCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell) {
        cell = [[[MyselfCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.textLabel.textColor=[UIColor colorWithRed:0x46/255.0 green:0x46/255.0 blue:0x46/255.0 alpha:1.0];
        
        UIImage* image = [UIImage imageNamed:@"szicon_a.png"];
        UIImageView* cellAccessoryView = [[UIImageView alloc] initWithImage:image];
        cell.accessoryView = cellAccessoryView;
        [cellAccessoryView release];
        
        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0x2F/255.0 green:0x76/255.0 blue:0xB9/255.0 alpha:1.0];

    }
    
      cell.delegate = self;
      cell.indexPath = indexPath;
    
    switch ([indexPath row]) {
        case 0:
            cell.imageView.image =nil;
            cell.textLabel.text =[_dataList objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.textLabel.text =[_dataList objectAtIndex:indexPath.row];
            cell.imageView.image =[UIImage imageNamed:@"artist-tab.png"];
            break;
        case 2:
            cell.textLabel.text = [_dataList objectAtIndex:indexPath.row];
            cell.imageView.image =[UIImage imageNamed:@"music-tab.png"];
            break;
        case 3:
            cell.textLabel.text = @"asdfsadf";
            break;
        case 4:
            cell.textLabel.text = @"asdfsad";
            break;
        case 5:
            cell.textLabel.text = @"sadfs";
            break;
        case 6:
            cell.textLabel.text = @"sdfs";
            break;
        default:
            break;
    }
    
    
    [cell  setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    NSLog(@"i did selected row %d",indexPath.row);

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
