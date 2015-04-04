//
//  Sports.m
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "Sports.h"
#import "NSArray+Mapping.h"
#import "SportSingleton.h"
#import "SportData.h"
@implementation Sports


- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (NSArray *)sportNames
{
    
    
    return @[
             
                @"lacrosse",
                @"baseball",
                @"crosscountry",
                @"soccer",
                @"track",
                @"softball",
                @"tennis",
                @"waterpolo",
                @"football"
                
             ];
}

+ (BOOL)sportIsInSeason:(NSString *)sport
{
    return [[[SportSingleton sharedData] sportData] filter:^BOOL(id obj, int index) {
        if (obj != [NSNull null] && [obj[@"sport"] respondsToSelector:@selector(isEqualToString:)]) {
            return [obj[@"sport"] isEqualToString:sport];
        }
        return NO;
    }].count != 0;
}

+ (NSArray *)sortedSportNames
{
    return [[self sportNames] sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [self sportIsInSeason:obj2] - [self sportIsInSeason:obj1];
    }];
}


@end
