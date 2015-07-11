//
//  JSSDistrictController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDistrictController.h"
#import "JSSDropView.h"
#import "UIView+Extension.h"
#import "JSSCityController.h"
#import "JSSNavigationController.h"
#import "JSSMetaTool.h"
#import "JSSRegion.h"

@interface JSSDistrictController () <JSSDropViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation JSSDistrictController

- (void)viewDidLoad {
    [super viewDidLoad];

    JSSDropView *dropView = [JSSDropView dropView];
    [dropView setDataSource:self];
    [dropView setY:self.bgView.height];
    [self.view addSubview:dropView];
    [self setPreferredContentSize:CGSizeMake(dropView.width, dropView.height + self.bgView.height)];
}

- (IBAction)changeCity:(UIButton *)sender {
    JSSCityController *cityVc = [[JSSCityController alloc] init];
    JSSNavigationController *nav = [[JSSNavigationController alloc] initWithRootViewController:cityVc];
    [nav setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSInteger)numberOfRowsInMainTabel
{
    return self.regions.count;
}

- (NSString *)titleForMainTableAtIndex:(NSInteger)index
{
    JSSRegion *region = self.regions[index];
    return region.name;
}

- (NSArray *)subArrayForMainTableAtIndex:(NSInteger)index
{
    JSSRegion *region = self.regions[index];
    return region.subregions;
}

- (NSString *)iconForMainTableAtIndex:(NSInteger)index
{
    return nil;
}

- (NSString *)highIconForMainTableAtIndex:(NSInteger)index
{
    return nil;
}

@end
