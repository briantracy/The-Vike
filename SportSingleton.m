//
//  SportSingleton.m
//  The Vike
//
//  Created by Brian Tracy on 3/15/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "SportSingleton.h"
#import "SportData.h"

@implementation SportSingleton

static SportData * sportData;

+ (void)loadSharedData
{
    sportData = [[SportData alloc] init];
    [sportData loadData];
    NSLog(@"loaded shared data: %@", sportData);
}


+ (SportData *)sharedData
{
    NSLog(@"requesting shared data");
    @synchronized(self) {
        return sportData;
    }
}

@end
