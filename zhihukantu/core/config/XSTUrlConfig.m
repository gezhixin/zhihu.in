//
//  XSTUrlConfig.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/23.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTUrlConfig.h"

typedef NS_ENUM(NSInteger, CloudType) {
    CloudTypeRelease = 0,
    CloudTypeHome = 1,
    CloudTypeYun = 2,
    CloudTypeCompany = 3,
    CloudTypeTemp = 4,
};

@implementation XSTUrlConfig

+ (NSString *)urlWithAction:(NSString *)action {
    return [NSString stringWithFormat:@"%@%@", [XSTUrlConfig BaseUrl], action];
}

+ (NSString *)BaseUrl {
    
    CloudType type = CloudTypeRelease;
    
#ifdef DEBUG
    type = CloudTypeRelease;
#endif
    
    switch (type) {
        case CloudTypeRelease:
            return @"http://119.23.34.228:80/";
//            return @"http://www.inoted.cn/";
        case CloudTypeCompany:
            return @"http://172.17.91.43:8080/";
        case CloudTypeYun:
            return @"http://119.29.159.30:8080/";
        case CloudTypeHome:
            return @"http://192.168.0.110:8080/";
        case CloudTypeTemp:
            return @"http://10.16.9.11:8080/";
    }
}

@end
