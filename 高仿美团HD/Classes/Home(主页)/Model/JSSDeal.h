//
//  JSSDeal.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/12.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

@end
