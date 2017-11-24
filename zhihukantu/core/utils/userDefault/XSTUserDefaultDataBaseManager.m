//
//  XSTUserDefaultDataBaseManager.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/23.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTUserDefaultDataBaseManager.h"
#import "XSTUserDefaultModel.h"

@implementation XSTUserDefaultDataBaseManager

+ (instancetype)sharedInstance {
    static XSTUserDefaultDataBaseManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XSTUserDefaultDataBaseManager alloc] init];
    });
    return instance;
}

- (void)initDataBase {
    NSString * mainDataBasePath = [NSString stringWithFormat:@"%@/userDefault.db", XDirectory.dataBaseDirectory];
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath: mainDataBasePath];
}

- (void)createTables {
    [self createTableWithProtocolClassList:@[
                                             [XSTUserDefaultModel class]
                                             ]
     ];
}

@end
