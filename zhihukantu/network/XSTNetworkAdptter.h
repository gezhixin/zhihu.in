//
//  XSTNetworkAdptter.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/23.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSTHttpManager.h"

@interface XSTNetworkAdptter : NSObject

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url parma:(NSDictionary*)parma complated:(XSTNetcallback)complated;

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated progress:(XSTNetProgress)progress;

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated;

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated progress:(XSTNetProgress)progress;

@end
