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
#import "JSSTopView.h"
#import "JSSCategoryController.h"
#import "JSSDistrictController.h"
#import "JSSMetaTool.h"
#import "JSSCity.h"
#import "JSSSortController.h"
#import "JSSCategory.h"
#import "JSSRegion.h"
#import "JSSSort.h"
#import "MJRefresh.h"
#import "JSSSearchViewController.h"
#import "JSSNavigationController.h"
#import "UIView+Extension.h"
#import "AwesomeMenu.h"
#import "UIView+AutoLayout.h"
#import "JSSCollectViewController.h"
#import "JSSRecentViewController.h"
#import "MBProgressHUD+MJ.h"

@interface JSSHomeController () <AwesomeMenuDelegate>

// 分类item
@property (nonatomic, weak) UIBarButtonItem *categoryItem;
// 地区item
@property (nonatomic, weak) UIBarButtonItem *districtItem;
// 排序item
@property (nonatomic, weak) UIBarButtonItem *sortItem;
// 选中的城市名称
@property (nonatomic, copy) NSString *selectedCityName;
// 选中的分类名称
@property (nonatomic, copy) NSString *selectedCategoryName;
// 选中的区域称
@property (nonatomic, copy) NSString *selectedRegionName;
// 选中的排序模型
@property (nonatomic, strong) JSSSort *selectedSort;

@end

@implementation JSSHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedCityName = @"成都";
    
    // 添加导航栏左边的子控件
    [self setupLeftView];
    // 添加导航栏右边的子控件
    [self setupRightView];
    
    // 接收城市通知
    [JSSNotificationCenter addObserver:self selector:@selector(cityDidSelected:) name:JSSCityDidSelected object:nil];
    // 接收分类通知
    [JSSNotificationCenter addObserver:self selector:@selector(categoryDidSelected:) name:JSSCategoryDidSelected object:nil];
    // 接收区域的通知
    [JSSNotificationCenter addObserver:self selector:@selector(regionDidSelected:) name:JSSRegionDidSelected object:nil];
    // 接收排序的通知
    [JSSNotificationCenter addObserver:self selector:@selector(sortDidSelected:) name:JSSSortButtonDidClick object:nil];
    
    // 创建左下角动画弹出菜单
    [self setupAweMenu];

    // 首次请求网络
    [self loadNewDeals];
}

/**
 *  创建左下角动画弹出菜单
 */
- (void)setupAweMenu {
    // 开始按钮
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    
    // 其他按钮
    AwesomeMenuItem *item1 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_highlighted"]];
    AwesomeMenuItem *item2 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    AwesomeMenuItem *item3 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_highlighted"]];
    AwesomeMenuItem *item4 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_more_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_more_highlighted"]];
    
    NSArray *items = @[item1, item2, item3, item4];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem optionMenus:items];
    [menu setBackgroundColor:[UIColor orangeColor]];
    [menu setDelegate:self];
    [menu setAlpha:0.3];
    [menu setRotateAddButton:NO];
    [menu setMenuWholeAngle:M_PI_2];
    [self.view addSubview:menu];
    
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-100];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:300];
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    [menu setAlpha:1];
    [menu setContentImage:[UIImage imageNamed:@"icon_pathMenu_cross_normal"]];
    [menu setHighlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_cross_highlighted"]];
}

- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu
{
    [menu setAlpha:0.3];
    [menu setContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"]];
    [menu setHighlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    [self awesomeMenuDidFinishAnimationClose:menu];
    
    switch (idx) {
        case 1:
        {
            JSSCollectViewController *collectVc = [[JSSCollectViewController alloc] init];
            JSSNavigationController *nav = [[JSSNavigationController alloc] initWithRootViewController:collectVc];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
            
        case 2:
        {
            JSSRecentViewController *recentVc = [[JSSRecentViewController alloc] init];
            JSSNavigationController *nav = [[JSSNavigationController alloc] initWithRootViewController:recentVc];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

/**
 *  移除通知
 */
- (void)dealloc
{
    [JSSNotificationCenter removeObserver:self];
}

/**
 *  接收排序的通知
 */
- (void)sortDidSelected:(NSNotification *)notification
{
    self.selectedSort = notification.userInfo[JSSClickSortButton];
    JSSTopView *sortTopView = (JSSTopView *)self.sortItem.customView;
    [sortTopView setSubTitle:self.selectedSort.label];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 刷新数据
    [self.collectionView headerBeginRefreshing];
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
    
    // 刷新数据
    [self.collectionView headerBeginRefreshing];
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
    
    // 刷新数据
    [self.collectionView headerBeginRefreshing];
}

/**
 *  接收城市通知
 */
- (void)cityDidSelected:(NSNotification *)notification
{
    self.selectedCityName = notification.userInfo[JSSSelectedCity];
    JSSTopView *districtTopView = (JSSTopView *)self.districtItem.customView;
    [districtTopView setTitle:[NSString stringWithFormat:@"%@ - 全部", self.selectedCityName]];
    
    // 刷新数据
    [self.collectionView headerBeginRefreshing];
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
    [categoryView setTitle:@"全部分类"];
    [categoryView setSubTitle:nil];
    [categoryView setIocn:@"icon_category_-1" highIcon:@"icon_category_highlighted_-1"];
    [categoryView dealWithTarget:self andAction:@selector(categoryViewDidClick)];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    self.categoryItem = categoryItem;
    
    // 3.地区
    JSSTopView *districtView = [JSSTopView topView];
    [districtView setTitle:[NSString stringWithFormat:@"%@ - 全部", self.selectedCityName]];
    [districtView setSubTitle:nil];
    [districtView dealWithTarget:self andAction:@selector(districtViewDidClick)];
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    self.districtItem = districtItem;
    
    // 4.排序
    JSSTopView *sortView = [JSSTopView topView];
    [sortView setTitle:@"排序"];
    [sortView setSubTitle:@"默认排序"];
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
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"icon_search" highlightedImage:@"icon_search_highlighted"]];
}

/**
 *  点击导航栏右边的搜索按钮
 */
- (void)searchClick
{
    if (self.selectedCityName) {
        JSSSearchViewController *searchVc = [[JSSSearchViewController alloc] init];
        [searchVc setSelectedCity:self.selectedCityName];
        JSSNavigationController *nav = [[JSSNavigationController alloc] initWithRootViewController:searchVc];
        [self presentViewController:nav animated:YES completion:nil];
    } else {
        [MBProgressHUD showError:@"当前没有选中的城市!" toView:self.view];
    }
}

- (void)setParams:(NSMutableDictionary *)params
{
    params[@"city"] = self.selectedCityName;
    
    if (self.selectedCategoryName) {
        params[@"category"] = self.selectedCategoryName;
    }
    
    if (self.selectedRegionName) {
        params[@"region"] = self.selectedRegionName;
    }
    
    if (self.selectedSort) {
        params[@"sort"] = @(self.selectedSort.value);
    }
}

@end
