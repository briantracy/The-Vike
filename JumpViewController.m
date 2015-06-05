//
//  JumpViewController.m
//  The Vike
//
//  Created by Brian Tracy on 4/5/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "JumpViewController.h"
#import "UIColor+AppColors.h"
#import "UIFont+AppFonts.h"
#import "Sports.h"

@interface JumpViewController ()
@property (nonatomic) NSDictionary * sports;
@property (nonatomic) NSArray * orderedSeasons;
@end

@implementation JumpViewController

- (instancetype)init

{
    if (self = [super init]) {
        [self setUpTable];
        
    }
    return self;
}

- (NSString *)getSeason {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger dayOfYear = [gregorian ordinalityOfUnit:NSCalendarUnitDay
                                               inUnit:NSCalendarUnitYear forDate:[NSDate date]];
    if (dayOfYear<32) return @"Winter";
    if (dayOfYear<230) return @"Spring";
    if (dayOfYear<305) return @"Fall";
    return @"Winter";
    
    
}

- (void)setUpTable
{
    self.sports = @{
                    @"Spring" : @[@"Lacrosse", @"Baseball", @"Softball", @"Tennis", @"Track", @"Swimming and Diving"],
                    @"Fall" : @[@"Football", @"Tennis", @"Cross Country", @"Water Polo"],
                    @"Winter" : @[@"Soccer", @"Basketball", @"Wrestling", @"Volleyball"],
                    };
    NSDictionary * seasonSchedules = @{
                                       @"Spring" : @[@"Spring", @"Fall", @"Winter"],
                                       @"Fall" : @[@"Fall", @"Winter", @"Spring"],
                                       @"Winter" : @[@"Winter", @"Spring", @"Fall"],
                                       };
    self.orderedSeasons = seasonSchedules[[self getSeason]];
    
    UITableView * table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    table.delegate = self;
    table.dataSource = self;
    
    table.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = [UIView new];
    
    [self.view addSubview:table];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.orderedSeasons[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.textLabel.text = self.sports[self.orderedSeasons[indexPath.section]][indexPath.row];
    
    const CGFloat fontSize = 20;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    cell.textLabel.textColor = [UIColor vikingColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *row = (NSArray *) self.sports[self.orderedSeasons[section]];
    return row.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * sport = self.sports[self.orderedSeasons[indexPath.section]][indexPath.row];
    
    sport = [[sport lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self.jumpDelegate jumpToSport:sport];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


@end
////
////  JumpViewController.m
////  The Vike
////
////  Created by Brian Tracy on 4/5/15.
////  Copyright (c) 2015 Silicode. All rights reserved.
////
//
//#import "JumpViewController.h"
//#import "UIColor+AppColors.h"
//#import "UIFont+AppFonts.h"
//#import "Sports.h"
//
//@interface JumpViewController ()
//@property (nonatomic) NSArray * sports;
//@end
//
//@implementation JumpViewController
//
//
//- (instancetype)init
//{
//    if (self = [super init]) {
//        
//        self.sports = [Sports sportNames];
//        
//        [self setUpTable];
//        
//    }
//    return self;
//}
//
//- (void)setUpTable
//{
//    UITableView * table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
//    
//    table.delegate = self;
//    table.dataSource = self;
//    
//    table.backgroundColor = [UIColor whiteColor];
//    table.tableFooterView = [UIView new];
//    table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//    [self.view addSubview:table];
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
//    
//    cell.textLabel.text = self.sports[indexPath.row];
//    
//    const CGFloat fontSize = 20;
//    cell.textLabel.font = [UIFont fontWithName:[UIFont tf2Font] size:fontSize];
//    cell.textLabel.textColor = [UIColor vikingColor];
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
//    
//    return cell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.sports.count;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSString * sport = self.sports[indexPath.row];
//    
//    [self.jumpDelegate jumpToSport:sport];
//}
//
//
//@end
