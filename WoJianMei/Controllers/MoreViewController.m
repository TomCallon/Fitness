//
//  MoreViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/14/12.
//
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import <Social/Social.h>
#import "OAuthWebView.h"
#import "SettingsViewController.h"
#import "FitnssPlanViewController.h"



enum actionsheetNumber{
    LANGUAGE_SELECTION,
    RECOMMENDATION,
};


typedef enum {
    ASK_FRIENDS_TO_GO_TO_WORKOUT = 0,
    Find_A_COACH,
    SCORE_NOTICE_SETTING,
    WORKOUT_PLANS,
    FEEDBACK,
    RECOMMEND,
    ABOUT,
    UPDATE
} MORE_SELECTION;


@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize listData =_listData;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.    
    [self optionListInit];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    
    UIViewController *nv =[self.navigationController topViewController];
    [nv.navigationItem setTitle:@"更多"];

    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(clickSettingsButton:)];
    [nv.navigationItem setLeftBarButtonItem:nil];
    [nv.navigationItem setRightBarButtonItem:rightBarButton];
    [nv.navigationController.navigationBar.backItem setBackBarButtonItem:rightBarButton];
}


-(void)clickSettingsButton:(id)sender{
    
    SettingsViewController *settingVC = [[SettingsViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
    [settingVC release];
}

-(void)dealloc{

    [super dealloc];
    [_listData release];
    
}


- (void)optionListInit
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"预约好友", @"预约教练", @"健身计划", @"关注我们", @"信息反馈", @"推荐给好友", @"关于中华健美", @"客户端更新",  nil];
    self.listData = array;
    [array release];
}


#pragma mark -
#pragma mark delegates



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreViewController"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreViewController"] autorelease];
        cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.textLabel.textColor=[UIColor colorWithRed:0x46/255.0 green:0x46/255.0 blue:0x46/255.0 alpha:1.0];
        
        UIImage* image = [UIImage imageNamed:@"szicon_a.png"];
        UIImageView* cellAccessoryView = [[UIImageView alloc] initWithImage:image];
        cell.accessoryView = cellAccessoryView;
        [cellAccessoryView release];
        
        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0x2F/255.0 green:0x76/255.0 blue:0xB9/255.0 alpha:1.0];
        
        
    }
    
    UIImage *image = nil;
    switch ([indexPath row]) {
        case ASK_FRIENDS_TO_GO_TO_WORKOUT:
            image = [UIImage imageNamed:@"szicon1.png"];
            break;
        case Find_A_COACH:
            image = [UIImage imageNamed:@"szicon2.png"];
            break;
        case WORKOUT_PLANS :
            image = [UIImage imageNamed:@"szicon3.png"];
            break;
        case SCORE_NOTICE_SETTING:
            image = [UIImage imageNamed:@"szicon4.png"];
            break;
        case FEEDBACK:
            image = [UIImage imageNamed:@"szicon5.png"];
            break;
        case RECOMMEND:
            image = [UIImage imageNamed:@"szicon6.png"];
            break;
        case ABOUT:
            image = [UIImage imageNamed:@"szicon7.png"];
            break;
        case UPDATE:
            image = [UIImage imageNamed:@"szicon8.png"];
            break;
        default:
            break;
    }
    
    cell.imageView.image = image;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    
    //set backgroudView
    UIImageView *imageView = nil;
    
    if (0 == [indexPath row] )
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"helptable_top.png"]];
    else if (8 == [indexPath row])
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"helptable_bottom.png"]];
    else
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"helptable_middle.png"]];
    
    cell.backgroundView=imageView;
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    
    [imageView release];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    switch (row) {
        case ASK_FRIENDS_TO_GO_TO_WORKOUT:
        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要更换账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更换", nil];
//            [alert show];
//            [alert release];
            
            [self askFriendsToGoToWorkout];
            
        }
            break;
        case Find_A_COACH:
            [self findACoach];
            break;
        case  WORKOUT_PLANS :
            [self showWorkoutPlans];
            break;
        case SCORE_NOTICE_SETTING:
            //            [self showScoreAlert];
            break;
        case FEEDBACK:
           [self showFeedback];
            break;
        case RECOMMEND:
            [self showRecommendation];
            break;
        case ABOUT:
            [self showAboutView];
            break;
        case UPDATE:
           [self updateApplication];
            break;
        default:
            break;
    }
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)askFriendsToGoToWorkout{
    
}

