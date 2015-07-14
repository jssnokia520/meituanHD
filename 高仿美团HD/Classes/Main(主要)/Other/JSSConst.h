//
//  JSSConst.h
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSConst : NSObject

#define JSSColor(r, g, b)   [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define JSSGlobalColor JSSColor(230, 230, 230)

#define JSSNotificationCenter [NSNotificationCenter defaultCenter]

extern NSString * const JSSCityDidSelected;
extern NSString * const JSSSelectedCity;

extern NSString * const JSSCategoryDidSelected;
extern NSString * const JSSSelectedCategory;
extern NSString * const JSSSelectedSubCategoryName;

extern NSString * const JSSRegionDidSelected;
extern NSString * const JSSSelectedRegion;
extern NSString * const JSSSelectedSubRegionName;

extern NSString * const JSSSortButtonDidClick;
extern NSString * const JSSClickSortButton;

extern NSString * const JSSCollectStateChanged;
extern NSString * const JSSAddCollect;
extern NSString * const JSSRemoveCollect;

@end
