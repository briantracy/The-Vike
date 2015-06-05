//
//  CBView.h
//  The Vike
//
//  Created by Matthew Seligson on 6/5/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CBView : UIView
@property (nonatomic, strong) NSString *text;

- (void)updateText;
@end