-(void)findACoach{
    NSLog(@"find a coach");
    [self performSegueWithIdentifier:@"CoachSegue" sender:self];
}

-(void)showFeedback{
    
    [self performSegueWithIdentifier:@"FeedbackSegue" sender:self];
    
}

-(void)showWorkoutPlans{
    
    
    FitnssPlanViewController *fVC =[[FitnssPlanViewController alloc]init];
    [self.navigationController pushViewController:fVC animated:YES];
    [fVC release];
    
    
}

- (void)showRecommendation
{
    whichAcctionSheet = RECOMMENDATION;
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:@"请选择推荐方式"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"短信"
                                              otherButtonTitles:@"邮件", nil];
    [share showFromTabBar:self.tabBarController.tabBar];
    [share release];
}


-(void)showAboutView{
    
    [self performSegueWithIdentifier:@"AboutViewControllerSegue" sender:self];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (LANGUAGE_SELECTION == whichAcctionSheet)
    {
        if (buttonIndex == actionSheet.cancelButtonIndex){
            return;
        }
        
//        [LanguageManager setLanguage:buttonIndex];
//        [((FootballScoreAppDelegate *)[UIApplication sharedApplication].delegate) setSeletedTabbarIndex:TAB_REALTIME_SCORE];
//        [self popupHappyMessage:FNS(@"请刷新查看") title:nil];
    }
    else if (RECOMMENDATION == whichAcctionSheet)
    {
        NSString *bodyStringBegin = @"朋友，我正在使用中华健美客户端，学习如何健身，分享，很方便很好用，下载地址是";
        NSString *bodyStringWebsite = @"http://www.zhonghuafitness.com";
        
        NSString *bodyString = [NSString stringWithFormat:@"%@%@", bodyStringBegin, bodyStringWebsite];
        
        
        if (buttonIndex == actionSheet.cancelButtonIndex){
            return;
        }
        else if (buttonIndex == 0)
        {
           [self sendSms:nil body:bodyString];
        }
        else if (buttonIndex == 1)
        {
            [self sendEmailTo:nil
                 ccRecipients:nil
                bccRecipients:nil
                      subject:@"向你推荐中华健美的客户端"
                         body:bodyString
                       isHTML:NO
                     delegate:self];
        }
    }
}



-(void)updateApplication{

    [self popupHappyMessage:@"已经是最新版本" title:nil];


}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)sinaWeiBlogshareButton:(id)sender {
    
    
    
    // 首先判断服务器是否可以访问
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
//        NSLog(@"Available server of sinaWeiBlog");
//        
//        // 使用SLServiceTypeSinaWeibo来创建一个新浪微博view Controller
//        SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//        
//        // 写一个bolck，用于completionHandler的初始化
//        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
//            if (result == SLComposeViewControllerResultCancelled) {
//                NSLog(@"cancelled\\");
//            } else
//            {
//                NSLog(@"done\\");
//            }
//            [socialVC dismissViewControllerAnimated:YES completion:Nil];
//        };
//        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
//        socialVC.completionHandler = myBlock;
//        
//        // 给view controller初始化默认的图片，url，文字信息
//        UIImage *image = [UIImage imageNamed:@"b_menu_1s.png"];
//        
//        
//        NSURL *url = [NSURL URLWithString:@"www.google.com"];
//        
//        [socialVC setInitialText:@"www.google.com.hk"];
//        [socialVC addImage:image];
//        [socialVC addURL:url];
//        
//        // 以模态的方式展现view controller
//        [self  presentViewController:socialVC animated:YES completion:Nil];
//        
//    } else {
//        NSLog(@"UnAvailable\\");
   }


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
    }
}



@end
