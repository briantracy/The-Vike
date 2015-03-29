//
//  SingleEventViewController.m
//  The Vike
//
//  Created by Brian Tracy on 3/22/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "SingleEventViewController.h"

@interface SingleEventViewController ()
@property (nonatomic) NSDictionary * game;
@end

@implementation SingleEventViewController

- (instancetype)initWithGame:(NSDictionary *)game
{
    if (self = [super init]) {
        self.game = game;
    }
    return self;
}



@end
