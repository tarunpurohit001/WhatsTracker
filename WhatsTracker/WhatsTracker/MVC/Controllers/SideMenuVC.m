//
//  SideMenuVC.m
//  Whats Tracker
//
//  Created by Vivek Warde on 08/07/18.
//  Copyright © 2018 Vivek Warde. All rights reserved.
//

#import "SideMenuVC.h"
#import "HowItWorksVC.h"
#import "AboutUsVC.h"
#import "GetPremiumVC.h"

///#define YOUR_APP_STORE_ID 545174222
#define YOUR_APP_STORE_ID 1410790509

@interface SideMenuVC ()
{
}
@end

@implementation SideMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnHowitWorksClicked:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HowItWorksVC *objHowItWorksVC = [storyboard instantiateViewControllerWithIdentifier:@"HowItWorksVC"];
    [self.navigationController pushViewController:objHowItWorksVC animated:YES];
}

- (IBAction)btnGetPremiumClicked:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GetPremiumVC *objGetPremiumVC = [storyboard instantiateViewControllerWithIdentifier:@"GetPremiumVC"];
    [self.navigationController pushViewController:objGetPremiumVC animated:YES];
    
}
- (IBAction)btnShareClicked:(UIButton *)sender {
    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}
- (IBAction)btnRateTheApp:(UIButton *)sender {
    static NSString *const iOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d";
    
    NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:iOSAppStoreURLFormat, YOUR_APP_STORE_ID]];
    
    if ([[UIApplication sharedApplication] canOpenURL:appStoreURL]) {
        [[UIApplication sharedApplication] openURL:appStoreURL];
    }
    
}


- (IBAction)btnAboutUsClicked:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutUsVC *objAboutUsVC = [storyboard instantiateViewControllerWithIdentifier:@"AboutUsVC"];
    [self.navigationController pushViewController:objAboutUsVC animated:YES];
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
