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
