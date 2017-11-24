//
//  XSTUrlConfig.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/23.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSTUrlConfig : NSObject

@property (nonatomic, class, strong, readonly) NSString * BaseUrl;

+ (NSString *)urlWithAction:(NSString *) action;

@end
