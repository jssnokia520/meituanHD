//
//  JSSDealCell.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/12.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDealCell.h"
#import "UIImageView+WebCache.h"

@interface JSSDealCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dealNewImageView;

@end

@implementation JSSDealCell

- (void)awakeFromNib
{
    [self setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]]];
}

- (void)setDeal:(JSSDeal *)deal
{
    _deal = deal;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    [self.titleLabel setText:deal.title];
    [self.descriptionLabel setText:deal.desc];
    [self.currentPriceLabel setText:[self exchangePrice:deal.current_price]];
    [self.listPriceLabel setText:[self exchangePrice:deal.list_price]];
    [self.purchaseCountLabel setText:[NSString stringWithFormat:@"已售%ld", deal.purchase_count]];
    
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowDateStr = [formatter stringFromDate:nowDate];
    
    [self.dealNewImageView setHidden:[deal.publish_date compare:nowDateStr] == NSOrderedAscending];
}

- (NSString *)exchangePrice:(NSNumber *)number
{
    NSRange range = [number.stringValue rangeOfString:@"."];
    if (range.location != NSNotFound) {
        NSString *price = [number.stringValue substringWithRange:NSMakeRange(0, range.location + 2)];
        return [NSString stringWithFormat:@"￥%@", price];
    }
    
    return [NSString stringWithFormat:@"￥%@", number.stringValue];
}

@end
