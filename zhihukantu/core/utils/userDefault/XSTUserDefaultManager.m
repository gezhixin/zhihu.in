//
//  XSTUserDefaultManager.m
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/31.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import "XSTUserDefaultManager.h"
#import "XSTUserDefaultModel.h"
#import "XSTUserDefaultDataBaseManager.h"

@implementation XSTUserDefaultManager

+ (instancetype)defaultManager {
    static XSTUserDefaultManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XSTUserDefaultManager alloc] init];
    });
    return instance;
}

- (BOOL)setSting:(NSString *)value forKey:(NSString *)key {
    return [self _setString:value ForKey:key];
}

- (NSString *)stringForKey:(NSString *)key {
    return [self _stringForKey:key];
}

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key {
    NSString * str = value ? @"1" : @"0";
    return [self _setString:str ForKey:key];
}

- (BOOL)boolForKey:(NSString *)key {
    NSString * str = [self _stringForKey:key];
    return [str boolValue];
}

- (BOOL)setInt:(int64_t)value forKey:(NSString *)key {
    NSString * str = [NSString stringWithFormat:@"%lld", value];
    return [self _setString:str ForKey:key];
}

- (int64_t)intForKey:(NSString *)Key {
    NSString * str = [self _stringForKey:Key];
    return [str longLongValue];
}

- (BOOL)setFloat:(CGFloat)value forKey:(NSString *)key {
    NSString * str = [NSString stringWithFormat:@"%f", value];
    return [self _setString:str ForKey:key];
}

- (CGFloat)floatForKey:(NSString *)Key {
    NSString * str = [self _stringForKey:Key];
    return [str floatValue];
}

- (BOOL)setDate:(NSDate *)date forKey:(NSString *)key {
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString * str = [NSString stringWithFormat:@"%f", time];
    return [self _setString:str ForKey:key];
}

- (NSDate *)dateForKey:(NSString *)key {
    NSString * str = [self _stringForKey:key];
    NSTimeInterval time = [str doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:time];
}

- (BOOL)existKey:(NSString *)key {
    NSString * str = [self _stringForKey:key];
    return str != nil;
}

#pragma mark -  Privite Methols
- (NSString *)_stringForKey:(NSString *)key {
    
    if (key == nil) {
        return nil;
    }
    
    XSTUserDefaultModel * model = [XSTUserDefaultModel new];
    model.key = key;
    
    NSArray * resultList = [[XSTUserDefaultDataBaseManager sharedInstance] queryWithProtocol:model conditions:@[@"key"] queryType:XSTDataBaseQueryTypeAnd];
    if (resultList == nil) {
        return nil;
    } else {
        XSTUserDefaultModel * result = resultList.firstObject;
        if ([result isKindOfClass:[XSTUserDefaultModel class]] && result.key.length > 0) {
            return result.value;
        } else {
            return nil;
        }
    }
}


- (BOOL)_setString:(NSString *)value ForKey:(NSString *)key {
    NSString * result = [self _stringForKey:key];
    
    XSTUserDefaultModel * model = [XSTUserDefaultModel new];
    model.key = key;
    model.value = value;
    
    if (result) {
       return [[XSTUserDefaultDataBaseManager sharedInstance] updateWithProtocol:model conditions:@[@"key"] updateKeys:@[@"value"]];
    } else {
       return [[XSTUserDefaultDataBaseManager sharedInstance] insertWithProtocol:model];
    }
}

@end
