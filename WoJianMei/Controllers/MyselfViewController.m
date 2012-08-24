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
    
    [_headerVImageV release];
    [avatarImage  release];
    [user release];
    [userID release];
    [statuesArr release];
    [imageDictionary release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];

     weiBoMessageManager = [WeiBoMessageManager getInstance];
     shouldLoad = NO;
     imageDictionary = [[NSMutableDictionary alloc] initWithCapacity:100];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAvatar:)         name:HHNetDataCacheNotification object:nil];
    
        
    if (avatarImage) {
        self.headerVImageV.image = avatarImage;
    }
    else {
        [[HHNetDataCacheManager getInstance] getDataWithURL:user.profileLargeImageUrl];
    }
    
    if (userID == nil) {
        userID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
    }
    
    if (!user) {
        self.user = [ZJTHelpler getInstance].user;
        NSLog(@"The user :%@",[[[ZJTHelpler getInstance] user]  description]);
    }
    
    if (![self.title isEqualToString:@"我的微博"]) {
        self.title = user.screenName;
    }
    
    [weiBoMessageManager getUserStatusUserID:userID sinceID:-1 maxID:-1 count:-1 page:-1 baseApp:-1 feature:-1];
    [[ZJTStatusBarAlertWindow getInstance] showWithString:@"正在载入，请稍后..."];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed)       name:DID_GET_TOKEN_IN_WEB_VIEW object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relogin)            name:NeedToReLogin              object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetHomeLine:)    name:MMSinaGotUserStatus        object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mmRequestFailed:)   name:MMSinaRequestFailed object:nil];
    [self.tableView reloadData];
}

-(void)viewDidUnload{

    [super viewDidUnload];
    
    self.headerVImageV = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HHNetDataCacheNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MMSinaRequestFailed        object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DID_GET_TOKEN_IN_WEB_VIEW  object:nil];    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MMSinaGotUserStatus        object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NeedToReLogin              object:nil];

    
}


#pragma mark - Methods

-(void)getImages
{
    //下载头像图片
    [[HHNetDataCacheManager getInstance] getDataWithURL:user.profileLargeImageUrl];
    NSLog(@"tell me about the user %@",[user description]);
    
    [self.tableView reloadData];

}

//得到图片
-(void)getAvatar:(NSNotification*)sender
 {
    
   NSDictionary * dic = sender.object;
   NSString * url          = [dic objectForKey:HHNetDataCacheURLKey];
    NSNumber *indexNumber   = [dic objectForKey:HHNetDataCacheIndex];
    NSInteger index = [indexNumber intValue];
     
    if([url isEqualToString:user.profileLargeImageUrl])
    {
        UIImage * image     = [UIImage imageWithData:[dic objectForKey:HHNetDataCacheData]];
        self.avatarImage = image;
        self.headerVImageV.image = image;
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
     
     [self.tableView reloadData];
}

-(void)relogin
{
    shouldLoad = YES;
    OAuthWebView *webV = [[OAuthWebView alloc]initWithNibName:@"OAuthWebView" bundle:nil];
    webV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webV animated:NO];
    [webV release];
}


-(void)didGetUserID:(NSNotification*)sender
{
    self.userID = sender.object;
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:USER_STORE_USER_ID];
    [weiBoMessageManager getUserInfoWithUserID:[userID longLongValue]];
}

-(void)mmRequestFailed:(id)sender
{
    [[ZJTStatusBarAlertWindow getInstance] hide];
}


-(void)didGetHomeLine:(NSNotification*)sender
{
    if ([sender.object count] == 1) {
        NSDictionary *dic = [sender.object objectAtIndex:0];
        NSString *error = [dic objectForKey:@"error"];
        if (error && ![error isEqual:[NSNull null]]) {
            if ([error isEqualToString:@"expired_token"])
            {
                [[ZJTStatusBarAlertWindow getInstance] hide];
                shouldLoad = YES;
                OAuthWebView *webV = [[OAuthWebView alloc]initWithNibName:@"OAuthWebView" bundle:nil];
                webV.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webV animated:YES];
                [webV release];
            }
            return;
        }
    }
    
    shouldLoadAvatar = YES;
    self.statuesArr = sender.object;
    [[ZJTStatusBarAlertWindow getInstance] hide];
    
    [imageDictionary removeAllObjects];
    [self getImages];
}


-(void)loginSucceed
{
    shouldLoad = YES;
}


-(void)refresh
{
    [weiBoMessageManager getUserStatusUserID:userID sinceID:-1 maxID:-1 count:-1 page:-1 baseApp:-1 feature:-1];
    [[ZJTStatusBarAlertWindow getInstance] showWithString:@"正在载入，请稍后..."];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    if (shouldLoad)
    {
        shouldLoad = NO;
        [weiBoMessageManager getUserStatusUserID:userID sinceID:-1 maxID:-1 count:-1 page:-1 baseApp:-1 feature:-1];
        [[ZJTStatusBarAlertWindow getInstance] showWithString:@"正在载入，请稍后..."];
    }
}



#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 28;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *CellIdentifier = [MyselfCell getCellIdentifier];

   MyselfCell *cell = (MyselfCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell) {
        cell = [[[MyselfCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
      cell.delegate = self;
      cell.indexPath = indexPath;
    
    switch ([indexPath row]) {
        case 0:
        
            
        cell.imageView.image =self.avatarImage;
            NSLog(@"%@the miamg",[self.avatarImage description]);
        cell.textLabel.text = self.user.screenName;
            break;
        case 1:
            cell.textLabel.text = @"adfsa";
            break;
        case 2:
            cell.textLabel.text = @"asdfsadfsa";
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
    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
