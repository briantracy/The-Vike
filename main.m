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
        
        NSLog(@"%@", @{@1:@"#"}[@2]);
        
        NSLog(@"%@", gt12);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
