//
//  JSSHomeController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSHomeController.h"
#import "JSSConst.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "JSSTopView.h"
#import "JSSCategoryController.h"
#import "JSSDistrictController.h"
#import "JSSMetaTool.h"
#import "JSSCity.h"
#import "JSSSortController.h"
#import "JSSCategory.h"
#import "JSSRegion.h"
#import "JSSSort.h"
#import "DPAPI.h"

@interface JSSHomeController () <DPRequestDelegate>

/**
 *  分类item
 */
@property (nonatomic, weak) UIBarButtonItem *categoryItem;

/**
 *  地区item
 */
@property (nonatomic, weak) UIBarButtonItem *districtItem;

/**
 *  排序item
 */
@property (nonatomic, weak) UIBarButtonItem *sortItem;

/**
 *  选中的城市名称
 */
@property (nonatomic, copy) NSString *selectedCityName;

/**
 *  选中的城市名称
 */
@property (nonatomic, copy) NSString *selectedCategoryName;

/**
 *  选中的城市名称
 */
@property (nonatomic, copy) NSString *selectedRegionName;

/**
 *  选中的城市名称
 */
@property (nonatomic, strong) JSSSort *selectedSort;

@end

@implementation JSSHomeController

- (instancetype)init
{
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setBackgroundColor:JSSColor(230, 230, 230)];
    
    /**
     *  添加导航栏左边的子控件
     */
    [self setupLeftView];
    
    /**
     *  添加导航栏右边的子控件
     */
    [self setupRightView];
    
    // 接收城市通知
    [JSSNotificationCenter addObserver:self selector:@selector(cityDidSelected:) name:JSSCityDidSelected object:nil];
    // 接收分类通知
    [JSSNotificationCenter addObserver:self selector:@selector(categoryDidSelected:) name:JSSCategoryDidSelected object:nil];
    // 接收区域的通知
    [JSSNotificationCenter addObserver:self selector:@selector(regionDidSelected:) name:JSSRegionDidSelected object:nil];
    // 接收排序的通知
    [JSSNotificationCenter addObserver:self selector:@selector(sortDidSelected:) name:JSSSortButtonDidClick object:nil];
}

/**
 *  接收排序的通知
 */
- (void)sortDidSelected:(NSNotification *)notification
{
    self.selectedSort = notification.userInfo[JSSClickSortButton];
    JSSTopView *sortTopView = (JSSTopView *)self.sortItem.customView;
    [sortTopView setTitle:self.selectedSort.label];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self loadNewDeals];
}

/**
 *  接收区域的通知
 */
- (void)regionDidSelected:(NSNotification *)notification
{
    JSSRegion *region = notification.userInfo[JSSSelectedRegion];
    NSString *subRegionName = notification.userInfo[JSSSelectedSubRegionName];
    
    if ([region.name isEqualToString:@"全部"]) {
        self.selectedRegionName = nil;
    } else if (!subRegionName || [subRegionName isEqualToString:@"全部"]) {
        self.selectedRegionName = region.name;
    } else {
        self.selectedRegionName = subRegionName;
    }
    
    JSSTopView *regionTopView = (JSSTopView *)self.districtItem.customView;
    [regionTopView setTitle:[NSString stringWithFormat:@"%@ - %@", self.selectedCityName, region.name]];
    [regionTopView setSubTitle:subRegionName];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self loadNewDeals];
}

/**
 *  接收分类通知
 */
- (void)categoryDidSelected:(NSNotification *)notification
{
    JSSCategory *category = notification.userInfo[JSSSelectedCategory];
    NSString *subCategoryName = notification.userInfo[JSSSelectedSubCategoryName];
    
    if ([category.name isEqualToString:@"全部分类"]) {
        self.selectedCategoryName = nil;
    } else if (!subCategoryName || [subCategoryName isEqualToString:@"全部"]) {
        self.selectedCategoryName = category.name;
    } else {
        self.selectedCategoryName = subCategoryName;
    }
    
    JSSTopView *categoryDropView = (JSSTopView *)self.categoryItem.customView;
    [categoryDropView setTitle:category.name];
    [categoryDropView setSubTitle:subCategoryName];
    [categoryDropView setIocn:category.icon highIcon:category.highlighted_icon];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self loadNewDeals];
}

/**
 *  接收城市通知
 */
- (void)cityDidSelected:(NSNotification *)notification
{
    self.selectedCityName = notification.userInfo[JSSSelectedCity];
    JSSTopView *districtTopView = (JSSTopView *)self.districtItem.customView;
    [districtTopView setTitle:[NSString stringWithFormat:@"%@ - 全部", self.selectedCityName]];
    
    [self loadNewDeals];
}

/**
 *  进行网络请求
 */
- (void)loadNewDeals
{
    DPAPI *api = [[DPAPI alloc] init];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.selectedCityName;
    params[@"limit"] = @(10);
    
    if (self.selectedCategoryName) {
        params[@"category"] = self.selectedCategoryName;
    }
    
    if (self.selectedRegionName) {
        params[@"region"] = self.selectedRegionName;
    }
    
    if (self.selectedSort) {
        params[@"sort"] = @(self.selectedSort.value);
    }
    
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"请求成功--%@", result);
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"请求失败--%@", error);
}

- (void)dealloc
{
    [JSSNotificationCenter removeObserver:self];
}

/**
 *  添加导航栏左边的子控件
 */
- (void)setupLeftView
{
    // 1.LOGO
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"]];
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithCustomView:logoView];
    
    // 2.类别
    JSSTopView *categoryView = [JSSTopView topView];
    [categoryView dealWithTarget:self andAction:@selector(categoryViewDidClick)];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    self.categoryItem = categoryItem;
    
    // 3.地区
    JSSTopView *districtView = [JSSTopView topView];
    [districtView dealWithTarget:self andAction:@selector(districtViewDidClick)];
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    self.districtItem = districtItem;
    
    // 4.排序
    JSSTopView *sortView = [JSSTopView topView];
    [sortView setIocn:@"icon_sort" highIcon:@"icon_sort_highlighted"];
    [sortView dealWithTarget:self andAction:@selector(sortViewDidClick)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortView];
    self.sortItem = sortItem;
    
    [self.navigationItem setLeftBarButtonItems:@[logoItem, categoryItem, districtItem, sortItem]];
}

/**
 *  类别点击监听方法
 */
- (void)categoryViewDidClick
{
    JSSCategoryController *categoryVc = [[JSSCategoryController alloc] init];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:categoryVc];
    [popover presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/**
 *  地区点击监听方法
 */
- (void)districtViewDidClick
{
    JSSDistrictController *districtVc = [[JSSDistrictController alloc] init];
    if (self.selectedCityName) {
        JSSCity *city = [[[JSSMetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@", self.selectedCityName]] firstObject];
        [districtVc setRegions:city.regions];
    }
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:districtVc];
    [popover presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/**
 *  排序点击监听方法
 */
- (void)sortViewDidClick
{
    JSSSortController *sortVc = [[JSSSortController alloc] init];
    UIPopoverController *popoverVc = [[UIPopoverController alloc] initWithContentViewController:sortVc];
    [popoverVc presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/**
 *  添加导航栏右边的子控件
 */
- (void)setupRightView
{
    UIBarButtonItem *mapItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_map" highlightedImage:@"icon_map_highlighted"];
    [mapItem.customView setWidth:60];
    
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_search" highlightedImage:@"icon_search_highlighted"];
    [searchItem.customView setWidth:60];
    [self.navigationItem setRightBarButtonItems:@[mapItem, searchItem]];
}

@end
