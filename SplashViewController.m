//
//  SplashViewController.m
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "SplashViewController.h"

#import "UILabel+PerfectLabel.h"
#import "UIColor+AppColors.h"
#import "UIFont+AppFonts.h"
#import "GraphicsHeader.h"
#import "SilicodeViewController.h"
#import "SportsViewController.h"
#import "AppDelegate.h"
#import "CBView.h"

@interface SplashViewController ()
@property (nonatomic) CBView * cbview;
@end

@implementation SplashViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
    
        [self setUpMainTitle];
        [self setUpSubTitle];
        [self setUpViking];
        [self setUpButtons];
        [self setUpSilicodeLogo];

    }
    return self;
}



- (void)setUpMainTitle
{
    NSString * mainTitle  = @"THE VIKE";
    const CGFloat kTop    = 25.0f;
    const CGFloat kInset  = 10.0f;
    const CGFloat kHeight = 100;
    CGRect frame          = CGRectMake(kInset, kTop, SCREEN_WIDTH - (kInset * 2), kHeight);
    UIFont * font         = [UILabel fontForSize:frame.size family:[UIFont tf2Font] text:mainTitle];
    
    UILabel * title = [[UILabel alloc] initWithFrame:frame];
    title.font = font;
    title.text = mainTitle;
    title.textColor = [UIColor vikingColor];
    title.numberOfLines = 0;
    [title sizeToFit];
    //title.backgroundColor = [UIColor redColor];
    [title setCenter:CGPointMake(SCREEN_WIDTH_OVER(2), title.center.y)];
    [self.view addSubview:title];
    
    
    NSString * subTitleText = @"PALY SPORTS APP";
    CGFloat end            = title.frame.origin.y + title.frame.size.height;
    const CGFloat kPadding = 0.0f;
    frame                  = CGRectMake(0, end + kPadding, SCREEN_WIDTH_OVER(2), 100);
    font                   = [UILabel fontForSize:frame.size family:[UIFont tf2Font] text:subTitleText];
    UILabel * subTitle = [[UILabel alloc] initWithFrame:frame];
    subTitle.font = font;
    subTitle.textColor = [UIColor vikingColor];
    subTitle.text = subTitleText;
    subTitle.numberOfLines = 0;
    //subTitle.backgroundColor = [UIColor redColor];
    [subTitle sizeToFit];
    [subTitle setCenter:CGPointMake(SCREEN_WIDTH_OVER(2), subTitle.center.y)];
    
    
    [self.view addSubview:subTitle];
}

- (void)setUpSubTitle
{
    
}

- (void)setUpViking
{
    UIImage * image = [UIImage imageNamed:@"VikingHead.png"];
    UIImageView * view = [[UIImageView alloc] initWithImage:image];
    
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH_OVER(3) * 2, SCREEN_WIDTH_OVER(3) * 2);
    CGPoint center = CGPointMake(SCREEN_WIDTH_OVER(2), SCREEN_HEIGHT_OVER(12) * 5);
    
    view.frame = frame;
    view.center = center;
    
    [self.view addSubview:view];
    
    [self setUpSpeechBubbleWithVikingView:view];
}

- (void)setUpButtons
{
    //UIButton * sports , * about;
    
}

- (void)setUpSilicodeLogo
{
    const CGFloat inset = 5.0f;
    const CGFloat height = 30.0f;
    CGRect rect = CGRectMake(inset, SCREEN_HEIGHT - inset - height, SCREEN_WIDTH_OVER(3), height);
    
    UIImage * image = [UIImage imageNamed:@"silicode_logo_grey_real.png"];
    UIImageView * view = [[UIImageView alloc] initWithImage:image];
    
    view.frame = rect;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(silicodeLogo:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap] ;
    
    [self.view addSubview:view];
}

- (void)silicodeLogo:(UIGestureRecognizer *)gest
{
    SilicodeViewController * svc = [[SilicodeViewController alloc] init];
    [self presentViewController:svc animated:YES completion:^{
    }];
    NSLog(@"Logo tapped");
}

- (BOOL)prefersStatusBarHidden
{
    return ! ! "I was absolutely in the right" ;
}

- (void)setUpSpeechBubbleWithVikingView:(UIView *) view
{
    float viewBottom = view.frame.size.height+view.frame.origin.y;
    self.cbview = [[CBView alloc] initWithFrame:CGRectInset(CGRectMake(0, viewBottom-20, SCREEN_WIDTH, 500),10,0)];
    self.cbview.backgroundColor = [UIColor clearColor];
    [self.cbview updateText];
    [self.view addSubview:self.cbview];
}





@end
