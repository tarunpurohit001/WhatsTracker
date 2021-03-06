//
//  IAPShare.m
//  inappPurchasesTest
//
//  Created by Htain Lin Shwe on 10/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import "IAPShare.h"

#if ! __has_feature(objc_arc)
#error You need to either convert your project to ARC or add the -fobjc-arc compiler flag to IAPShare.m.
#endif

@implementation IAPShare
@synthesize iap= _iap;
static IAPShare * _sharedHelper;

+ (IAPShare *) sharedHelper {
    
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[IAPShare alloc] init];
    _sharedHelper.iap = nil;
    return _sharedHelper;
}

+(id)toJSON:(NSString *)json
{
    NSError* e = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData: [json dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    
    if(e==nil) {
        return jsonObject;
    }
    else {
      //  //Nslog(@"%@",[e localizedDescription]);
        return nil;
    }
    
}

@end
