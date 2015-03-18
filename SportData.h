//
//  SportData.h
//  The Vike
//
//  Created by Brian Tracy on 3/15/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface SportData : NSObject <UIWebViewDelegate>


- (NSArray *)sportData;
- (void)loadData;


- (NSArray *)filteredSportData:(NSString *)sportName;

@end
