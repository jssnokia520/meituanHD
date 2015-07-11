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
#import "JSSConst.h"

@interface JSSDistrictController () <JSSDropViewDataSource, JSSDropViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation JSSDistrictController

- (void)viewDidLoad {
    [super viewDidLoad];

    JSSDropView *dropView = [JSSDropView dropView];
    [dropView setDataSource:self];
    [dropView setDelegate:self];
    [dropView setY:self.bgView.height];
    [self.view addSubview:dropView];
    [self setPreferredContentSize:CGSizeMake(dropView.width, dropView.height + self.bgView.height)];
}

- (IBAction)changeCity:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    JSSCityController *cityVc = [[JSSCityController alloc] init];
    JSSNavigationController *nav = [[JSSNavigationController alloc] initWithRootViewController:cityVc];
    [nav setModalPresentationStyle:UIModalPresentationFormSheet];
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:nav animated:YES completion:nil];
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

- (void)mainTableDidSelectedAtIndex:(NSInteger)mainIndex
{
    JSSRegion *region = self.regions[mainIndex];
    if (region.subregions.count == 0) {
        [JSSNotificationCenter postNotificationName:JSSRegionDidSelected object:nil userInfo:@{JSSSelectedRegion : region}];
    }
}

- (void)subTableDidSelectedAtIndex:(NSInteger)subIndex mainIndex:(NSInteger)mainIndex
{
    JSSRegion *region = self.regions[mainIndex];
    NSArray *subRegions = region.subregions;
    [JSSNotificationCenter postNotificationName:JSSRegionDidSelected object:nil userInfo:@{JSSSelectedRegion : region, JSSSelectedSubRegionName : subRegions[subIndex]}];
}

@end
