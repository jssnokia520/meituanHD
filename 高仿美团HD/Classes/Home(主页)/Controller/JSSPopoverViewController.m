//
//  JSSPopoverViewController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSPopoverViewController.h"
#import "JSSCategory.h"
#import "MJExtension.h"
#import "JSSDropView.h"
#import "UIView+Extension.h"

@interface JSSPopoverViewController ()

@end

@implementation JSSPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *categories = [JSSCategory objectArrayWithFilename:@"categories.plist"];
    JSSDropView *dropView = [JSSDropView dropView];
    dropView.categories = categories;
    // 设置弹出视图的大小
    self.preferredContentSize = dropView.size;
    [self.view addSubview:dropView];
}

@end
