//
//  XSTDeviceConfig.m
//  KW2496
//
//  Created by zgshao on 2017/3/1.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import "XSTDeviceConfig.h"
#include <sys/sysctl.h>
#include <stdlib.h>
#import "KeychainAdapter.h"
#import "OpenUDID.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>


@implementation XSTDeviceConfig

+ (NSString *)appVersion
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@", version];
}

+ (NSString *)appBuildVersion {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"BuildVersionNumber"];
    return version.length > 0 ? version : @"";
}

+ (NSString *)clientInstallSource {
    NSString *clientInstallSource = [NSString stringWithFormat:@"XSTBookNote_ip_%@.ipa", [XSTDeviceConfig appVersion]];
    return clientInstallSource;
}

+ (NSString *)udid {
    static NSString *s_keyUDID2496 = @"gezhixin.com.xiaoshutong";
    NSString *udid = [KeychainAdapter load:s_keyUDID2496];
    if (udid == nil || [udid length] < 1) {
        udid = [OpenUDID value];
        
        [KeychainAdapter save:s_keyUDID2496 data:udid];
    }
    
    return udid;
}

+ (NSString *)devName {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);

    NSString * vv = @"iPhone";
    
    if ([platform isEqualToString:@"iPhone4,1"])    vv = @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,2"])    vv = @"iPhone 5";
    if ([platform isEqualToString:@"iPhone6,2"])    vv = @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    vv = @"iPhone 6Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    vv = @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,2"])    vv = @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    vv = @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone9,1"])    vv = @"iPhone 7Plus";
    if ([platform isEqualToString:@"iPhone9,2"])    vv = @"iPhone 7";
    
    
    if ([platform isEqualToString:@"i386"])         vv = @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])       vv = @"iPhone Simulator";
    
    return vv;
}

+ (NSString *)devType {
    static NSString *devType = [[NSString alloc] initWithFormat:@"%@_%.1fG", [XSTDeviceConfig devName], [XSTDeviceConfig getDeviceTotalMemory]/(1024*1024*1024)];
    return devType;
}

+ (CGFloat)getDeviceTotalMemory {
    static CGFloat memory_mb = 0;
    static dispatch_once_t onceToken;
    
    /// 接口会使用此参数，为了避免系统接口不支持多线程访问，只执行一次
    dispatch_once(&onceToken, ^{
        unsigned long long memory_byte = [NSProcessInfo processInfo].physicalMemory;
        memory_mb = memory_byte;
    });
    return memory_mb;
}

+ (float)getDeviceRatio {
    float ratio = 1.0f;//default is iPhone6
    int type = [[self class] getDeviceResolutionType];
    if (type == ResolutionTypeiPhone6Plus)
        ratio = 1.104f;
    else if (type == ResolutionTypeiPhone6)
        ratio = 1.0f;
    else if (type == ResolutionTypeiPhone5 || ResolutionTypeiPhone4)
        ratio = 0.853f;
    return ratio;
}

+ (int)getDeviceResolutionType {
    static int deviceResolutionType = -1;
    if (deviceResolutionType >= 0)
        return deviceResolutionType;
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if (result.width > result.height) {
        CGFloat temp = result.width;
        result.width = result.height;
        result.height = temp;
    }
    if (result.width == 320 && result.height == 480)
        deviceResolutionType = ResolutionTypeiPhone4;
    else if (result.width == 320 && result.height == 568)
        deviceResolutionType = ResolutionTypeiPhone5;
    else if (result.width == 768 && result.height == 1024)
        deviceResolutionType = ResolutionTypeiPad;
    else if (result.width == 375 && result.height == 667)
        deviceResolutionType = ResolutionTypeiPhone6;
    else if (result.width == 414 && result.height == 736)
        deviceResolutionType = ResolutionTypeiPhone6Plus;
    else
        deviceResolutionType = ResolutionTypeUnknow;
    
    return deviceResolutionType;
}


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self _getIPAddresses];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)_getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

@end
