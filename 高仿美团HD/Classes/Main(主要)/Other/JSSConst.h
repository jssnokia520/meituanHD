//
//  JSSConst.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSConst : NSObject

#define JSSRandomColor      [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]
#define JSSColor(r, g, b)   [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]

#define JSSNotificationCenter [NSNotificationCenter defaultCenter]

extern NSString * const JSSCityDidSelected;
extern NSString * const JSSSelectedCity;

@end
