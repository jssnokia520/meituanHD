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
}

@end
