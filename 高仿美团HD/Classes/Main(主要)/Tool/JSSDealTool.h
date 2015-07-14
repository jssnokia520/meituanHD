//
//  JSSDealTool.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/14.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSDeal;

@interface JSSDealTool : NSObject

/**
 *  当前第几页收藏的团购
 */
+ (NSArray *)currentCollectWithPage:(NSInteger)page;

/**
 *  添加一个团购
 */
+ (void)addCollectWithDeal:(JSSDeal *)deal;

/**
 *  移除一个团购
 */
+ (void)removeCollectWithDeal:(JSSDeal *)deal;

/**
 *  团购是否已经收藏
 */
+ (BOOL)isCollectWithDeal:(JSSDeal *)deal;


@end
