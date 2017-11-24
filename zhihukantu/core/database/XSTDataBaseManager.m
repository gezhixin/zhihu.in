//
//  XSTDataBaseManager.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/4.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTDataBaseManager.h"
#import "XSTBaseEntity.h"

#define MAIN_DATA_BASE_VERSION  0X01

@interface XSTDataBaseManager () {
    
}

@end

@implementation XSTDataBaseManager

+ (instancetype)sharedInstance {
    static XSTDataBaseManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XSTDataBaseManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDataBase];
        [self createTables];
        [self upgradeDataBase];
    }
    return self;
}

- (void)upgradeDataBase {
}

- (void)initDataBase {
    //创建数据库
    NSAssert(NO, @"子类实现");
}

- (void)createTables {
    NSAssert(NO, @"子类实现");
}

- (BOOL)createTableWithProtocolClass:(Class<XSTDBProtocol>)clas {
    NSString * createTableSql = [clas createTableSql];
    __block BOOL retValue = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        retValue = [db executeUpdate:createTableSql];
        if (retValue == NO) {
            NSLog(@"创建表 ： %@ 失败", [clas tableName]);
        }
    }];
    return retValue;
}

- (void)createTableWithProtocolClassList:(NSArray<Class<XSTDBProtocol>> *)clasList {
    for (Class<XSTDBProtocol> clas in clasList) {
        [self createTableWithProtocolClass:clas];
    }
}

- (BOOL)hasDataWithProtocol:(id<XSTDBProtocol>)protocol conditions:(NSArray *)conditions {
    if (protocol == nil) {
        NSLog(@"XSTDBProtocol 不能为空");
        return NO;
    }
    
    NSString * tableName = [protocol.class tableName];
    NSObject * obj = (NSObject *)protocol;
    NSDictionary * dic = [obj yy_modelToJSONObject];
    
    NSAssert(dic && tableName, @"表名称未提供或者map为空");
    
    NSMutableString *querySql = [[NSMutableString alloc] initWithFormat:@"SELECT * FROM %@ ", tableName];
    
    NSMutableString * con = [[NSString stringWithFormat:@" WHERE %@=:%@ ", conditions[0], conditions[0]] mutableCopy];
    
    int length = (int)[conditions count];
    if (length > 1) {
        for (int i = 1; i<length; i++) {
            [con appendFormat:@"AND %@=:%@ ", conditions[i], conditions[i]];
        }
    }
    
    [querySql appendString: con];
    
    __block BOOL  hasData = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQuery:querySql withParameterDictionary:[dic dictionaryWithValuesForKeys:conditions]];
        hasData = [set next];
        [set close];
        
    }];
    
    return hasData;
}

- (NSArray *)queryWithProtocol:(NSObject<XSTDBProtocol> *)protocol conditions:(NSArray<NSString *>*)conditions queryType:(XSTDataBaseQueryType)queryType {
    if (protocol == nil) {
        NSLog(@"XSTDBProtocol 不能为空");
        return nil;
    }
    
    NSString * tableName = [protocol.class tableName];
    NSObject * obj = (NSObject *)protocol;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:[obj yy_modelToJSONObject]];
    
    NSAssert(dic && tableName && [conditions count] > 0, @"表名称未提供或者map为空");
    
    NSMutableString *queryStr = [[NSMutableString alloc] initWithFormat:@"SELECT * FROM %@ ", tableName];
    
    NSMutableString * con = [[NSString stringWithFormat:@" WHERE %@=:%@ ", conditions[0], conditions[0]] mutableCopy];
    
    NSString * queryTypeStr = queryType == XSTDataBaseQueryTypeAnd ? @"AND" : @"OR";
    for (int i = 1; i<conditions.count; i++) {
        NSString * key = conditions[i];
        [con appendFormat:@"%@ %@=:%@ ", queryTypeStr, key, key];
    }
    
    [queryStr appendString: con];
    
    NSMutableArray * resultList = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQuery:queryStr withParameterDictionary:[dic dictionaryWithValuesForKeys:conditions]];
        while ([set next]) {
            NSObject * queryedObj = [obj.class yy_modelWithDictionary:[set resultDictionary]];
            [resultList addObject:queryedObj];
        }
        
        [set close];
    }];
    
    return resultList.count > 0 ? resultList : nil;
}

- (int64_t)insertWithProtocol:(id<XSTDBProtocol>)protocol {
    
    if (protocol == nil) {
        NSLog(@"XSTDBProtocol 不能为空");
        return -1;
    }
    
    NSString * tableName = [protocol.class tableName];
    NSObject * obj = (NSObject *)protocol;
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[obj yy_modelToJSONObject]];
    
    NSArray * overKeys = nil;
    if ([protocol respondsToSelector:@selector(overKeysWhenInsert)]) {
        overKeys = [protocol overKeysWhenInsert];
    }
    
    if (overKeys.count > 0) {
        [dic removeObjectsForKeys:overKeys];
    }
    
    NSAssert(dic && tableName, @"表名称未提供或者map为空");
    
    NSString *tabelStr = [NSString stringWithFormat:@"INSERT INTO %@", tableName] ;
    NSMutableString *columnStr = [[NSMutableString alloc] initWithString:@"("];
    NSMutableString *valueStr  = [[NSMutableString alloc] initWithString:@"VALUES ("];
    
    
    NSArray *keys = [dic allKeys];
    
    [columnStr appendFormat:@"%@ )", [keys componentsJoinedByString:@", "]];
    [valueStr appendFormat:@":%@ ) ", [keys componentsJoinedByString:@", :"]];
    
    NSString * insertSql = [NSString stringWithFormat:@"%@%@%@", tabelStr, columnStr, valueStr];
    
    __block BOOL retValue = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        retValue = [db executeUpdate:insertSql withParameterDictionary:dic];
        if (!retValue){
            NSLog(@"===ERROR=== 插入数据失败");
        }
    }];
    
    if (retValue) {
        NSString * sql = @"select last_insert_rowid();";
        __block int64_t lastId = 0;
        [mainDB.dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet * set = [db executeQuery:sql];
            if ([set next]) {
                lastId = [[set resultDictionary][@"last_insert_rowid()"] longLongValue];
            }
            [set close];
        }];
        
        return lastId;
    } else {
        return -1;
    }  
}

