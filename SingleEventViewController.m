//
//  SingleEventViewController.m
//  The Vike
//
//  Created by Brian Tracy on 3/22/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "SingleEventViewController.h"
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
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_OVER(2));
        UILabel * label  = [[UILabel alloc] initWithFrame:rect];
        
        label.font   = [UIFont fontWithName:@"Courier New" size:12];
        label.numberOfLines = 0;
        [label setText:[[NSJSONSerialization dataWithJSONObject:game options:NSJSONWritingPrettyPrinted error:nil] description]];
        
        
        [self.view addSubview:label];
        
        self.game = game;
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        
        CGRect rect2 = CGRectMake(0, 0, 200, 80);
        UIButton * takeMe = [UIButton buttonWithType:UIButtonTypeSystem];
        [takeMe setTitle:@"Take Me Here!" forState:UIControlStateNormal];
        [takeMe addTarget:self action:@selector(takeMe:) forControlEvents:UIControlEventTouchUpInside];
        [takeMe setFrame:rect2];
        [takeMe setCenter:CGPointMake(CGRectGetMidX(self.view.frame), SCREEN_HEIGHT - 90)];
        
        [self.view addSubview:takeMe];
        
        NSLog(@"%@", game);
    }
    return self;
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




@end
