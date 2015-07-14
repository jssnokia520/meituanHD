//
//  JSSDetailViewController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/13.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDetailViewController.h"
#import "JSSDeal.h"
#import "JSSConst.h"

@interface JSSDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end

@implementation JSSDetailViewController

/**
 *  限制本控制器只能是横屏
 */
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:JSSGlobalColor];
    
    [self.webView setHidden:YES];
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (![webView.request.URL.absoluteString containsString:@"http://m.dianping.com/tuan/deal/moreinfo"]) { // 不是"更多图文详情"的时候应该加载"更多图文详情"
        NSString *ID = [self.deal.deal_id substringFromIndex:[self.deal.deal_id rangeOfString:@"-"].location + 1];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", ID]];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    } else { // 更多图文详情
        NSMutableString *js = [NSMutableString string];
        
        // 删除header
        [js appendString:@"var header = document.getElementsByTagName('header')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        // 删除顶部的购买
        [js appendString:@"var box = document.getElementsByClassName('cost-box')[0];"];
        [js appendString:@"box.parentNode.removeChild(box);"];
        // 删除底部的购买
        [js appendString:@"var buyNow = document.getElementsByClassName('buy-now')[0];"];
        [js appendString:@"buyNow.parentNode.removeChild(buyNow);"];
        
        [webView stringByEvaluatingJavaScriptFromString:js];
        
        [self.loadingView stopAnimating];
        [self.webView setHidden:NO];
    }
}

@end