- (void)insertWithProtocolList:(NSArray<id<XSTDBProtocol>> *)protocolList {
    for (NSObject<XSTDBProtocol> * protocol in protocolList) {
        [self insertWithProtocol:protocol];
    }
}

- (BOOL)updateAllWithProtocol:(id<XSTDBProtocol>)protocol conditions:(NSArray *)conditions {
    if (protocol == nil) {
        NSLog(@"XSTDBProtocol 不能为空");
        return NO;
    }
    
    NSString * tableName = [protocol.class tableName];
    NSObject * obj = (NSObject *)protocol;
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[obj yy_modelToJSONObject]];
    [dic removeObjectForKey:@"uid"];
    
    if ([protocol respondsToSelector:@selector(propertyNotInDB)]) {
        NSArray * keys = [protocol propertyNotInDB];
        [dic removeObjectsForKeys:keys];
    }
    
    NSAssert(dic && tableName && [conditions count] > 0, @"表名称未提供或者map为空");
    
    NSArray * keys = [dic allKeys];
    
   return [self updateWithProtocol:protocol conditions:conditions updateKeys:keys];
    
}

- (BOOL)updateWithProtocol:(id<XSTDBProtocol>)protocol conditions:(NSArray<NSString*>*)conditions updateKeys:(NSArray<NSString*>*)keys {
    
    if (protocol == nil) {
        NSLog(@"XSTDBProtocol 不能为空");
        return NO;
    }
    
    NSString * tableName = [protocol.class tableName];
    NSObject * obj = (NSObject *)protocol;

    NSAssert(tableName && [conditions count] > 0 && keys.count > 0, @"表名称未提供或者map为空");
    
    NSMutableString *updateStr = [[NSMutableString alloc] initWithFormat:@"UPDATE %@ SET ", tableName];
    
    BOOL hasUpdateDateKey = NO;
    for (NSString *key in keys) {
        [updateStr appendFormat:@"%@=:%@, ", key, key];
        if ([key isEqualToString:@"updateDate"]) {
            hasUpdateDateKey = YES;
        }
    }
    if ([obj isKindOfClass:[XSTBaseEntity class]] && !hasUpdateDateKey) {
        ((XSTBaseEntity*)obj).updateDate = [NSDate date];
        [updateStr appendFormat:@"%@=:%@, ", @"updateDate", @"updateDate"];
        keys = [keys arrayByAddingObject:@"updateDate"];
    }
    
    [updateStr deleteCharactersInRange:NSMakeRange(updateStr.length - 2, 2)];
    
    NSMutableString * con = [[NSString stringWithFormat:@" WHERE %@=:%@ ", conditions[0], conditions[0]] mutableCopy];
    
    int length = (int)[conditions count];
    if (length > 1) {
        for (int i = 1; i<length; i++) {
            [con appendFormat:@"AND %@=:%@ ", conditions[i], conditions[i]];
        }
    }
    
    [updateStr appendString: con];
    
    NSDictionary * dic = [obj yy_modelToJSONObject];
    NSArray<NSString*>* allKeys = [conditions arrayByAddingObjectsFromArray:keys];
    NSDictionary * updateDic = [dic dictionaryWithValuesForKeys:allKeys];
    __block BOOL ret = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:updateStr withParameterDictionary:updateDic];
        if (!ret) {
            NSLog(@"数据更新失败");
        }
    }];
    
    return ret;
}

- (BOOL)deleteProticol:(id<XSTDBProtocol>)protocol conditions:(NSArray *)conditions {
    
    if (protocol == nil) {
        NSLog(@"XSTDBProtocol 不能为空");
        return NO;
    }
    
    NSString * tableName = [protocol.class tableName];
    NSObject * obj = (NSObject *)protocol;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:[obj yy_modelToJSONObject]];
    
    NSAssert(dic && tableName && [conditions count] > 0, @"表名称未提供或者map为空");
    
    NSMutableString *updateStr = [[NSMutableString alloc] initWithFormat:@"DELETE FROM %@ ", tableName];
    
    NSMutableString * con = [[NSString stringWithFormat:@" WHERE %@=:%@ ", conditions[0], conditions[0]] mutableCopy];
    
    int length = (int)[conditions count];
    if (length > 1) {
        for (int i = 1; i<length; i++) {
            [con appendFormat:@"AND %@=:%@ ", conditions[i], conditions[i]];
        }
    }
    
    [updateStr appendString: con];
    
    __block BOOL ret = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:updateStr withParameterDictionary:[dic dictionaryWithValuesForKeys:conditions]];
        if (!ret) {
            NSLog(@"删除失败： %@", updateStr);
        }
    }];
    
    return ret;
}

@end
