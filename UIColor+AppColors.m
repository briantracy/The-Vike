//
//  UIColor+AppColors.m
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "UIColor+AppColors.h"

#define FLOAT_FROM_LITERAL(lit) (lit##.0 / 255.0)


@implementation UIColor (AppColors)

+ (instancetype)vikingColor
{
    return [self colorWithRed:FLOAT_FROM_LITERAL(45) green:FLOAT_FROM_LITERAL(62) blue:FLOAT_FROM_LITERAL(36) alpha:1];
}

@end
