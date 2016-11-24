//
//  XTGameWorld.h
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"


#pragma mark -

@interface XTGameWorld : JSONModel

@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *language;

@property (strong, nonatomic) NSURL *mapURL;
@property (strong, nonatomic) NSURL *url;

@property (assign, nonatomic) NSInteger gameWorldId;

@property (strong, nonatomic) NSString *worldStatusDescription;
@property (assign, nonatomic) NSInteger worldStatusId;

+ (NSMutableArray *)arrayOfGameWorldsFromInfo:(NSArray *)info;

@end
