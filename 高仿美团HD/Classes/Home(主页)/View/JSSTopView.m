//
//  JSSTopView.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTopView.h"

@interface JSSTopView ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation JSSTopView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)topView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JSSTopView" owner:nil options:nil] lastObject];
}

- (void)dealWithTarget:(id)target andAction:(SEL)action
{
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
}

- (void)setSubTitle:(NSString *)subTitle
{
    [self.subTitleLabel setText:subTitle];
}

- (void)setIocn:(NSString *)icon highIcon:(NSString *)highIcon
{
    [self.button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
}

@end
