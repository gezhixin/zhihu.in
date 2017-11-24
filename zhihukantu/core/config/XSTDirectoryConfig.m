//
//  XSTPathConfig.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/7.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTDirectoryConfig.h"

@implementation XSTDirectoryConfig

+ (instancetype)sharedInstance {
    static XSTDirectoryConfig * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XSTDirectoryConfig alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initAndCreateDirectory];
    }
    return self;
}

- (void)initAndCreateDirectory {
    NSString *path = [[NSBundle mainBundle] resourcePath];
    _appDirectory = [path copy];
    
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dir = [array firstObject];
    _documentDirectory = [dir copy];
    
    array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    dir = [array firstObject];
    _cacheDirectory = [dir copy];
    
    _tempDirectory = [NSTemporaryDirectory() copy];
    
    _dataBaseDirectory = [_documentDirectory stringByAppendingPathComponent:@"dataBase"];
    [self createDirectory:_dataBaseDirectory];
    
    _noteAudioDirectory = [_documentDirectory stringByAppendingPathComponent:@"note/audio"];
    [self createDirectory:_noteAudioDirectory];
    
    _noteRecorderTmpDirectory = [_cacheDirectory stringByAppendingPathComponent:@"note/record"];
    [self createDirectory:_noteRecorderTmpDirectory];
    
    _noteImageDirectory = [_documentDirectory stringByAppendingPathComponent:@"note/images"];
    [self createDirectory:_noteImageDirectory];
    
    _orcDirectory = [_documentDirectory stringByAppendingPathComponent:@"OCR"];
    [self createDirectory:_orcDirectory];
}

- (void)createDirectory:(NSString *)path {
    NSFileManager * fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path isDirectory:nil]) {
        NSError * err = nil;
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
        if (err) {
            NSLog(@"%@", err.description);
        }
    }
}

- (void)deleteFile:(NSString *)path {
    NSFileManager * fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path isDirectory:nil]) {
        NSError * err = nil;
        [fm removeItemAtPath:path error:&err];
        if (err) {
            NSLog(@"%@", err.description);
        }
    }
}

+(UInt32)getFileSize:(NSString* )file
{
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    if (![fileMgr fileExistsAtPath:file isDirectory:&isDirectory]
        || isDirectory)
        return 0;
    NSDictionary* attrs = [fileMgr attributesOfItemAtPath:file error:nil];
    if (!attrs)
        return 0;
    NSNumber* size = [attrs objectForKey:NSFileSize];
    if (!size)
        return 0;
    return [size intValue];
}

+(UInt32)getDirectorySize:(NSString *)directory {
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSDictionary* attrs = [fileMgr attributesOfItemAtPath:directory error:nil];
    if (!attrs)
        return 0;
    
    UInt32 size = 0;
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) {
        NSDirectoryEnumerator *enumerator = [fileMgr enumeratorAtPath:directory];
        for (NSString *subPath in enumerator) {
            //全路径
            NSString *fullsubPath = [directory stringByAppendingPathComponent:subPath];
            
            //累加文件大小
            size += [fileMgr attributesOfItemAtPath:fullsubPath error:nil].fileSize;
        }
    }
    
    return size;
}


@end
