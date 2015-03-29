//
//  main.m
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "NSArray+Mapping.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSArray * nums = @[@10, @11, @12, @13, @14, @15];
        
        NSArray * gt12 = [nums filter:^BOOL(id obj, int index) {
            return [(NSNumber *)obj intValue] > 12;
        }];
        NSLog(@"%@", gt12);
        
        
        NSArray * timesTwo = [[nums map:^id(id obj, int index) {
            return @([obj intValue] * 2);
        }]
                              filter:^BOOL(id obj, int index) {
                                  return [obj intValue] % 3 == 0;
        }];
        NSLog(@"%@", timesTwo);
        
        int retval = -1;
        
        @try {
            retval = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));

        }
        @catch (NSException *exception) {
            NSLog(@"Uncaught exception: %@", exception.description);
            NSLog(@"Stack trace: %@", [exception callStackSymbols]);
            @throw exception;
        }
        @finally {
            
        }
        
    }
}
