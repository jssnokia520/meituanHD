//
//  JSSMetaTool.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSMetaTool.h"
#import "JSSCategory.h"
#import "JSSCity.h"
#import "MJExtension.h"

static NSArray *_categories;
static NSArray *_cities;

@implementation JSSMetaTool

/**
 *  分类数据
 */
+ (NSArray *)categories
{
    if (_categories == nil) {
        _categories = [JSSCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

/**
 *  城市数据
 */
+ (NSArray *)cities
{
    if (_cities == nil) {
        _cities = [JSSCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

@end
