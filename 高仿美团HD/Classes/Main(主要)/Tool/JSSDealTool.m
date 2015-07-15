//
//  JSSDealTool.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/14.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDealTool.h"
#import "FMDB.h"
#import "JSSDeal.h"

@implementation JSSDealTool

static FMDatabase *_db;;

+ (void)initialize
{
    // 打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"deal.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    if (![_db open]) {
        return;
    }
    
    // 创建表
    [_db executeUpdateWithFormat:@"CREATE TABLE IF NOT EXISTS t_collect_deal (id integer PRIMARY KEY, deal blob NOT NULL, deal_id text NOT NULL)"];
    [_db executeUpdateWithFormat:@"CREATE TABLE IF NOT EXISTS t_recent_deal (id integer PRIMARY KEY, deal blob NOT NULL, deal_id text NOT NULL)"];
}

/**
 *  当前第几页收藏的团购
 */
+ (NSArray *)currentCollectWithPage:(NSInteger)page
{
    NSInteger length = 20;
    NSInteger location = (page - 1) * length;
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * FROM t_collect_deal ORDER BY id DESC LIMIT %ld, %ld", location, length];
    NSMutableArray *deals = [NSMutableArray array];
    while (set.next) {
        NSData *data = [set objectForColumnName:@"deal"];
        JSSDeal *deal = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [deals addObject:deal];
    }
    return deals;
}

/**
 *  添加一个团购
 */
+ (void)addCollectWithDeal:(JSSDeal *)deal
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:deal];
    [_db executeUpdateWithFormat:@"INSERT INTO t_collect_deal (deal, deal_id) VALUES (%@, %@)", data, deal.deal_id];
}

/**
 *  移除一个团购
 */
+ (void)removeCollectWithDeal:(JSSDeal *)deal
{
    [_db executeUpdateWithFormat:@"DELETE FROM t_collect_deal WHERE deal_id = %@", deal.deal_id];
}

/**
 *  团购是否已经收藏
 */
+ (BOOL)isCollectWithDeal:(JSSDeal *)deal
{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS deal_count FROM t_collect_deal WHERE deal_id = %@", deal.deal_id];
    [set next];
    return [set intForColumn:@"deal_count"] == 1;
}

/**
 *  当前数据库中的团购数量
 */
+ (NSInteger)countOfCurrentDeals
{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS deal_count FROM t_collect_deal"];
    [set next];
    return [set intForColumn:@"deal_count"];
}

/**
 *  最近第几页浏览的团购
 */
+ (NSArray *)recentBrowseDeals:(NSInteger)page
{
    NSInteger length = 20;
    NSInteger location = (page - 1) * length;
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * FROM t_recent_deal ORDER BY id DESC LIMIT %ld, %ld", location, length];
    NSMutableArray *deals = [NSMutableArray array];
    while (set.next) {
        NSData *data = [set objectForColumnName:@"deal"];
        JSSDeal *deal = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [deals addObject:deal];
    }
    return deals;
}

/**
 *  遍历整个数据库中最近浏览的团购数据
 */
+ (NSArray *)browseDeals
{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * FROM t_recent_deal ORDER BY id DESC"];
    NSMutableArray *deals = [NSMutableArray array];
    while (set.next) {
        NSData *data = [set objectForColumnName:@"deal"];
        JSSDeal *deal = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [deals addObject:deal];
    }
    return deals;
}

/**
 *  当前数据库中最近浏览的团购数量
 */
+ (NSInteger)countOfRecentBrowseDeals
{
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS deal_count FROM t_recent_deal"];
    [set next];
    return [set intForColumn:@"deal_count"];
}

/**
 *  添加一个最近浏览的团购
 */
+ (void)addRecentBrowseDeal:(JSSDeal *)deal
{
    NSArray *deals = [self browseDeals];
    for (JSSDeal *oldDeal in deals) {
        if ([oldDeal.deal_id isEqualToString:deal.deal_id]) {
            [self removeRecentBrowseDeal:deal];
            break;
        }
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:deal];
    [_db executeUpdateWithFormat:@"INSERT INTO t_recent_deal (deal, deal_id) VALUES (%@, %@)", data, deal.deal_id];
}

/**
 *  移除一个最近浏览的团购
 */
+ (void)removeRecentBrowseDeal:(JSSDeal *)deal
{
    [_db executeUpdateWithFormat:@"DELETE FROM t_recent_deal WHERE deal_id = %@", deal.deal_id];
}

@end
