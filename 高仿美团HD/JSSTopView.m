//
//  JSSTopView.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTopView.h"

@implementation JSSTopView

/**
 *  快速返回控件
 */
+ (instancetype)topView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JSSTopView" owner:nil options:nil] lastObject];
}

@end
