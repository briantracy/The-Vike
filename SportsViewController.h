//
//  SportsViewController.h
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JumpToSportDelegate.h"

@interface SportsViewController : UIViewController <UIScrollViewDelegate, JumpToSportDelegate>

- (instancetype)init;

- (void)initializeNavigation;
@end
