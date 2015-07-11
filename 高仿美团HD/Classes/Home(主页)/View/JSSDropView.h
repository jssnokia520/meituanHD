//
//  JSSDropView.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSDropView;

@protocol JSSDropViewDataSource <NSObject>

/**
 *  主表行数
 */
- (NSInteger)numberOfRowsInMainTabel;

/**
 *  主表每行标题
 */
- (NSString *)titleForMainTableAtIndex:(NSInteger)index;

/**
 *  主表每行对应的子数组
 */
- (NSArray *)subArrayForMainTableAtIndex:(NSInteger)index;

@optional

/**
 *  主表每行对应的图片
 */
- (NSString *)iconForMainTableAtIndex:(NSInteger)index;

/**
 *  主表每行对应的高亮图片
 */
- (NSString *)highIconForMainTableAtIndex:(NSInteger)index;

@end

@protocol JSSDropViewDelegate <NSObject>

/**
 *  点击主表后执行的代理方法
 */
- (void)mainTableDidSelectedAtIndex:(NSInteger)mainIndex;

/**
 *  点击从表后执行的代理方法
 */
- (void)subTableDidSelectedAtIndex:(NSInteger)subIndex mainIndex:(NSInteger)mainIndex;

@end

@interface JSSDropView : UIView

+ (instancetype)dropView;

@property (nonatomic, weak) id<JSSDropViewDataSource> dataSource;
@property (nonatomic, weak) id<JSSDropViewDelegate> delegate;

@end
