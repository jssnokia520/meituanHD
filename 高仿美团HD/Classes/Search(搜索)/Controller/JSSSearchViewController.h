//
//  JSSSearchViewController.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/12.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSSDealsViewController.h"

@interface JSSSearchViewController : JSSDealsViewController

/**
 *  当前选中的城市
 */
@property (nonatomic, copy) NSString *selectedCity;

@end
