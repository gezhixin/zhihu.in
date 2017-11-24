//
//  XSTPathConfig.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/7.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XSTDirectoryConfig : NSObject

@property (nonatomic, strong, readonly) NSString * appDirectory;
@property (nonatomic, strong, readonly) NSString * documentDirectory;
@property (nonatomic, strong, readonly) NSString * cacheDirectory;
@property (nonatomic, strong, readonly) NSString * tempDirectory;

@property (nonatomic, strong, readonly) NSString * dataBaseDirectory;
@property (nonatomic, strong, readonly) NSString * noteImageDirectory;
@property (nonatomic, strong, readonly) NSString * noteAudioDirectory;
@property (nonatomic, strong, readonly) NSString * noteRecorderTmpDirectory;

@property (nonatomic, strong, readonly) NSString * orcDirectory;

+ (instancetype)sharedInstance;

+(UInt32)getFileSize:(NSString* )file;
+(UInt32)getDirectorySize:(NSString *)directory;

- (void)createDirectory:(NSString *)path;
- (void)deleteFile:(NSString *)path;

@end
