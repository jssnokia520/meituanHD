//
//  JSSMainCell.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSMainCell.h"

@implementation JSSMainCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *mainID = @"mainCell";
    
    JSSMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
    if (cell == nil) {
        cell = [[JSSMainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    }
    
    return self;
}

@end
