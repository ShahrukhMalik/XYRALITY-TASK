//
//  XTAPIClient.m
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "XTAPIClient.h"

#import "AFHTTPSessionManager.h"


#pragma mark -

@interface XTAPIClient()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end


#pragma mark -

@implementation XTAPIClient

+ (instancetype)sharedClient {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST"]];
    
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return [super init];
}


#pragma mark -
#pragma mark Public methods

- (void)sendAvailableGameWorldsRequestWithLogin:(NSString *)login
                                       password:(NSString *)password
                                     deviceType:(NSString *)deviceType
                                       deviceID:(NSString *)deviceId
                             andCompletionBlock:(XTAPIClientCompletionBlock)block {
    
    NSString *urlString = @"https://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds";
    
    NSDictionary *params = @{@"login": login,
                             @"password": password,
                             @"deviceType": deviceType,
                             @"deviceId": deviceId};
    
    [self sendWebServiceRequestWithURLString:urlString parameters:params andCompletionBlock:block];
}


#pragma mark -
#pragma mark Private methods

- (void)sendWebServiceRequestWithURLString:(NSString *)urlString
                                parameters:(NSDictionary *)params
                        andCompletionBlock:(XTAPIClientCompletionBlock)block {
    
    [self.manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSLog(@"JSON: %@", json);
        block(nil, json);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        block(error, nil);
    }];
}

@end
