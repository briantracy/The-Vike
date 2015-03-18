//
//  NSArray+Mapping.h
//  The Vike
//
//  Created by Brian Tracy on 3/18/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Mapping)


- (NSArray *)filter:(BOOL (^)(id obj, int index))closure;

- (NSArray *)map:(id (^)(id obj, int index))closure;

@end
