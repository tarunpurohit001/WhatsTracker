//
//  MainVC.m
//  Whats Tracker
//
//  Created by Vivek Warde on 08/07/18.
//  Copyright © 2018 Vivek Warde. All rights reserved.
//

#import "MainVC.h"
#import "HowItWorksVC.h"
#import "AboutUsVC.h"
#import "GetPremiumVC.h"
#import "NSData+Base64.h"

#import "IAPHelper.h"
#import "WhoViewedAPHelper.h"

#define YOUR_APP_STORE_ID 1410790509

#define ServerURL @"https://webtechdesk.com/ios/"

@interface MainVC () 
{
    BOOL show;
    IBOutlet UIView *menuView;
}

@end

@implementation MainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Loading...";
    hud.margin = 10.f;
    // hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:5];
    
    [self callWebURL];
    
    //set side menu beside
    menuView.transform = CGAffineTransformMakeTranslation(- menuView.frame.size.width-1500, 0);
    show=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseSuccessed:) name:IAPHelperProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseFailed:) name:IAPHelperProductPurchaseFailedNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restoreSuccessedAllCompleted:) name:IAPHelperProductPurchaseRestoredAllCompletedNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restoreSuccessed:) name:IAPHelperProductPurchaseRestoredNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restoreFailed:) name:IAPHelperProductPurchaseRestoreFailedNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self checkNET];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:keyCheckInApp])
    {
        if (bannerView == nil)
        {
            int bottomSpace; //= 50;
            if (IsIPad)
            {
                bottomSpace = 90;
            }
            else
            {
                bottomSpace = 50;
            }
            
            bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize
                                                      origin:CGPointMake(0, self.view.frame.size.height-bottomSpace)
                                                    withView:self.view
                                                withDelegate:nil];
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

#pragma mark - whatsapp Settings

-(void)callWebURL
{
    /*
     NSString *urlNameInString = @"https://web.whatsapp.com";
     NSURL *url = [NSURL URLWithString:urlNameInString];
     NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
     [webView loadRequest:urlRequest];
     */
    CGRect frame =  CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-100);
    
    webViewNEW = [[WKWebView alloc] initWithFrame:frame];
    webViewNEW.customUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17";
    [viewWeb addSubview:webViewNEW];
    
    webViewNEW.navigationDelegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://web.whatsapp.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webViewNEW loadRequest:urlRequest];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark -  Other Button Click Actions


- (IBAction)btnSideMenuClicked:(UIButton *)sender
{
    float x=0,y=0;
    if(show)
    {
        x = 0;
        show = NO;
    }
    else
    {
        x = - menuView.frame.size.width;
        
        show = YES;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self->menuView.transform = CGAffineTransformMakeTranslation(x, y);
    }];
}

- (IBAction)backButtonClicked:(id)sender
{
    float x=0,y=0;
    if(show)
    {
        x = 0;
        show = NO;
    }
    else
    {
        x = - menuView.frame.size.width;
        
        show = YES;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self->menuView.transform = CGAffineTransformMakeTranslation(x, y);
    }];
}

- (IBAction)btnRefreshClicked:(UIButton *)sender
{
    [self checkNET];
    [self callWebURL];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Loading...";
    hud.margin = 10.f;
    // hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:5];
}


#pragma mark - Side Menu Button Click Actions


- (IBAction)btnHowitWorksClicked:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HowItWorksVC *objHowItWorksVC = [storyboard instantiateViewControllerWithIdentifier:@"HowItWorksVC"];
    [self.navigationController pushViewController:objHowItWorksVC animated:YES];
}


- (IBAction)btnShareClicked:(UIButton *)sender
{
    NSString *textToShare = @"Look at this awesome app Whats Tracker !";
    NSURL *myWebsite = [NSURL URLWithString:@"https://itunes.apple.com/us/app/whats-tracker/id1410790509?ls=1&mt=8"];
    
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
- (IBAction)btnRateTheApp:(UIButton *)sender
{
    static NSString *const iOSAppStoreURLFormat = @"https://itunes.apple.com/app/whats-tracker/id1410790509?ls=1&mt=8";
    
    NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:iOSAppStoreURLFormat, YOUR_APP_STORE_ID]];
    if ([[UIApplication sharedApplication] canOpenURL:appStoreURL]) {
        [[UIApplication sharedApplication] openURL:appStoreURL];
    }
}


