//
//  XSTHttpManager.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/1/30.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^XSTNetcallback)(NSDictionary * resultDic, int code, NSString * msg);
typedef void(^XSTNetProgress)(NSProgress * progress);

@interface XSTHttpManager : AFHTTPSessionManager

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url parma:(NSDictionary*)parma complated:(XSTNetcallback)complated;

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated progress:(XSTNetProgress)progress;

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated;

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated progress:(XSTNetProgress)progress;

+ (NSURLSessionUploadTask *)uploadFile:(NSString*)filePath url:(NSString*)url progress:(XSTNetProgress)progress complated:(XSTNetcallback)complated;

+ (NSURLSessionUploadTask *)uploadData:(NSData*)data url:(NSString*)url progress:(XSTNetProgress)progress complated:(XSTNetcallback)complated;

+ (NSURLSessionDataTask *)DOWNLOAD:(NSString *)URLString
                    headParameters:(NSDictionary *)headParameters
                          progress:(void (^)(NSProgress *downloadProgress,NSData *downloadData)) downloadProgressBlock
                           success:(void (^)(NSURLSessionDataTask *task, id  responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

@end
