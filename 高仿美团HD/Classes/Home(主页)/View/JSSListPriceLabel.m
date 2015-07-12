//
//  JSSListPriceLabel.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/12.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSListPriceLabel.h"

@implementation JSSListPriceLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIRectFill(CGRectMake(0, rect.size.height * 0.3, rect.size.width, 1));
}

@end
