//
//  JSSRecentViewController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/13.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSRecentViewController.h"
#import "JSSConst.h"
#import "MJRefresh.h"
#import "UIView+AutoLayout.h"
#import "JSSDeal.h"
#import "UIView+Extension.h"
#import "JSSDealCell.h"
#import "JSSDetailViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "JSSDealTool.h"

@interface JSSRecentViewController ()

// 请求返回的数据
@property (nonatomic, strong) NSMutableArray *deals;
// 当前网络请求的页码
@property (nonatomic, assign) NSInteger currentPage;
// 没有符合条件的团购
@property (nonatomic, weak) UIImageView *nowDataImageView;

@end

@implementation JSSRecentViewController

static NSString *const reuseIdentifier = @"deal";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setBackgroundColor:JSSGlobalColor];
    [self.collectionView setAlwaysBounceVertical:YES];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JSSDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 下拉刷新
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    
    [self setTitle:@"最近浏览"];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"icon_back" highlightedImage:@"icon_back_highlighted"]];
    
    [self loadMoreDeals];
    
    [JSSNotificationCenter addObserver:self selector:@selector(collectStateChanged:) name:JSSCollectStateChanged object:nil];
}

- (void)collectStateChanged:(NSNotification *)notification
{
    [self.deals removeAllObjects];
    self.currentPage = 0;
    [self loadMoreDeals];
}

/**
 *  加载更多数据
 */
- (void)loadMoreDeals
{
    self.currentPage++;
    
    NSArray *newDeals = [JSSDealTool recentBrowseDeals:self.currentPage];
    [self.deals addObjectsFromArray:newDeals];
    
    [self.collectionView reloadData];
    [self.collectionView footerEndRefreshing];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)deals
{
    if (_deals == nil) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(305, 305)];
    return [self initWithCollectionViewLayout:layout];
}

- (UIImageView *)nowDataImageView
{
    if (_nowDataImageView == nil) {
        UIImageView *nowDataImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_collects_empty"]];
        [self.view addSubview:nowDataImageView];
        [nowDataImageView autoCenterInSuperview];
        _nowDataImageView = nowDataImageView;
    }
    
    return _nowDataImageView;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSInteger count = (size.width == 1024) ? 3 : 2;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = (size.width - layout.itemSize.width * count) / (count + 1);
    
    // 注意:这里不能设置成collectionView
    [layout setSectionInset:UIEdgeInsetsMake(inset, inset, inset, inset)];
    [layout setMinimumLineSpacing:inset];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [self viewWillTransitionToSize:CGSizeMake(self.collectionView.width, 0) withTransitionCoordinator:nil];
    
    [self.collectionView setFooterHidden:self.deals.count == [JSSDealTool countOfRecentBrowseDeals]];
    
    [self.nowDataImageView setHidden:self.deals.count != 0];
    
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSSDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.deal = self.deals[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSSDetailViewController *detailVc = [[JSSDetailViewController alloc] init];
    [detailVc setDeal:self.deals[indexPath.item]];
    [self presentViewController:detailVc animated:YES completion:nil];
}

@end