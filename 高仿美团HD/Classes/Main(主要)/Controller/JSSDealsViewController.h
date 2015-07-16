//
//  JSSDealsViewController.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/12.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSDealsViewController : UICollectionViewController

- (void)setParams:(NSMutableDictionary *)params;

/**
 *  进行网络请求
 */
- (void)loadNewDeals;

@end
