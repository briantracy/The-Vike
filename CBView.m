//
//  CBView.m
//  Navigation_Test1
//
//  Created by mpseligson on 3/15/15.
//  Copyright (c) 2015 Matthew Seligson. All rights reserved.
//

#import "CBView.h"
#import "UIColor+AppColors.h"

@implementation CBView

/*
 NSMutableArray * danQuiote = [[NSMutableArray alloc] init];
 */

- (void)updateText
{
    NSArray * quotes =
    @[
        @"let's put a muzzle on these cats",
        @"let's go PA"
      
      ];
    
    self.text = [quotes objectAtIndex:arc4random_uniform(quotes.count)];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor clearColor];
    CGRect currentFrame = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat strokeWidth = 4;
    CGFloat borderRadius = 15;
    CGFloat HEIGHTOFPOPUPTRIANGLE = 30;
    CGFloat WIDTHOFPOPUPTRIANGLE = 30;
    CGFloat tPercent = .8;

    
    CGRect textRect = CGRectOffset(CGRectInset(currentFrame, strokeWidth*3.5, 0), 0, strokeWidth*2.5 + HEIGHTOFPOPUPTRIANGLE);
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentLeft];
    NSDictionary *attributes = @{
                                 NSParagraphStyleAttributeName: style,
                                 NSForegroundColorAttributeName: [UIColor vikingColor],
                                 NSFontAttributeName: [UIFont fontWithName:@"TF2Build" size:24.0f]
                                 };
    CGRect textSpaceRect = [self.text boundingRectWithSize:textRect.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    CGRect newFrame = currentFrame;
    newFrame.size.height = textSpaceRect.size.height+HEIGHTOFPOPUPTRIANGLE+strokeWidth*3.5;
    currentFrame = newFrame;
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor vikingColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width * tPercent - WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width * tPercent) + 0.5f, strokeWidth + 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width * tPercent + WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) - strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, strokeWidth + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    [self.text drawInRect:textRect withAttributes:attributes];
}


@end
