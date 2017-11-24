//
//  XSTHttpManager.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/1/30.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTHttpManager.h"
#import "AFNetworking.h"

@implementation XSTHttpManager

+ (instancetype)defaultManager {
    static XSTHttpManager *s_httpMgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_httpMgr = [[XSTHttpManager alloc] init];
        s_httpMgr.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        s_httpMgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        s_httpMgr.requestSerializer = [AFJSONRequestSerializer serializer];
        [s_httpMgr.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [s_httpMgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        s_httpMgr.requestSerializer.timeoutInterval = 15.f;
        [s_httpMgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    });
    return s_httpMgr;
}

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated {
    return [self getWithUrl:url parma:parma complated:complated progress:nil];
}

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url parma:(NSDictionary*)parma complated:(XSTNetcallback)complated progress:(XSTNetProgress)progress {
    NSURLSessionDataTask *(^blk)(void)  = ^ {
        XSTHttpManager *manager = [XSTHttpManager defaultManager];
        return [manager GET:url parameters:parma progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = nil;
            if (!responseObject || responseObject == (id)kCFNull) dic = nil;
            NSData *jsonData = nil;
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                dic = responseObject;
            } else if ([responseObject isKindOfClass:[NSString class]]) {
                jsonData = [(NSString *)responseObject dataUsingEncoding :NSUTF8StringEncoding];
            } else if ([responseObject isKindOfClass:[NSData class]]) {
                jsonData = responseObject;
            }
            if (jsonData) {
                dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
                if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
            }
            
            if (complated) {
                complated(dic, 0, @"success");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
            if (complated) {
                complated(nil, (int)error.code, error.debugDescription);
                
                NSData * data = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@", str);
            }
        }];
    };
    if ([NSThread isMainThread]) {
        return blk();
    } else {
        __block NSURLSessionDataTask * task = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
            task = blk();
        });
        return task;
    }
}

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated {
    return [self.class postWithUrl:url parma:parma complated:complated progress:nil];
}

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url parma:(NSDictionary *)parma complated:(XSTNetcallback)complated progress:(XSTNetProgress)progress {
    NSURLSessionDataTask *(^blk)(void)  = ^ {
        XSTHttpManager *manager = [XSTHttpManager defaultManager];
        return [manager POST:url parameters:parma progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = nil;
            if (!responseObject || responseObject == (id)kCFNull) dic = nil;
            NSData *jsonData = nil;
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                dic = responseObject;
            } else if ([responseObject isKindOfClass:[NSString class]]) {
                jsonData = [(NSString *)responseObject dataUsingEncoding :NSUTF8StringEncoding];
            } else if ([responseObject isKindOfClass:[NSData class]]) {
                jsonData = responseObject;
            }
            if (jsonData) {
                dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
                if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
            }
            
            if (complated) {
                complated(dic, 0, @"success");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (complated) {
                complated(nil, (int)error.code, error.debugDescription);
            }
        }];
    };
    
    if ([NSThread isMainThread]) {
        return blk();
    } else {
        __block NSURLSessionDataTask * task = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
            task = blk();
        });
        return task;
    }
}


+ (NSURLSessionUploadTask *)uploadFile:(NSString*)filePath url:(NSString*)url progress:(XSTNetProgress)progress complated:(XSTNetcallback)complated {
    
    NSURLSessionUploadTask *(^blk)(void)  = ^ {
        NSURLSessionUploadTask *uploadTask;
        
        NSURL *filePathUrl = [NSURL fileURLWithPath:filePath];
        NSError * error = nil;
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSError * error = nil;
            [formData appendPartWithFileURL:filePathUrl name:@"file" error:&error];
            if (error) {
                NSLog(@"%@", error);
            }
        } error:&error];
        
        if (error) {
            if (complated) {
                complated(nil, (int)error.code, error.description);
            }
            return uploadTask;
        }
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        
        uploadTask = [manager uploadTaskWithStreamedRequest:request progress:progress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                if (complated) {
                    complated(nil, (int)error.code, error.description);
                }
            } else {
                NSDictionary *dic = nil;
                if (!responseObject || responseObject == (id)kCFNull) dic = nil;
                NSData *jsonData = nil;
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    dic = responseObject;
                } else if ([responseObject isKindOfClass:[NSString class]]) {
                    jsonData = [(NSString *)responseObject dataUsingEncoding :NSUTF8StringEncoding];
                } else if ([responseObject isKindOfClass:[NSData class]]) {
                    jsonData = responseObject;
                }
                if (jsonData) {
                    dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
                    if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
                }
                
                if (complated) {
                    complated(dic, 0, @"success");
                }
            }
        }];
        
        [uploadTask resume];
        
        return uploadTask;
    };
    
    if ([NSThread isMainThread]) {
        return blk();
    } else {
        __block NSURLSessionUploadTask * task = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
            task = blk();
        });
        return task;
    }
}

+ (NSURLSessionUploadTask *)uploadData:(NSData*)data url:(NSString*)url progress:(XSTNetProgress)progress complated:(XSTNetcallback)complated {
    NSURLSessionUploadTask *(^blk)(void)  = ^ {
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"iamge" mimeType:@"image/jpg"];
        } error:nil];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSURLSessionUploadTask *uploadTask;
        uploadTask = [manager uploadTaskWithStreamedRequest:request progress:progress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                if (complated) {
                    complated(nil, (int)error.code, error.description);
                }
            } else {
                NSDictionary *dic = nil;
                if (!responseObject || responseObject == (id)kCFNull) dic = nil;
                NSData *jsonData = nil;
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    dic = responseObject;
                } else if ([responseObject isKindOfClass:[NSString class]]) {
                    jsonData = [(NSString *)responseObject dataUsingEncoding :NSUTF8StringEncoding];
                } else if ([responseObject isKindOfClass:[NSData class]]) {
                    jsonData = responseObject;
                }
                if (jsonData) {
                    dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
                    if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
                }
                
                if (complated) {
                    complated(dic, 0, @"success");
                }
            }
        }];
        
        [uploadTask resume];
        
        return uploadTask;
    };
    
    if ([NSThread isMainThread]) {
        return blk();
    } else {
        __block NSURLSessionUploadTask * task = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
            task = blk();
        });
        return task;
    }
}

//根据url,用数据流的方式下载一个文件
+ (NSURLSessionDataTask *)DOWNLOAD:(NSString *)URLString
                    headParameters:(NSDictionary *)headParameters
                          progress:(void (^)(NSProgress *downloadProgress,NSData *downloadData)) downloadProgressBlock
                           success:(void (^)(NSURLSessionDataTask *task, id  responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
   
    AFHTTPSessionManager * dlManager = [[AFHTTPSessionManager alloc] init];
    dlManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [dlManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    dlManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (headParameters != nil) {
        [headParameters enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [dlManager.requestSerializer setValue:value forHTTPHeaderField:field];
        }];
    }
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [dlManager.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:dlManager.baseURL] absoluteString] parameters:nil error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(dlManager.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [dlManager downloadDataTaskWithRequest:request
                                     downloadProgress:downloadProgressBlock
                                    completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                        if (error) {
                                            if (failure) {
                                                failure(dataTask, error);
                                            }
                                        } else {
                                            if (success) {
                                                success(dataTask, responseObject);
                                            }
                                        }
                                    }];
    [dataTask resume];
    
    return dataTask;
}

@end
