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
#import "JSSListPriceLabel.h"
#import "UIImageView+WebCache.h"
#import "DPAPI.h"
#import "MJExtension.h"
#import "JSSRestrictions.h"
#import "JSSDealTool.h"
#import "MBProgressHUD+MJ.h"
#import "UMSocial.h"

@interface JSSDetailViewController () <UIWebViewDelegate,  DPRequestDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet JSSListPriceLabel *listPrice;
@property (weak, nonatomic) IBOutlet UIButton *refundAnyTime;
@property (weak, nonatomic) IBOutlet UIButton *refundExpire;
@property (weak, nonatomic) IBOutlet UIButton *countDown;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

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
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.deal.image_url]];
    [self.titleLabel setText:self.deal.title];
    [self.descLabel setText:self.deal.desc];
    [self.currentPrice setText:[NSString stringWithFormat:@"￥%@", self.deal.current_price.stringValue]];
    [self.listPrice setText:[NSString stringWithFormat:@"原价￥%@", self.deal.list_price.stringValue]];
    [self.purchaseCount setTitle:[NSString stringWithFormat:@"已售%ld", self.deal.purchase_count] forState:UIControlStateNormal];
    
    // 设置倒计时
    [self setupCountDown:self.deal.purchase_deadline];
    
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"deal_id"] = self.deal.deal_id;
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
    
    // 判断此团购是否已经收藏
    [self.collectButton setSelected:[JSSDealTool isCollectWithDeal:self.deal]];
}

/**
 *  设置倒计时
 */
- (void)setupCountDown:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *deadDate = [formatter dateFromString:dateStr];
    deadDate = [deadDate dateByAddingTimeInterval:24 * 3600];
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *result = [calendar components:unit fromDate:nowDate toDate:deadDate options:0];
    
    if (result.day > 365) {
        [self.countDown setTitle:@"一年内不过期" forState:UIControlStateNormal];
    } else {
        [self.countDown setTitle:[NSString stringWithFormat:@"剩余%ld天%ld时%ld分", result.day, result.hour, result.minute] forState:UIControlStateNormal];
    }
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    self.deal = [JSSDeal objectWithKeyValues:[result[@"deals"] lastObject]];
    JSSRestrictions *restrictions = self.deal.restrictions;
    [self.refundAnyTime setSelected:restrictions.is_refundable];
    [self.refundExpire setSelected:restrictions.is_refundable];
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

/**
 *  收藏团购
 */
- (IBAction)collectDeal {
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    if ([self.collectButton isSelected]) {
        [JSSDealTool removeCollectWithDeal:self.deal];
        [self.collectButton setSelected:NO];
        
        [MBProgressHUD showSuccess:@"取消收藏" toView:self.view];
        
        info[JSSRemoveCollect] = self.deal;
    } else {
        [JSSDealTool addCollectWithDeal:self.deal];
        [self.collectButton setSelected:YES];
        
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
        
        info[JSSAddCollect] = self.deal;
    }
    
    [JSSNotificationCenter postNotificationName:JSSCollectStateChanged object:nil userInfo:info];
}

- (IBAction)share {
    NSString *shareText = [NSString stringWithFormat:@"%@ %@", self.deal.desc, self.deal.deal_url];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55a66d1c67e58e5436004bbc"
                                      shareText:shareText
                                     shareImage:self.imageView.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToFacebook,UMShareToDouban,UMShareToQzone,UMShareToRenren,UMShareToSms,UMShareToTwitter,nil]
                                       delegate:nil];
}

- (IBAction)buyNow {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.deal.deal_h5_url]];
}

@end
