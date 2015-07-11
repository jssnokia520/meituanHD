//
//  JSSSearchController.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSSearchController.h"
#import "JSSCity.h"
#import "MJExtension.h"
#import "JSSConst.h"

@interface JSSSearchController ()

@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation JSSSearchController

/**
 *  搜索文字
 */
- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    NSArray *cities = [JSSCity objectArrayWithFilename:@"cities.plist"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@", searchText, searchText, searchText];
    self.searchResults = [cities filteredArrayUsingPredicate:predicate];
    
    // 刷新表格
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    JSSCity *city = self.searchResults[indexPath.row];
    [cell.textLabel setText:city.name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSSCity *city = self.searchResults[indexPath.row];
    [JSSNotificationCenter postNotificationName:JSSCityDidSelected object:nil userInfo:@{JSSSelectedCity : city.name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
