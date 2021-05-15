//
//  AboutUsVC.m
//  Whats Tracker
//
//  Created by Vivek Warde on 08/07/18.
//  Copyright © 2018 Vivek Warde. All rights reserved.
//

#import "AboutUsVC.h"
#define YOUR_APP_STORE_ID 1410790509

@interface AboutUsVC ()
@end

@implementation AboutUsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /////startAppAd = [[STAStartAppAd alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:keyCheckInApp])
    {
        if (bannerView == nil)
        {
            bannerView = [[STABannerView alloc] initWithSize:STA_MRecAdSize_300x250 autoOrigin:STAAdOrigin_Bottom
                                                    withView:self.view withDelegate:nil];
            [self.view addSubview:bannerView];
        }
    }
    else
    {
        if(bannerView)
        {
            [bannerView removeFromSuperview];
            bannerView=nil;
        }
    }
}

- (IBAction)btnReportProblemClicked:(UIButton *)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;        // Required to invoke mailComposeController when send
        
        [mailCont setSubject:@"Whats Tracker Problem"];
        [mailCont setToRecipients:[NSArray arrayWithObject:@"vivekwarde@icloud.com"]];
        [mailCont setMessageBody:@"Type here..." isHTML:NO];
        
        [self presentViewController:mailCont animated:YES completion:nil];
    }
    
    
}

- (IBAction)btnSayThanksClicked:(UIButton *)sender
{
    static NSString *const iOSAppStoreURLFormat = @"https://itunes.apple.com/us/app/whats-tracker/id1410790509?ls=1&mt=8";
    
    NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:iOSAppStoreURLFormat, YOUR_APP_STORE_ID]];
    
    if ([[UIApplication sharedApplication] canOpenURL:appStoreURL])
    {
        [[UIApplication sharedApplication] openURL:appStoreURL];
    }
}

// Then implement the delegate method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
