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

@interface JSSHomeController ()

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

@end

@implementation JSSHomeController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setBackgroundColor:JSSColor(230, 230, 230)];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    /**
     *  添加导航栏左边的子控件
     */
    [self setupLeftView];
    
    /**
     *  添加导航栏右边的子控件
     */
    [self setupRightView];
    
    [JSSNotificationCenter addObserver:self selector:@selector(cityDidSelected:) name:JSSCityDidSelected object:nil];
}

- (void)cityDidSelected:(NSNotification *)notification
{
    NSString *cityName = notification.userInfo[JSSSelectedCity];
    JSSTopView *districtTopView = (JSSTopView *)self.districtItem.customView;
    [districtTopView setTitle:[NSString stringWithFormat:@"%@-全部", cityName]];
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
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:districtVc];
    [popover presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/**
 *  排序点击监听方法
 */
- (void)sortViewDidClick
{
    
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

@end
