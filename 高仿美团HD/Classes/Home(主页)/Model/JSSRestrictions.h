//
//  JSSRestrictions.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/14.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSRestrictions : NSObject

/**
 *  是否需要预约，0：不是，1：是
 */
@property (nonatomic, assign) NSInteger is_reservation_required;

/**
 *  是否支持随时退款，0：不是，1：是
 */
@property (nonatomic, assign) NSInteger is_refundable;

/**
 *  附加信息(一般为团购信息的特别提示)
 */
@property (nonatomic, copy) NSString *special_tips;

@end
