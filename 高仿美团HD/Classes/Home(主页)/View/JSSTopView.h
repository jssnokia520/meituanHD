//
//  JSSTopView.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSTopView : UIView

+ (instancetype)topView;

- (void)dealWithTarget:(id)target andAction:(SEL)action;

- (void)setTitle:(NSString *)title;
- (void)setSubTitle:(NSString *)subTitle;
- (void)setIocn:(NSString *)icon highIcon:(NSString *)highIcon;

@end
