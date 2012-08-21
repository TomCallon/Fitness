//
//  MoreViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/14/12.
//
//

#import "MoreViewController.h"
#import <Social/Social.h>


@interface MoreViewController ()

@end

@implementation MoreViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

@end
