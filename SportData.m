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
    NSURL * url = [NSURL URLWithString:@"https://silicode.us/freeform/"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.webView.delegate = self;
    
    
    NSURL * tempURL = [NSURL URLWithString:@"https://silicode.us/freeform/backup.txt"];
    NSError * error;

    NSData * data = [NSData dataWithContentsOfURL:tempURL options:NSDataReadingUncached error:&error];
    NSLog(@"data= %@", data);
    
    self.json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    NSLog(@"%@", error);
    
    //[self.webView loadRequest:request];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    const NSTimeInterval delay = 2;
    [self performSelector:@selector(attemptRetrieveData) withObject:nil afterDelay:delay];
    //[self performSelectorInBackground:@selector(attemptRetrieveData) withObject:nil];
    //[self performSelectorOnMainThread:@selector(attemptRetrieveData) withObject:nil waitUntilDone:NO];
    
    
}

- (void)attemptRetrieveData
{
    NSString * JavaScript = @"(function(){ return document.getElementById('output').innerHTML; })();";

    NSString * json = [self.webView stringByEvaluatingJavaScriptFromString:JavaScript];
    NSLog(@"%@ LKJS", json);
    
    
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
