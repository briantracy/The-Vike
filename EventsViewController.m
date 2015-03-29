//
//  EventsViewController.m
//  The Vike
//
//  Created by Brian Tracy on 3/15/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "EventsViewController.h"

#import "SportSingleton.h"
#import "SportData.h"
#import "NSArray+Mapping.h"
#import "GraphicsHeader.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface EventsViewController ()
@property (nonatomic) NSString * sportName;
@property (nonatomic) UITableView * tableView;
@property (nonatomic) NSArray * events;
@property (nonatomic) NSMutableDictionary /* <String, JSON> */ * dateToGames;
@property (nonatomic) NSMutableArray * dates;
@end

@implementation EventsViewController

- (instancetype)initWithSportName:(NSString *)name
{
    if (self = [super init]) {
        NSLog(@"creating events view controller with sport: %@", name);
        self.view.backgroundColor = [UIColor whiteColor];
        self.sportName = name;
        
        self.events = [[SportSingleton sharedData] filteredSportData:name];
        [self sortChronologically];
        
        [self setUpDates];
        
        
        [self setUpDatesToGames];
        NSLog(@"%@", self.dateToGames);
        
        
        [self setUpTableView];
        
        
        
    }
    
    return self;
}

- (void)setUpDates
{
    self.dates = [NSMutableArray new];
    for (NSDictionary * game in self.events) {
        NSString * date = game[@"date"];
        
        if ([self.dates containsObject:date]) {}
        else {
            [self.dates addObject:date];
        }
    }
}

- (void)setUpDatesToGames
{
    self.dateToGames = [NSMutableDictionary new];
    for (NSString * date in [self uniqueDates]) {
        
        NSArray * gamesOnDate = [self.events filter:^BOOL(id obj, int index) {
            return [((NSDictionary *)obj)[@"date"] isEqualToString:date];
        }];
        
        self.dateToGames[date] = gamesOnDate;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLGeocoder * coder = [[CLGeocoder alloc] init];
    NSString * address = self.dateToGames[self.dates[indexPath.section]][indexPath.row][@"address"];
    [coder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark * place = placemarks[0];
            

            MKPlacemark * placeMark = [[MKPlacemark alloc] initWithPlacemark:place];
            MKMapItem * mapItem = [[MKMapItem alloc] initWithPlacemark:placeMark];
            [mapItem setName:@"Swag"];

            NSLog(@"%@", mapItem);
        
            
            
            
            
            
            //NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
            
            // Get the "Current User Location" MKMapItem
            //MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
            
            // Pass the current location and destination map items to the Maps app
            // Set the direction mode in the launchOptions dictionary
            [MKMapItem openMapsWithItems:@[mapItem] launchOptions:nil];
            
        }
        else {
            NSLog(@"COULD NOT FIND LOCATIONS");
        }
    }];
}

- (void)addNoSportIndicator
{
    UIImage * vikeImage = [UIImage imageNamed:@"VikingHead.png"];
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH_OVER(2), SCREEN_WIDTH_OVER(2));
    UIImageView * vikeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_OVER(3) * 2, SCREEN_WIDTH_OVER(3) * 2)];
    CGPoint center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    
    vikeImageView.image = vikeImage;
    vikeImageView.center = center;
    
    [self.view addSubview:vikeImageView];
    
    CGRect labelFrame = CGRectMake(0, 0, SCREEN_WIDTH_OVER(4) * 3, 80);
    UILabel * label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = @"Sport Not In Season";
    [label sizeToFit];
    CGFloat yCoord = vikeImageView.frame.origin.y + vikeImageView.frame.size.height + 20;
    label.center = CGPointMake(CGRectGetMidX(self.view.frame), yCoord);
    
    
    
    [self.view addSubview:label];
    
}

- (void)setUpTableView
{
    if (self.events.count == 0) {
        NSLog(@"EMPTY SPORT");
        [self addNoSportIndicator];
        return;
        
    }
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    
//    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
//    [refresh addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refresh];
    
}

- (void)backButton:(id)sender
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dates[section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self uniqueDates].count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    NSString * date = self.dates[indexPath.section];
    
    NSDictionary * game = self.dateToGames[date][indexPath.row];

    
    cell.textLabel.text = game[@"opponent"];
    cell.detailTextLabel.text = game[@"level"];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * date = self.dates[section];
    int games = (int)[(NSArray *)self.dateToGames[date] count];
    return games;
}

- (NSSet *)uniqueDates
{
    NSMutableSet * set = [[NSMutableSet alloc] init];
    
    for (NSDictionary * dict in self.events) {
        [set addObject:dict[@"date"]];
    }
    return [set copy];
}

- (void)sortChronologically
{
    self.events = [self.events sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        obj1 = (NSDictionary *)obj1;
        obj2 = (NSDictionary *)obj2;
        NSString *str1 = [NSString stringWithFormat: @"%@ %@", [obj1 objectForKey:@"date"], [obj1 objectForKey:@"start"]];
        NSString *str2 = [NSString stringWithFormat: @"%@ %@", [obj2 objectForKey:@"date"], [obj2 objectForKey:@"start"]];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM-dd-yyyy HH:mm"];
        NSDate *date1 = [dateFormat dateFromString:str1];
        NSDate *date2 = [dateFormat dateFromString:str2];
        return [date1 compare:date2];
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}




@end
