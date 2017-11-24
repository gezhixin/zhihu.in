//
//  XSTDBProtocol.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/11.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#ifndef XSTDBProtocol_h
#define XSTDBProtocol_h


@protocol XSTDBProtocol <NSObject>

+ (NSString *)createTableSql;

+ (NSString *)tableName;

@optional
- (NSArray *)overKeysWhenInsert;
- (NSArray<NSString*>*)propertyNotInDB;

@end

#endif
