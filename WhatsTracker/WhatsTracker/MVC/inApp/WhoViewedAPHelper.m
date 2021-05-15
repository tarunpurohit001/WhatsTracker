//
//  NotelrIAPHelper.m
//  Note'lr
//
//  Created by Ali Yılmaz on 07/05/14.
//  Copyright (c) 2014 Ali Yılmaz. All rights reserved.
//

#import "WhoViewedAPHelper.h"

@implementation WhoViewedAPHelper

+ (WhoViewedAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static WhoViewedAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      kRemoveAdsProductIdentifier,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
