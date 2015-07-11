//
//  JSSRegion.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSRegion : NSObject

/**
 *  区域名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  子区域
 */
@property (nonatomic, strong) NSArray *subregions;

@end
