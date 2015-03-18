//
//  UILabel+PerfectLabel.m
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "UILabel+PerfectLabel.h"

BOOL CGSizeGreater(CGSize a, CGSize b);


@implementation UILabel (PerfectLabel)

+ (UIFont *)fontForSize:(CGSize)size family:(NSString *)name text:(NSString *)text
{
    CGFloat fontSize = 1.0;
    UIFont * destination = nil;
    
    for (;;) {
        destination = [UIFont fontWithName:name size:fontSize];
        
        CGSize newSize = [text sizeWithAttributes:@{NSFontAttributeName : destination}];
        
        if (CGSizeGreater(newSize, size)) {
            break;
        }
        
        fontSize++;
    }
    
    return [UIFont fontWithName:name size:--fontSize];
}

/*
    RETURN A > B
*/
BOOL CGSizeGreater(CGSize a, CGSize b)
{
    return (a.width > b.width) || (a.height > b.height);
}




@end
