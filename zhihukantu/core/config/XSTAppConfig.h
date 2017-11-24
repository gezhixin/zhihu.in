//
//  XSTAppConfig.h
//  xiaoshutong
//
//  Created by gezhixin on 2017/10/25.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSTAppConfig : NSObject

@property (nonatomic, assign) BOOL syncOnlyWifi;
@property (nonatomic, assign) BOOL audioCatchOnlyWifi;

+ (instancetype)sharedInstance;

@end
