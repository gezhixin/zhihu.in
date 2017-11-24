//
//  XSTDeviceConfig.h
//  KW2496
//
//  Created by zgshao on 2017/3/1.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    //没有乘以scale，代码中使用的分辨率
    ResolutionTypeUnknow                = 0,
    ResolutionTypeiPhone4               = 11,    // iPhone 1,3,3GS,4,4s     (320x480px)
    ResolutionTypeiPhone5               = 12,    // iPhone 5,5s             (320x568px)
    ResolutionTypeiPad                  = 13,    // iPad 1,2,3,4,mini       (1024x768px)
    ResolutionTypeiPhone6               = 14,    // iPhone 6,6plus的放大模式  (375x667px)
    ResolutionTypeiPhone6Plus           = 15,    // iPhone 6plus            (414x736px)
} ResolutionType;


#define DEV_UDID [XSTDeviceConfig udid]
#define APP_VERSION [XSTDeviceConfig appVersion]
#define APP_BUILD_VERSION [XSTDeviceConfig appBuildVersion]
#define APP_SRC [XSTDeviceConfig clientInstallSource]
#define DEV_NAME [XSTDeviceConfig devName]


@interface XSTDeviceConfig : NSObject

/*软件版本*/
+ (NSString *)appVersion;
+ (NSString *)appBuildVersion;

/*安装源*/
+ (NSString *)clientInstallSource;

/*设备唯一id*/
+ (NSString *)udid;

/*设备名称*/
+ (NSString *)devName;

+ (NSString *)devType;

+ (int)getDeviceResolutionType;

/*获取设备的放大比例，做UI适配用到*/
+ (float)getDeviceRatio;

+ (CGFloat)getDeviceTotalMemory;

/* 获取IP地址 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

@end
