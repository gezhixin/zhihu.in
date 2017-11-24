//
//  XSTNetworkAdptter.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/23.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTNetworkAdptter.h"
#import "XSTUserDefaultManager.h"

@implementation XSTNetworkAdptter

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated {
    return [XSTNetworkAdptter getWithUrl:url parma:parma complated:complated progress:nil];
}

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated progress:(XSTNetProgress)progress {
    
    NSDictionary * appendedCommParma = [XSTNetworkAdptter appendCommParma:parma];
    NSURLSessionDataTask * task = [XSTHttpManager getWithUrl:url parma:appendedCommParma complated:^(NSDictionary *resultDic, int code, NSString *msg) {
        if (code == 0) {
            if ([resultDic containsObjectForKey:@"code"] &&
                [resultDic containsObjectForKey:@"msg"] &&
                [resultDic containsObjectForKey:@"data"]) {
                if (complated) {
                    NSDictionary * data = [resultDic objectForKey:@"data"];
                    int code = [[resultDic objectForKey:@"code"] intValue];
                    NSString * msg = [resultDic objectForKey:@"msg"];
                    complated(data, code, msg);
                }
            } else {
                if (complated) {
                    complated(nil, -1, @"数据格式错误");
                }
            }
        } else {
            if (complated) {
                complated(resultDic, code, msg);
            }
        }
    } progress:progress];
    return task;
}

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated progress:(XSTNetProgress)progress {
    NSDictionary * appendedCommParma = [XSTNetworkAdptter appendCommParma:parma];
    NSURLSessionDataTask * task = [XSTHttpManager postWithUrl:url parma:appendedCommParma complated:^(NSDictionary *resultDic, int code, NSString *msg) {
        
        if (code == 0) {
            if ([resultDic containsObjectForKey:@"code"] &&
                [resultDic containsObjectForKey:@"msg"] &&
                [resultDic containsObjectForKey:@"data"]) {
                if (complated) {
                    NSDictionary * data = [resultDic objectForKey:@"data"];
                    int code = [[resultDic objectForKey:@"code"] intValue];
                    NSString * msg = [resultDic objectForKey:@"msg"];
                    complated(data, code, msg);
                }
                
            } else {
                if (complated) {
                    complated(nil, -1, @"数据格式错误");
                }
            }
        } else {
            if (complated) {
                complated(resultDic, code, msg);
            }
        }
    } progress:progress];
    return task;
}

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated {
    return [XSTNetworkAdptter postWithUrl:url parma:parma complated:complated progress:nil];
}

+ (NSDictionary *)appendCommParma:(NSDictionary *)parma {
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:parma];
    NSMutableDictionary * comParma = [NSMutableDictionary dictionary];
    [comParma setObject:DEV_UDID forKey:@"devId"];
    [comParma setObject:@"iOS" forKey:@"plat"];
    [comParma setObject:APP_VERSION forKey:@"cv"];
    [comParma setObject:APP_SRC forKey:@"src"];
    [comParma setObject:DEV_NAME forKey:@"devName"];
    
    
    [dic setObject:comParma forKey:@"com"];
    return dic;
}

@end
