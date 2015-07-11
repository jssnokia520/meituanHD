//
//  JSSCity.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSCity : NSObject

/**
 *  城市名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  城市拼音
 */
@property (nonatomic, copy) NSString *pinYin;

/**
 *  城市拼音头部
 */
@property (nonatomic, copy) NSString *pinYinHead;

/**
 *  区域
 */
@property (nonatomic, strong) NSArray *regions;

@end
