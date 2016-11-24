//
//  XTGameWorld.m
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "XTGameWorld.h"


#pragma mark -

@implementation XTGameWorld

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                       @"country": @"country",
                                                       @"gameWorldId": @"id",
                                                       @"language": @"language",
                                                       @"mapURL": @"mapURL",
                                                       @"name": @"name",
                                                       @"url": @"url",
                                                       @"worldStatusDescription": @"worldStatus.description",
                                                       @"worldStatusId": @"worldStatus.id"
                                                       }];
}


// Make all properties optional
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (NSMutableArray *)arrayOfGameWorldsFromInfo:(NSArray *)info {
    NSMutableArray *gameWorldArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in info) {
        
        NSError *error = nil;
        XTGameWorld *aGameWorld = [[XTGameWorld alloc] initWithDictionary:dict error:&error];
        
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        [gameWorldArray addObject:aGameWorld];
    }
    
    return gameWorldArray;
}

@end
