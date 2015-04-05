//
//  JumpViewController.h
//  The Vike
//
//  Created by Brian Tracy on 4/5/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JumpToSportDelegate.h"

@interface JumpViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) id <JumpToSportDelegate> jumpDelegate;

@end
