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
@property (nonatomic) NSArray * sports;
@end

@implementation JumpViewController


- (instancetype)init
{
    if (self = [super init]) {
        
        self.sports = [Sports sportNames];
        
        [self setUpTable];
        
    }
    return self;
}

- (void)setUpTable
{
    UITableView * table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    table.delegate = self;
    table.dataSource = self;
    
    table.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = [UIView new];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:table];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.textLabel.text = self.sports[indexPath.row];
    
    const CGFloat fontSize = 20;
    cell.textLabel.font = [UIFont fontWithName:[UIFont tf2Font] size:fontSize];
    cell.textLabel.textColor = [UIColor vikingColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sports.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * sport = self.sports[indexPath.row];
    
    [self.jumpDelegate jumpToSport:sport];
}


@end
