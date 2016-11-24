//
//  XTSession.m
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "XTSession.h"

#import <UIKit/UIKit.h>

// ++++++++++++++++++++++++++++++
//        USER DEFAULTS
// ++++++++++++++++++++++++++++++

NSString * const kXTUserDefaultsDeviceTypeKey = @"XTUserDefaultsDeviceTypeKey";
NSString * const kXTUserDefaultsDeviceIdKey = @"XTUserDefaultsDeviceIdKey";


#pragma mark -

@implementation XTSession

+ (instancetype)sharedSession {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


#pragma mark -
#pragma mark Public methods

- (NSString *)deviceType {
    NSString *devType = [[NSUserDefaults standardUserDefaults] objectForKey:kXTUserDefaultsDeviceTypeKey];
    
    if (devType == nil || [devType length] == 0) {
        devType = [NSString stringWithFormat:@"%@ - %@%@", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
        
        [[NSUserDefaults standardUserDefaults] setObject:devType forKey:kXTUserDefaultsDeviceTypeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return devType;
}

- (NSString *)deviceId {
    NSString *devId = [[NSUserDefaults standardUserDefaults] objectForKey:kXTUserDefaultsDeviceIdKey];
    
    if (devId == nil || [devId length] == 0) {
        devId = [[NSUUID UUID] UUIDString];
        
        [[NSUserDefaults standardUserDefaults] setObject:devId forKey:kXTUserDefaultsDeviceIdKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return devId;
}

@end
