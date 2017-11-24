//
//  XSTDataBaseManager.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/4.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "XSTDBProtocol.h"

typedef NS_ENUM(NSInteger, XSTDataBaseQueryType) {
    XSTDataBaseQueryTypeAnd,
    XSTDataBaseQueryTypeOr,
};

@interface XSTDataBaseManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

- (void)initDataBase;

+ (instancetype)sharedInstance;

- (void)createTables;

- (BOOL)createTableWithProtocolClass:(Class<XSTDBProtocol>)clas;

- (void)createTableWithProtocolClassList:(NSArray<Class<XSTDBProtocol>> *)clasList;

- (BOOL)hasDataWithProtocol:(id<XSTDBProtocol>)protocol conditions:(NSArray *)conditions;

- (NSArray *)queryWithProtocol:(NSObject<XSTDBProtocol> *)protocol conditions:(NSArray<NSString *>*)conditions queryType:(XSTDataBaseQueryType)queryType;

- (int64_t)insertWithProtocol:(id<XSTDBProtocol>)protocol;

- (BOOL)updateAllWithProtocol:(id<XSTDBProtocol>)protocol conditions:(NSArray *)conditions;

- (BOOL)updateWithProtocol:(id<XSTDBProtocol>)protocol conditions:(NSArray *)conditions updateKeys:(NSArray *)keys;

- (BOOL)deleteProticol:(id<XSTDBProtocol>)protocol conditions:(NSArray*)conditions;

@end
