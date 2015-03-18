//
//  SportData.m
//  The Vike
//
//  Created by Brian Tracy on 3/15/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#import "SportData.h"

#import <UIKit/UIWebView.h>

@interface SportData ()
@property (nonatomic) UIWebView * webView;
@property (nonatomic) NSArray * json;
@end

@implementation SportData

- (NSArray *)sportData
{
    return self.json;
}

- (void)loadData
{
    NSURL * url = [NSURL URLWithString:@"http://silicode.us/freeform"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.webView.delegate = self;
    
    
    [self.webView loadRequest:request];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    const NSTimeInterval delay = 2;
    [self performSelector:@selector(attemptRetrieveData) withObject:nil afterDelay:delay];
    
    
}

- (void)attemptRetrieveData
{
    NSString * json = [self.webView stringByEvaluatingJavaScriptFromString:@"(function(){ return document.getElementById('output').innerHTML; })();"];
    
    
    NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error;
    self.json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"%@ JSON", self.json);
}

- (NSArray *)filteredSportData:(NSString *)sportName
{
    NSMutableArray * temp = [NSMutableArray new];
    
    for (NSDictionary * dict in self.json) {
        
        if ([dict isEqual:[NSNull null]]) continue;
        
        
        if ([[dict[@"sport"] lowercaseString] isEqualToString:sportName]) {
            [temp addObject:dict];
        }
        
        
    }
    
    return [temp copy];
}

@end
