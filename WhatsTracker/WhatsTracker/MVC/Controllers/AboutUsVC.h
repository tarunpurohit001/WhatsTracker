//
//  AboutUsVC.h
//  Whats Tracker
//
//  Created by Vivek Warde on 08/07/18.
//  Copyright © 2018 Vivek Warde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutUsVC : UIViewController <MFMailComposeViewControllerDelegate>
{
    STABannerView* bannerView;
    //intristitial ad
   ///// STAStartAppAd* startAppAd;
}
@end
