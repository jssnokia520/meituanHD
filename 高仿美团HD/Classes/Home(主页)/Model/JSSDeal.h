//
//  JSSDeal.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/12.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JSSRestrictions;

@interface JSSDeal : NSObject

/**
 *  团购单ID
 */
@property (nonatomic, copy) NSString *deal_id;

/**
 *  团购标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  团购描述
 */
@property (nonatomic, copy) NSString *desc;

/**
 *  团购包含商品原价值
 */
@property (nonatomic, strong) NSNumber *list_price;

/**
 *  团购包含商品原价值
 */
@property (nonatomic, strong) NSNumber *current_price;

/**
 *  团购当前已购买数
 */
@property (nonatomic, assign) NSInteger purchase_count;

/**
 *  团购图片链接，最大图片尺寸450×280
 */
@property (nonatomic, copy) NSString *image_url;

/**
 *  小尺寸团购图片链接，最大图片尺寸160×100
 */
@property (nonatomic, copy) NSString *s_image_url;

/**
 *  团购发布上线日期
 */
@property (nonatomic, copy) NSString *publish_date;

/**
 *  团购Web页面链接，适用于网页应用
 */
@property (nonatomic, copy) NSString *deal_url;

/**
 *  团购HTML5页面链接，适用于移动应用和联网车载应用
 */
@property (nonatomic, copy) NSString *deal_h5_url;

/**
 *  团购单的截止购买日期
 */
@property (nonatomic, copy) NSString *purchase_deadline;

/**
 *  团购限制条件
 */
@property (nonatomic, strong) JSSRestrictions *restrictions;

@end
