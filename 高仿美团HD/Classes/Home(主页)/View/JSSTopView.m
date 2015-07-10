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

@end

@implementation JSSTopView

/**
 *  快速返回控件
 */
+ (instancetype)topView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JSSTopView" owner:nil options:nil] lastObject];
}

/**
 *  事件处理
 */
- (void)dealWithTarget:(id)target andAction:(SEL)action
{
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
