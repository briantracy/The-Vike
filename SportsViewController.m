//
//  SportsViewController.m
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//


#import "SportsViewController.h"
#import "Sports.h"
#import "UIColor+AppColors.h"
#import "GraphicsHeader.h"
#import "UILabel+PerfectLabel.h"
#import "UIFont+AppFonts.h"
#import "EventsViewController.h"

#define NUM_SPORTS ([Sports sportNames].count)

@interface SportsViewController ()
@property (nonatomic) EventsViewController * eventsViewController;
@property (nonatomic) UIScrollView * scrollView;
@end

@implementation SportsViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self setUpScrollView];
        [self setUpImages];
        [self setUpLabels];
    }
    return self;
}

- (void)setUpScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.backgroundColor = [UIColor vikingColor] ;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * NUM_SPORTS, SCREEN_HEIGHT);
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewSport:)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 1;
    

    [self.scrollView addGestureRecognizer:swipe];
    [self.scrollView addGestureRecognizer:tap];
    
    [self.view addSubview:self.scrollView];
}

- (void)viewSport:(UISwipeGestureRecognizer *)gest
{
    NSLog(@"VIEWING SPORT PAGE = %d", [self currentPage]);
    
    NSString * sport = [[Sports sportNames] objectAtIndex:[self currentPage]];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    self.eventsViewController = [[EventsViewController alloc] initWithSportName:sport];
    self.eventsViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.eventsViewController.view.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        [self.view addSubview:self.eventsViewController.view];
        self.eventsViewController.view.alpha = 1.0;
        
        
    } completion:^(BOOL finished) {
        //[evc.view removeFromSuperview];
    }];
    
}

- (int)currentPage
{
    CGFloat width = self.scrollView.frame.size.width;
    int page = (self.scrollView.contentOffset.x + (0.5f * width)) / width;
    
    return page;
}

- (void)goBack:(UISwipeGestureRecognizer *)gest
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{

}

- (void)setUpLabels
{
    const CGFloat height = 50.0f;
    
    int idx = 0;
    for (NSString * sportName in [Sports sportNames]) {
        UILabel * label = [[UILabel alloc] init];
        
        CGSize size = CGSizeMake(SCREEN_WIDTH, height);
        CGPoint point = CGPointMake(SCREEN_WIDTH_OVER(2), SCREEN_HEIGHT - (height / 2));
        
        label.font = [UILabel fontForSize:size family:[UIFont tf2Font] text:sportName];
        label.text = sportName;
        
        [label sizeToFit];
        [label setCenter:point];
        
        [self addView:label onPage:idx] ;
        idx++;
    }
}

- (void)setUpImages
{
    for (NSString * sportName in [Sports sportNames]) {
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sportName]];
            
            // Make a trivial (1x1) graphics context, and draw the image into it
            UIGraphicsBeginImageContext(CGSizeMake(1,1));
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), [img CGImage]);
            UIGraphicsEndImageContext();
            
            UIImageView * view = [[UIImageView alloc] initWithImage:img];
            [view setFrame:[UIScreen mainScreen].bounds];
            
            
            // Now the image will have been loaded and decoded and is ready to rock for the main thread
            //dispatch_sync(dispatch_get_main_queue(), ^{
                [self addView:view onPage:(int)[[Sports sportNames] indexOfObject:sportName]];
            //});
        //});
        
    }
}

- (void)addView:(UIView *)view onPage:(int)page
{
    CGRect frame = view.frame;
    CGFloat x = frame.origin.x + (page * SCREEN_WIDTH);
    
    [view setFrame:CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height)];
    [self.scrollView addSubview:view];
}

- (BOOL)prefersStatusBarHidden
{
    return !!"Step One: Profit";
}



@end
