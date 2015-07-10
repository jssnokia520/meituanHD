//
//  JSSSubCell.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSSubCell.h"

@implementation JSSSubCell

/**
 *  快速返回单元格
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *subID = @"subCell";
    JSSSubCell *cell = [tableView dequeueReusableCellWithIdentifier:subID];
    if (cell == nil) {
        cell = [[JSSSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
    }
    
    return self;
}

@end
