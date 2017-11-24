//
//  IFlyRecorder.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/18.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTIFlyManager.h"
#import <iflyMSC/iflyMSC.h>

#define APPID_VALUE @"58a478c1"

@implementation XSTIFlyManager

+ (instancetype)sharedInstance {
    static XSTIFlyManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置sdk的log等级，log保存在下面设置的工作路径中
        [IFlySetting setLogFile:LVL_NONE];
        
        //打开输出在console的log开关
        [IFlySetting showLogcat:NO];
        
        //设置sdk的工作路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [paths objectAtIndex:0];
        [IFlySetting setLogFilePath:cachePath];
        
        //创建语音配置,appid必须要传入，仅执行一次则可
        NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
        
        //所有服务启动前，需要确保执行createUtility
        [IFlySpeechUtility createUtility:initString];
    }
    return self;
}

@end
