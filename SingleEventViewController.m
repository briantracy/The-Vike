//
//  SingleEventViewController.m
//  The Vike
//
//  Created by Brian Tracy on 3/22/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "SingleEventViewController.h"
#import "GraphicsHeader.h"
#import "UILabel+PerfectLabel.h"
#import "UIFont+AppFonts.h"
#import "UIColor+AppColors.h"
#import "NSArray+Mapping.h"
#import "GraphicsHeader.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SingleEventViewController ()
@property (nonatomic) NSDictionary * game;
@end

@implementation SingleEventViewController

- (instancetype)initWithGame:(NSDictionary *)game
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.game = game;
        [self createTitle];
        [self createData];
    }
    return self;
}

- (void)createTitle
{
    NSString * title = [NSString stringWithFormat:@"Palo Alto %@", self.game[@"opponent"]];
    
    const CGFloat inset = 10;
    const CGFloat height = 100;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, inset, SCREEN_WIDTH, height)];
    label.text = title;
    
    label.font = [UILabel fontForSize:label.frame.size family:@"Helvetica" text:label.text];
    label.textColor = [UIColor vikingColor];
    
    [label sizeToFit];
    
    [label setCenter:CGPointMake(CGRectGetMidX(self.view.frame), (inset + height) / 2)];
    
    [self.view addSubview:label];
    
    
}

- (void)createData
{
    const CGFloat startY = SCREEN_HEIGHT_OVER(3) * 1;
    const CGFloat heightOfCell = 40;
    const CGFloat cellPadding = 10;
    const CGFloat column = 20;
          CGFloat offset = 0;
    
    const CGFloat fontSize = 20;
    
    CGFloat baseline = SCREEN_HEIGHT_OVER(6);
    UIFont * font = [UIFont systemFontOfSize:fontSize]; //[UIFont fontWithName:[UIFont tf2Font] size:fontSize];
    
    for (NSString * key in [self filteredData]) {
        NSString * value = self.game[key];

        
        if ([key isEqualToString:@"start"]) {
            value = [self to12Hour:value];
        }
        
        
        UILabel * keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , baseline, SCREEN_WIDTH_OVER(4), heightOfCell)];
       // keyLabel.backgroundColor = [UIColor yellowColor];
        keyLabel.textAlignment = NSTextAlignmentRight;
        keyLabel.text = [self capitalizeString:key];
        keyLabel.font = font;
        [keyLabel sizeToFit];
        
        CGRect frame = keyLabel.frame;
        CGRect newFrame = CGRectMake(SCREEN_WIDTH_OVER(4) - frame.size.width, frame.origin.y, frame.size.width, frame.size.height   );
        [keyLabel setFrame:newFrame];
        
        
        [self.view addSubview:keyLabel];
        
        
        
        UILabel * valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH_OVER(4) + column, baseline , SCREEN_WIDTH - (SCREEN_WIDTH_OVER(4) + column) - 10, 0)];
        //valueLabel.backgroundColor = [UIColor lightGrayColor];
        
        valueLabel.textAlignment = NSTextAlignmentLeft;
        valueLabel.text = value;
        valueLabel.font = font;
        valueLabel.numberOfLines = 0;
        [valueLabel sizeToFit];
        
        [self.view addSubview:valueLabel];
        
        baseline += (cellPadding + MAX(keyLabel.frame.size.height, valueLabel.frame.size.height));

    
    }
}

- (void)takeMe:(UIButton *)sender
{
        CLGeocoder * coder = [[CLGeocoder alloc] init];
        NSString * address = self.game[@"address"];
        [coder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] > 0) {
                CLPlacemark * place = placemarks[0];
    
    
                MKPlacemark * placeMark = [[MKPlacemark alloc] initWithPlacemark:place];
                MKMapItem * mapItem = [[MKMapItem alloc] initWithPlacemark:placeMark];
                [mapItem setName:@"Swag"];
    
                NSLog(@"%@", mapItem);
    
                [MKMapItem openMapsWithItems:@[mapItem] launchOptions:nil];
    
            }
            else {
                NSLog(@"COULD NOT FIND LOCATIONS");
            }
        }];
}

- (NSArray *)filteredData
{
    return [self.game.allKeys filter:^BOOL(id obj, int index) {
        return [@[
                  @"start",
                  @"sport",
                  @"date",
                  @"sex",
                  @"level"
                  
                  ] containsObject:obj];
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return ! ! "I'm alright jack, keep your hands off my stack";
}

- (NSString *)to12Hour:(NSString *)time
{
    NSLog(@"%@", time);
    NSString * prefix = [time componentsSeparatedByString:@":"][0];
    NSString * body = [time componentsSeparatedByString:@":"][1];
    NSString * suffix = @"";
    
    if ([prefix intValue] > 12) {
        
        int val = [prefix intValue] - 12;
        
        prefix = [@(val) stringValue];
        suffix = @"PM";
        
    }
    else {
        suffix = @"AM";
    }
    
    return [NSString stringWithFormat:@"%@:%@ %@", prefix, body, suffix];
}


- (NSString *)capitalizeString:(NSString *)string
{
    return [NSString stringWithFormat:@"%@%@", [[string substringToIndex:1] capitalizedString], [string substringFromIndex:1]];
}

@end
