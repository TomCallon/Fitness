//
//  SecondViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "OAuthWebView.h"


@interface SettingsViewController ()
@property (nonatomic, retain) UISwitch *airplaneModeSwitch;
@end


@implementation SettingsViewController
@synthesize airplaneModeSwitch = _airplaneModeSwitch;



- (id) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) return nil;
    
	self.title = NSLocalizedString(@"Settings", @"Settings");
    
	return self;
}

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
    self.title = NSLocalizedString(@"Settings", @"Settings");
    
    self.airplaneModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    ////////add a section now 
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex)
     
     {
         //// add a row at the section one 
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             staticContentCell.reuseIdentifier = @"UIControlCell";
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             
             cell.textLabel.text = NSLocalizedString(@"Airplane Mode", @"Airplane Mode");
             cell.imageView.image = [UIImage imageNamed:@"AirplaneMode"];
             cell.accessoryView = self.airplaneModeSwitch;
         }whenSelected:^(NSIndexPath *indexPath){
         ///TODO
             //    [self.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];

         
         }];
         
         //// add a row at the section one
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             staticContentCell.cellStyle = UITableViewCellStyleValue1;
             staticContentCell.reuseIdentifier = @"DetailTextCell";
             
             cell.textLabel.text = NSLocalizedString(@"Wi-Fi", @"Wi-Fi");
             cell.detailTextLabel.text = NSLocalizedString(@"iamtheinternet", @"iamtheinternet");
         } whenSelected:^(NSIndexPath *indexPath) {
//             [self.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];
         }];
         
         //// add a row at the section one
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             cell.textLabel.text = NSLocalizedString(@"Notifications", @"Notifications");
             cell.imageView.image = [UIImage imageNamed:@"Notifications"];
         } whenSelected:^(NSIndexPath *indexPath) {
//             [self.navigationController pushViewController:[[NotificationsViewController alloc] init] animated:YES];
         }];
         
         //// add a row at the section one
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             staticContentCell.cellStyle = UITableViewCellStyleValue1;
             staticContentCell.reuseIdentifier = @"DetailTextCell";
             
             cell.textLabel.text = NSLocalizedString(@"Location Services", @"Location Services");
             cell.detailTextLabel.text = NSLocalizedString(@"On", @"On");
         } whenSelected:^(NSIndexPath *indexPath) {
             //TODO			
         }];
     }];
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Sounds", @"Sounds");
			cell.imageView.image = [UIImage imageNamed:@"Sounds"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Brightness", @"Brightness");
			cell.imageView.image = [UIImage imageNamed:@"Brightness"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Wallpaper", @"Wallpaper");
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
	}];
	
	[self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = NSLocalizedString(@"General", @"General");
			cell.imageView.image = [UIImage imageNamed:@"General"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"iCloud", @"iCloud");
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Mail, Contacts, Calendars", @"Mail, Contacts, Calendars");
			cell.imageView.image = [UIImage imageNamed:@"Mail"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Twitter", @"Twitter");
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Phone", @"Phone");
			cell.imageView.image = [UIImage imageNamed:@"Phone"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"FaceTime", @"FaceTime");
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Safari", @"Safari");
			cell.imageView.image = [UIImage imageNamed:@"Safari"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Messages", @"Messages");
			cell.imageView.image = [UIImage imageNamed:@"Messages"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Music", @"Music");
			cell.imageView.image = [UIImage imageNamed:@"Music"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Video", @"Video");
			cell.imageView.image = [UIImage imageNamed:@"Video"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Photos", @"Photos");
			cell.imageView.image = [UIImage imageNamed:@"Photos"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Notes", @"Notes");
			cell.imageView.image = [UIImage imageNamed:@"Notes"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Store", @"Store");
			cell.imageView.image = [UIImage imageNamed:@"AppStore"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO			
		}];
	}];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.airplaneModeSwitch = nil;
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
