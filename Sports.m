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
                @"football",
                @"swimminganddiving",
                @"volleyball",
                @"wrestling",
                @"golf"
                
                
             ];
}

+ (NSArray *)sortedSportNames
{
    NSMutableArray * arr = [NSMutableArray array];
    
    NSDictionary * seasonToSports = @{
                                      @"Spring" : @[@"Lacrosse", @"Baseball", @"Softball", @"Tennis", @"Track", @"Swimming and Diving"],
                                      @"Fall" : @[@"Football", @"Tennis", @"Cross Country", @"Water Polo"],
                                      @"Winter" : @[@"Soccer", @"Basketball", @"Wrestling", @"Volleyball"],
                                      };
    
    NSDictionary * seasonToOrderOfSeasons = @{
                                              @"Spring" : @[@"Spring", @"Fall", @"Winter"],
                                              @"Fall" : @[@"Fall", @"Winter", @"Spring"],
                                              @"Winter" : @[@"Winter", @"Spring", @"Fall"],
                                              };
    
    NSString * currentSeason = [self getSeason];
    
    for (NSString * season in seasonToOrderOfSeasons[currentSeason]) {
        
        for (NSString * sportName in seasonToSports[season]) {
            NSString * s = [[sportName lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            if (![arr containsObject:s]) {
                [arr addObject:s];
            }
            
        }
    }
    
    
    return [arr copy];
}


+ (NSString *)getSeason {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger dayOfYear = [gregorian ordinalityOfUnit:NSCalendarUnitDay
                                               inUnit:NSCalendarUnitYear forDate:[NSDate date]];
    if (dayOfYear<32) return @"Winter";
    if (dayOfYear<230) return @"Spring";
    if (dayOfYear<305) return @"Fall";
    return @"Winter";
    
    
}




@end
