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

@interface EventsViewController ()
@property (nonatomic) NSString * sportName;
@property (nonatomic) UITableView * tableView;
@property (nonatomic) NSArray * events;
@property (nonatomic) NSMutableDictionary * dateToGames;
@property (nonatomic) NSMutableArray * dates;
@end

@implementation EventsViewController

- (instancetype)initWithSportName:(NSString *)name
{
    if (self = [super init]) {
        NSLog(@"creating events view controller with sport: %@", name);
        self.view.backgroundColor = [UIColor clearColor];
        self.sportName = name;
        
        self.events = [[SportSingleton sharedData] filteredSportData:name];
        [self sortChronologically];
        
        for (NSDictionary * dict in self.events) {
            NSLog(@"%@", dict[@"date"]);
        }
        NSLog(@"%d", [self uniqueDates]);
        NSLog(@"%@", self.events);
        
        [self setUpTableView];
    }
    
    return self;
}

- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithWhite:.7 alpha:.5];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Yo Baller";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self uniqueDates];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.events[indexPath.row][@"location"];
    
    cell.detailTextLabel.text = self.events[indexPath.row][@"date"];
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

- (int)uniqueDates
{
    NSMutableSet * set = [[NSMutableSet alloc] init];
    
    for (NSDictionary * dict in self.events) {
        [set addObject:dict[@"date"]];
    }
    return (int)set.count;
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


@end
