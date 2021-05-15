//
//  MainVC.h
//  Whats Tracker
//
//  Created by Vivek Warde on 08/07/18.
//  Copyright © 2018 Vivek Warde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <StoreKit/StoreKit.h>

@interface MainVC : UIViewController <WKNavigationDelegate, STADelegateProtocol, STABannerDelegateProtocol>
{
    IBOutlet UIView *viewWeb;
    IBOutlet WKWebView *webViewNEW;
    STABannerView *bannerView;
}

- (BOOL)connected;

@end