- (IBAction)btnAboutUsClicked:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutUsVC *objAboutUsVC = [storyboard instantiateViewControllerWithIdentifier:@"AboutUsVC"];
    [self.navigationController pushViewController:objAboutUsVC animated:YES];
}


#pragma mark - Other Supportive Methods


-(void)showSuccessAlert
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Success"
                                 message:@"Ads Removed"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)checkNET
{
    if (![self connected])
    {
        // Not connected
        [self showNetErroAlert];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } else {
        // Connected. Do some Internet stuff
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
}


- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

-(void)showNetErroAlert
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:@"Check Internet Connection"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
    {
                                    //Handle your yes please button action here
                                }];
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - InApp purchase feature

-(IBAction)btnRemoveAdsPurchaseClicked:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WhoViewedAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products)
    {
        if (success)
        {
            // //Nslog(@"%@", products);
            if (products.count > 0)
            {
                for (SKProduct *p in products)
                {
                    if ([p.productIdentifier isEqualToString:kRemoveAdsProductIdentifier])
                    {
                        [[WhoViewedAPHelper sharedInstance] buyProduct:p];
                        
                    }
                }
            }
            else
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
            
        }
    }];
}

-(IBAction)btnRestoreClicked:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WhoViewedAPHelper sharedInstance] restoreCompletedTransactions];
}

#pragma mark - InApp Notificatio handler

- (void)purchaseSuccessed:(NSNotification *)notification
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:keyCheckInApp];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self->bannerView)
        {
            [self->bannerView removeFromSuperview];
            self->bannerView=nil;
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:keyCheckInApp];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Success"
                                 message:@"Remove Ads Purchase Successfully."
                                 preferredStyle:UIAlertControllerStyleAlert];
    //Add Buttons
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handle your yes please button action here
                                }];
    //Add your buttons to alert controller
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)purchaseFailed:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    });
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:@"Purchase failed."
                                 preferredStyle:UIAlertControllerStyleAlert];
    //Add Buttons
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handle your yes please button action here
                                }];
    //Add your buttons to alert controller
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)restoreSuccessedAllCompleted:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });

    if(notification.object)
    {
        SKPaymentQueue *objQueue=notification.object;
        NSArray *arrList=(NSArray*)objQueue.transactions;
        if(arrList.count)
        {
            BOOL isDone=NO;
            for (SKPaymentTransaction *objtra in arrList)
            {
                SKPayment *objPayment=objtra.payment;
                NSString *strI=objPayment.productIdentifier;
                if(strI && [strI isEqualToString:kRemoveAdsProductIdentifier])
                {
                    isDone=YES;
                }
            }
            
            if(isDone)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if(self->bannerView)
                    {
                        [self->bannerView removeFromSuperview];
                        self->bannerView=nil;
                    }
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:keyCheckInApp];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                });
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Success"
                                             message:@"Restore Successfully."
                                             preferredStyle:UIAlertControllerStyleAlert];
                //Add Buttons
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action)
                                            {
                                                //Handle your yes please button action here
                                            }];
                //Add your buttons to alert controller
                [alert addAction:yesButton];
                [self presentViewController:alert animated:YES completion:nil];
                //NSLog(@"restorea all %@",notification.object);
                return;
            }
        }
    }
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:@"You have not purchase to restore."
                                 preferredStyle:UIAlertControllerStyleAlert];
    //Add Buttons
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handle your yes please button action here
                                }];
    //Add your buttons to alert controller
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
    
    //NSLog(@"restorea all %@",notification.object);
}

- (void)restoreSuccessed:(NSNotification *)notification
{
    //NSLog(@"restore one by one%@",notification.object);
}

- (void)restoreFailed:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:@"Restore failed."
                                 preferredStyle:UIAlertControllerStyleAlert];
    //Add Buttons
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handle your yes please button action here
                                }];
    //Add your buttons to alert controller
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
