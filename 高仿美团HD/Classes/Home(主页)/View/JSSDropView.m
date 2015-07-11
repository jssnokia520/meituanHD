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

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation JSSDropView

- (void)awakeFromNib
{
    [self setAutoresizingMask:UIViewAutoresizingNone];
}

+ (instancetype)dropView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JSSDropView" owner:nil options:nil] lastObject];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return [self.dataSource numberOfRowsInMainTabel];
    } else {
        NSArray *subArray = [self.dataSource subArrayForMainTableAtIndex:self.selectedIndex];
        return subArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (tableView == self.mainTableView) {
        cell = [JSSMainCell cellWithTableView:tableView];
        
        [cell.textLabel setText:[self.dataSource titleForMainTableAtIndex:indexPath.row]];
        
        if ([self.dataSource respondsToSelector:@selector(iconForMainTableAtIndex:)]) {
            [cell.imageView setImage:[UIImage imageNamed:[self.dataSource iconForMainTableAtIndex:indexPath.row]]];
        }
        
        if ([self.dataSource respondsToSelector:@selector(highIconForMainTableAtIndex:)]) {
            [cell.imageView setHighlightedImage:[UIImage imageNamed:[self.dataSource highIconForMainTableAtIndex:indexPath.row]]];
        }
        
        NSArray *subArray = [self.dataSource subArrayForMainTableAtIndex:indexPath.row];
        if (subArray.count) {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    } else {
        cell = [JSSSubCell cellWithTableView:tableView];
        
        NSArray *subArray = [self.dataSource subArrayForMainTableAtIndex:self.selectedIndex];
        [cell.textLabel setText:subArray[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        self.selectedIndex = indexPath.row;
        [self.subTableView reloadData];
    }
}

@end
