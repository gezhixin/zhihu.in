//
//  XSTBaseEntity.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/1/29.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "XSTDBProtocol.h"

typedef NS_ENUM(NSInteger, EntityState) {
    EntityStateNotSync = 0,
    EntityStateSynced = 1,
    EntityStateDeleted = 2,
};

@interface XSTBaseEntity : NSObject <XSTDBProtocol>

@property (nonatomic, assign) int64_t    uid;
@property (nonatomic, strong) NSDate    *createDate;
@property (nonatomic, strong) NSDate    *updateDate;
@property (nonatomic, assign) EntityState state;

- (BOOL)virtualDelete;

@end

