//
//  SportSingleton.h
//  The Vike
//
//  Created by Brian Tracy on 3/15/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SportData;

@interface SportSingleton : UIViewController


+ (void)loadSharedData;

+ (SportData *)sharedData;



@end
