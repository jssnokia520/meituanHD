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

@interface JSSCityController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, weak) UIView *cover;
@property (nonatomic, strong) NSArray *citygroups;

@end

@implementation JSSCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSectionIndexColor:[UIColor blackColor]];
    
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
    UIView *cover = [[UIView alloc] initWithFrame:self.tableView.frame];
    [cover setBackgroundColor:JSSColor(82, 84, 87)];
    [cover setAlpha:0.5];
    self.cover = cover;
    [self.view addSubview:cover];
    
    // 3.搜索框背景
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 1.显示导航条
    [self.navigationController setNavigationBarHidden:NO];
    
    // 2.移除蒙板
    [self.cover removeFromSuperview];
    
    // 3.搜索框背景
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
}

@end
