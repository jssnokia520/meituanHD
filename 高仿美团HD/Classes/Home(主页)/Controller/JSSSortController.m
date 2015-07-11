//
//  JSSSortController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSSortController.h"
#import "JSSMetaTool.h"
#import "JSSSort.h"
#import "UIView+Extension.h"

@interface JSSSortController ()

@end

@implementation JSSSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *sorts = [JSSMetaTool sorts];
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 30;
    CGFloat buttonMargin = 15;
    CGFloat height = 0;
    
    for (NSInteger i = 0; i < sorts.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        
        [button setX:buttonMargin];
        [button setY:buttonMargin + (buttonMargin + buttonHeight) * i];
        [button setWidth:buttonWidth];
        [button setHeight:buttonHeight];
        
        JSSSort *sort = sorts[i];
        [button setTitle:sort.label forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        
        [self.view addSubview:button];
        
        height = CGRectGetMaxY(button.frame);
    }
    
    CGFloat width = buttonWidth + buttonMargin * 2;
    height += buttonMargin;
    [self setPreferredContentSize:CGSizeMake(width, height)];
}

@end
