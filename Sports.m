//
//  Sports.m
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "Sports.h"
#import <UIKit/UIWebView.h>

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



@end
