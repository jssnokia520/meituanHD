//
//  JSSDropView.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDropView.h"
#import "JSSCategory.h"
#import "JSSMainCell.h"
#import "JSSSubCell.h"

@interface JSSDropView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

@property (nonatomic, strong) JSSCategory *selectedCategory;

@end

@implementation JSSDropView

- (void)awakeFromNib
{
    [self setAutoresizingMask:UIViewAutoresizingNone];
}

/**
 *  快速返回控件
 */
+ (instancetype)dropView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JSSDropView" owner:nil options:nil] lastObject];
}

/**
 *  分类模型数组
 */
- (void)setCategories:(NSArray *)categories
{
    _categories = categories;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return self.categories.count;
    } else {
        NSArray *subcategories = self.selectedCategory.subcategories;
        return subcategories.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (tableView == self.mainTableView) {
        cell = [JSSMainCell cellWithTableView:tableView];
        
        JSSCategory *category = self.categories[indexPath.row];
        [cell.textLabel setText:category.name];
        [cell.imageView setImage:[UIImage imageNamed:category.small_icon]];
        
        if (category.subcategories.count) {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    } else {
        cell = [JSSSubCell cellWithTableView:tableView];
        
        NSArray *subcategories = self.selectedCategory.subcategories;
        [cell.textLabel setText:subcategories[indexPath.row]];
        
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        self.selectedCategory = self.categories[indexPath.row];
        [self.subTableView reloadData];
    }
}

@end
