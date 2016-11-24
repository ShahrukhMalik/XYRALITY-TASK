//
//  XTAPIClient.h
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XTAPIClientCompletionBlock)(NSError *error, NSDictionary *responseDict);


#pragma mark -

@interface XTAPIClient : NSObject

+ (instancetype)sharedClient;

- (void)sendAvailableGameWorldsRequestWithLogin:(NSString *)login
                                       password:(NSString *)password
                                     deviceType:(NSString *)deviceType
                                       deviceID:(NSString *)deviceID
                             andCompletionBlock:(XTAPIClientCompletionBlock)block;

@end
