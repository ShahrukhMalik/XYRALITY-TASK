//
//  XTSession.h
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark -

@interface XTSession : NSObject

+ (instancetype)sharedSession;

- (NSString *)deviceType;
- (NSString *)deviceId;

@end
