//
//  JSSCity.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSCity.h"
#import "MJExtension.h"
#import "JSSRegion.h"

@implementation JSSCity

- (NSDictionary *)objectClassInArray
{
    return @{@"regions" : [JSSRegion class]};
}

@end
