//
//  JSSSearchViewController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/12.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSSearchViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MJRefresh.h"

@interface JSSSearchViewController () <UISearchBarDelegate>

@property (nonatomic, weak) UISearchBar *searchBar;

@end

@implementation JSSSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [searchBar setDelegate:self];
    [searchBar setPlaceholder:@"请输入关键字进行搜索"];
    [self.navigationItem setTitleView:searchBar];
    self.searchBar = searchBar;
    
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"icon_back" highlightedImage:@"icon_back_highlighted"]];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.collectionView headerBeginRefreshing];
    [self.searchBar resignFirstResponder];
}

- (void)setParams:(NSMutableDictionary *)params
{
    params[@"city"] = self.selectedCity;
    params[@"keyword"] = self.searchBar.text;
}

@end
