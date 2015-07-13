//
//  JSSDealsViewController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/12.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDealsViewController.h"
#import "MBProgressHUD+MJ.h"
#import "DPAPI.h"
#import "JSSConst.h"
#import "MJRefresh.h"
#import "UIView+AutoLayout.h"
#import "JSSDeal.h"
#import "UIView+Extension.h"
#import "JSSDealCell.h"
#import "MJExtension.h"
#import "JSSDetailViewController.h"

@interface JSSDealsViewController () <DPRequestDelegate>

// 请求返回的数据
@property (nonatomic, strong) NSMutableArray *deals;
// 当前网络请求的页码
@property (nonatomic, assign) NSInteger currentPage;
// 最后一次网络请求
@property (nonatomic, strong) DPRequest *lastRequest;
// 没有符合条件的团购
@property (nonatomic, weak) UIImageView *nowDataImageView;
// 总数量
@property (nonatomic, assign) NSInteger count;

@end

@implementation JSSDealsViewController

static NSString *const reuseIdentifier = @"deal";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setBackgroundColor:JSSGlobalColor];
    [self.collectionView setAlwaysBounceVertical:YES];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JSSDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 上拉刷新
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    // 下拉刷新
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewDeals)];
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
        UIImageView *nowDataImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
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

/**
 *  加载数据
 */
- (void)loadDeals
{
    DPAPI *api = [[DPAPI alloc] init];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"limit"] = @(12);
    params[@"page"] = @(self.currentPage);
    [self setParams:params];
    
    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

/**
 *  下拉加载更多数据
 */
- (void)loadMoreDeals
{
    self.currentPage++;
    
    [self loadDeals];
}

/**
 *  进行网络请求
 */
- (void)loadNewDeals
{
    self.currentPage = 1;
    
    [self loadDeals];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    if (self.lastRequest != request) {
        return;
    }
    
    self.count = [result[@"total_count"] integerValue];
    
    NSArray *deals = [JSSDeal objectArrayWithKeyValuesArray:result[@"deals"]];
    if (self.currentPage == 1) {
        [self.deals removeAllObjects];
    }
    [self.deals addObjectsFromArray:deals];
    
    // 刷新数据
    [self.collectionView reloadData];
    
    // 结束刷新
    [self.collectionView footerEndRefreshing];
    [self.collectionView headerEndRefreshing];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"请求失败-%@", error);
    
    [MBProgressHUD showError:@"网络繁忙,请稍后再试!" toView:self.view];
    
    if (self.currentPage > 1) {
        self.currentPage--;
    }
    
    // 结束刷新
    [self.collectionView footerEndRefreshing];
    [self.collectionView headerEndRefreshing];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [self viewWillTransitionToSize:CGSizeMake(self.collectionView.width, 0) withTransitionCoordinator:nil];
    
    [self.collectionView setFooterHidden:self.deals.count == self.count];
    
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
