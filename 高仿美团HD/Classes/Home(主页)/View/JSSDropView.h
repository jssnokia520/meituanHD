//
//  JSSDropView.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSDropView : UIView

/**
 *  快速返回控件
 */
+ (instancetype)dropView;

/**
 *  分类模型数组
 */
@property (nonatomic, strong) NSArray *categories;

@end
