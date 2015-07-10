//
//  JSSCategory.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSCategory : NSObject

/**
 *  分类名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  普通图片
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  普通高亮图片
 */
@property (nonatomic, copy) NSString *highlighted_icon;

/**
 *  小图片
 */
@property (nonatomic, copy) NSString *small_icon;

/**
 *  高亮小图片
 */
@property (nonatomic, copy) NSString *small_highlighted_icon;

/**
 *  地图图片
 */
@property (nonatomic, copy) NSString *map_icon;

/**
 *  子分类数组
 */
@property (nonatomic, strong) NSArray *subcategories;

@end
