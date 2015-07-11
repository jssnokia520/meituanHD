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

@interface JSSCategoryController ()

@end

@implementation JSSCategoryController

- (void)loadView
{
    [super loadView];
    
    NSArray *categories = [JSSCategory objectArrayWithFilename:@"categories.plist"];
    JSSDropView *dropView = [JSSDropView dropView];
    dropView.categories = categories;
    self.preferredContentSize = dropView.size;
    self.view = dropView;
}

@end
