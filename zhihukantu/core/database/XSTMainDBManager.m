//
//  XSTMainDBManager.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTMainDBManager.h"

@implementation XSTMainDBManager

+ (instancetype)sharedInstance {
    static XSTMainDBManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XSTMainDBManager alloc] init];
    });
    return instance;
}

- (void)initDataBase {
    NSString * mainDataBasePath = [NSString stringWithFormat:@"%@/main.db", XDirectory.dataBaseDirectory];
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath: mainDataBasePath];
}

- (void)createTables {

}

@end
