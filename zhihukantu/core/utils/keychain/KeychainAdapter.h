//
//  KeychainAdapter.h
//  KWCore
//
//  Created by felixlee on 14-6-3.
//  Copyright (c) 2014年 Kuwo Beijing Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainAdapter : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteService:(NSString *)service;

@end
