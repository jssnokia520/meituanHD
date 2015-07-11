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
#import "JSSConst.h"

@interface JSSSortButton : UIButton

@property (nonatomic, strong) JSSSort *sort;

@end

@implementation JSSSortButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
    }
    
    return self;
}

- (void)setSort:(JSSSort *)sort
{
    _sort = sort;
    
    [self setTitle:sort.label forState:UIControlStateNormal];
}

@end

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
        JSSSortButton *sortButton = [[JSSSortButton alloc] init];
        [sortButton setSort:sorts[i]];
        
        [sortButton setX:buttonMargin];
        [sortButton setY:buttonMargin + (buttonMargin + buttonHeight) * i];
        [sortButton setWidth:buttonWidth];
        [sortButton setHeight:buttonHeight];
        
        [sortButton addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:sortButton];
        
        height = CGRectGetMaxY(sortButton.frame);
    }
    
    CGFloat width = buttonWidth + buttonMargin * 2;
    height += buttonMargin;
    [self setPreferredContentSize:CGSizeMake(width, height)];
}

- (void)sortButtonClick:(JSSSortButton *)sortButton
{
    [JSSNotificationCenter postNotificationName:JSSSortButtonDidClick object:nil userInfo:@{JSSClickSortButton : sortButton.sort}];
}

@end
