//
//  XSTBaseEntity.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/1/29.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTBaseEntity.h"

@implementation XSTBaseEntity

+ (NSString *)createTableSql {
    NSAssert(NO, @"子类事项");
    return @"";
}

+ (NSString *)tableName {
    NSAssert(NO, @"子类事项");
    return @"";
}

- (NSArray *)overKeysWhenInsert {
    return @[@"createDate", @"updateDate"];
}

- (BOOL)virtualDelete {
    self.state = EntityStateDeleted;
    return [mainDB updateWithProtocol:self conditions:@[@"uid"] updateKeys:@[@"state"]];
}

@end
