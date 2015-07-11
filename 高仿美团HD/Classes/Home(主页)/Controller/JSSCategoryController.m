//
//  JSSCategoryController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSCategoryController.h"
#import "JSSCategory.h"
#import "MJExtension.h"
#import "JSSDropView.h"
#import "UIView+Extension.h"
#import "JSSMetaTool.h"
#import "JSSConst.h"

@interface JSSCategoryController () <JSSDropViewDataSource, JSSDropViewDelegate>

@end

@implementation JSSCategoryController

- (void)loadView
{
    [super loadView];
    
    JSSDropView *dropView = [JSSDropView dropView];
    [dropView setDataSource:self];
    [dropView setDelegate:self];
    self.preferredContentSize = dropView.size;
    self.view = dropView;
}

- (NSInteger)numberOfRowsInMainTabel
{
    return [JSSMetaTool categories].count;
}

- (NSString *)titleForMainTableAtIndex:(NSInteger)index
{
    JSSCategory *category = [JSSMetaTool categories][index];
    return category.name;
}

- (NSArray *)subArrayForMainTableAtIndex:(NSInteger)index
{
    JSSCategory *category = [JSSMetaTool categories][index];
    return category.subcategories;
}

- (NSString *)iconForMainTableAtIndex:(NSInteger)index
{
    JSSCategory *category = [JSSMetaTool categories][index];
    return category.small_icon;
}

- (NSString *)highIconForMainTableAtIndex:(NSInteger)index
{
    JSSCategory *category = [JSSMetaTool categories][index];
    return category.small_highlighted_icon;
}

- (void)mainTableDidSelectedAtIndex:(NSInteger)mainIndex
{
    JSSCategory *category = [JSSMetaTool categories][mainIndex];
    if (category.subcategories == 0) {
        [JSSNotificationCenter postNotificationName:JSSCategoryDidSelected object:nil userInfo:@{JSSSelectedCategory : category}];
    }
}

- (void)subTableDidSelectedAtIndex:(NSInteger)subIndex mainIndex:(NSInteger)mainIndex
{
    JSSCategory *category = [JSSMetaTool categories][mainIndex];
    NSArray *subcategories = category.subcategories;
    [JSSNotificationCenter postNotificationName:JSSCategoryDidSelected object:nil userInfo:@{JSSSelectedCategory : category, JSSSelectedSubCategoryName : subcategories[subIndex]}];
}

@end
