//
//  XSTUserDefaultModel.m
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/31.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import "XSTUserDefaultModel.h"

@interface XSTUserDefaultModel ()

@end

@implementation XSTUserDefaultModel

+ (NSString *)createTableSql {
    NSString * createSQL = @"CREATE TABLE IF NOT EXISTS kwconfig ("
    "key        CHAR(256) PRIMARY KEY,"
    "value      TEXT"
    ");";
    return createSQL;
}

+ (NSString *)tableName {
    return @"kwconfig";
}

+ (NSArray<NSString *> *)tableKeys {
    return @[@"key", @"value"];
}

@end
