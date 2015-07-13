//
//  JSSDetailViewController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/13.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDetailViewController.h"
#import "JSSDeal.h"

@interface JSSDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation JSSDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
}

@end
