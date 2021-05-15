//
//  GetPremiumVC.h
//  Whats Tracker
//
//  Created by Vivek Warde on 08/07/18.
//  Copyright © 2018 Vivek Warde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface GetPremiumVC : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver>

- (IBAction)restore;
- (IBAction)tapsRemoveAds;


@end
