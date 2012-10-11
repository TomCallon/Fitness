//
//  SecondViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "OAuthWebView.h"




@implementation SettingViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
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


- (IBAction)sendMessageToRestaurant:(id)sender {
    
   if( [MFMessageComposeViewController canSendText] )
        {
            MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init]; //autorelease];
            controller.recipients = [NSArray arrayWithObjects:@"13427508899",@"", nil];
            controller.body = @"你好我在使用《中华健美手机客户端》，现在我刚刚健身完毕，使用手机预订点餐。(9qzkd27953ma)";
            controller.messageComposeDelegate = self;
            
            [self presentModalViewController:controller animated:YES];
            [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"SomethingElse"];//修改短信界面标题
            [controller release];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" 
                                                            message:@"该设备不支持短信功能" 
                                                           delegate:self 
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
            [alert release];
        }
}


#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    
    switch (result) {
    case MessageComposeResultCancelled:
    {
        //click cancel button
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消订餐" 
                                                        message:@"你好，你现在已经取消了订餐服务" 
                                                       delegate:self 
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];

    }
        break;
    case MessageComposeResultFailed:// send failed
        {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送失败" 
                                                            message:@"你好，你的信息发送失败" 
                                                           delegate:self 
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];

        }
        break;
    case MessageComposeResultSent:
    {
        
        //do something
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功订餐" 
                                                        message:@"你好，你现在成功订餐成功" 
                                                       delegate:self 
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];

    }
        break;
    default:
        break;
}
}



- (IBAction)callTheRestaurant:(id)sender {
    
    NSString *numberAfterClear = @"13427508899";
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", numberAfterClear]];
    NSLog(@"make call, URL=%@", phoneNumberURL);
    
    [[UIApplication sharedApplication] openURL:phoneNumberURL];   
    
    
}

- (IBAction)loginWithSinaWeiBlog:(id)sender {
    
    OAuthWebView *webV = [[OAuthWebView alloc]initWithNibName:@"OAuthWebView" bundle:nil];
    webV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webV animated:YES];
    [webV release];
    NSLog(@"login With Sina Wei BLOG");
    
}
@end
