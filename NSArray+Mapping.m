//
//  NSArray+Mapping.m
//  The Vike
//
//  Created by Brian Tracy on 3/18/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "NSArray+Mapping.h"

@implementation NSArray (Mapping)


- (NSArray *)filter:(BOOL (^)(id, int))closure
{
    NSMutableArray * temp = [NSMutableArray arrayWithCapacity:self.count];
    for (int i = 0; i < (int)self.count; i++)
    {
        if (closure(self[i], i)) {
            [temp addObject:self[i]];
        }
    }
    
    return [temp copy];
}

- (NSArray *)map:(id (^)(id, int))closure
{
    NSMutableArray * temp = [NSMutableArray arrayWithCapacity:self.count];
    for (int i = 0; i < (int)self.count; i++)
    {
        [temp addObject:closure(self[i], i)];
    }
    
    
    return [temp copy];
}

@end
