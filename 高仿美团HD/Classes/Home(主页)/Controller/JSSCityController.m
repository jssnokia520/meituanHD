//
//  JSSCityController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSCityController.h"
#import "UIBarButtonItem+Extension.h"
#import "JSSCityGroup.h"
#import "MJExtension.h"
#import "JSSConst.h"
#import "JSSSearchController.h"
#import "UIView+AutoLayout.h"

@interface JSSCityController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *coverButton;

@property (nonatomic, strong) NSArray *citygroups;
@property (nonatomic, weak) JSSSearchController *searchVc;

@end

@implementation JSSCityController

- (JSSSearchController *)searchVc
{
    if (_searchVc == nil) {
        JSSSearchController *searchVc = [[JSSSearchController alloc] init];
        [self addChildViewController:searchVc];
        [self.view addSubview:searchVc.tableView];
        
        [searchVc.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [searchVc.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar];
        
        _searchVc = searchVc;
    }
    return _searchVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSectionIndexColor:[UIColor blackColor]];
    [self.searchBar setTintColor:JSSColor(20, 178, 160)];
    
    [self setTitle:@"切换城市"];
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" highlightedImage:@"btn_navigation_close_hl"];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    self.citygroups = [JSSCityGroup objectArrayWithFilename:@"cityGroups.plist"];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.citygroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JSSCityGroup *cityGroup = self.citygroups[section];
    return cityGroup.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    JSSCityGroup *cityGroup = self.citygroups[indexPath.section];
    NSArray *cities = cityGroup.cities;
    [cell.textLabel setText:cities[indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    JSSCityGroup *cityGroup = self.citygroups[section];
    return cityGroup.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.citygroups valueForKey:@"title"];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 1.隐藏导航条
    [self.navigationController setNavigationBarHidden:YES];
    
    // 2.添加蒙板
    [UIView animateWithDuration:0.5 animations:^{
        [self.coverButton setAlpha:0.5];
    }];
    
    // 3.添加取消按钮
    [self.searchBar setShowsCancelButton:YES animated:YES];
    
    // 4.搜索框背景
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 1.显示导航条
    [self.navigationController setNavigationBarHidden:NO];
    
    // 2.移除蒙板
    [UIView animateWithDuration:0.5 animations:^{
        [self.coverButton setAlpha:0];
    }];
    
    // 3.移除取消按钮
    [self.searchBar setShowsCancelButton:NO animated:YES];
    
    // 4.搜索框背景
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
}

- (IBAction)coverButtonClick {
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverButtonClick];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        [self.searchVc.tableView setHidden:NO];
        [self.searchVc setSearchText:searchText];
    } else {
        [self.searchVc.tableView setHidden:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSSCityGroup *cityGroup = self.citygroups[indexPath.section];
    NSArray *cities = cityGroup.cities;
    [JSSNotificationCenter postNotificationName:JSSCityDidSelected object:nil userInfo:@{JSSSelectedCity : cities[indexPath.row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
