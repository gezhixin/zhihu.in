//
//  XSTUserDefaultManager.h
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/31.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSTUserDefaultManager : NSObject

+ (instancetype)defaultManager;

- (BOOL)setSting:(NSString *)value forKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)Key;

- (BOOL)setInt:(int64_t)value forKey:(NSString *)key;
- (int64_t)intForKey:(NSString *)Key;

- (BOOL)setFloat:(CGFloat)value forKey:(NSString *)key;
- (CGFloat)floatForKey:(NSString *)Key;

- (BOOL)setDate:(NSDate *)date forKey:(NSString *)key;
- (NSDate *)dateForKey:(NSString *)key;

- (BOOL)existKey:(NSString *)key;

@end
