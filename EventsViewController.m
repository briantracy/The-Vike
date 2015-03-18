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
        self.view.backgroundColor = [UIColor clearColor];
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
        NSLog(@"DATE IS %@", date);
        
        if ([self.dates containsObject:date]) {}
        else {
            [self.dates addObject:date];
        }
    }
    NSLog(@"%@", self.dates);
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

- (void)setUpTableView
{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithWhite:.7 alpha:.5];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    
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

    
    cell.textLabel.text = game[@"location"];
    cell.detailTextLabel.text = game[@"level"];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * date = self.dates[section];
    NSLog(@"%@", date);
    int games = (int)[(NSArray *)self.dateToGames[date] count];
    NSLog(@"%d", games);
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



@end
