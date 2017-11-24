//
//  XSTAppConfig.m
//  xiaoshutong
//
//  Created by gezhixin on 2017/10/25.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTAppConfig.h"
#import "XSTUserDefaultManager.h"

@implementation XSTAppConfig

+ (instancetype)sharedInstance {
    static XSTAppConfig * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XSTAppConfig alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _loadConfig];
    }
    return self;
}

- (void)_loadConfig {
    _audioCatchOnlyWifi = [[XSTUserDefaultManager defaultManager] boolForKey:KAUDIO_CATCH_ONLY_WIFI];
    _syncOnlyWifi = [[XSTUserDefaultManager defaultManager] boolForKey:KNOTE_SYNC_ONLY_WIFI];
}

- (void)setSyncOnlyWifi:(BOOL)syncOnlyWifi {
    if (_syncOnlyWifi == syncOnlyWifi) {
        return;
    }
    _syncOnlyWifi = syncOnlyWifi;
    [[XSTUserDefaultManager defaultManager] setBool:syncOnlyWifi forKey:KNOTE_SYNC_ONLY_WIFI];
}

- (void)setAudioCatchOnlyWifi:(BOOL)audioCatchOnlyWifi {
    if (_audioCatchOnlyWifi == audioCatchOnlyWifi) {
        return;
    }
    
    _audioCatchOnlyWifi = audioCatchOnlyWifi;
    [[XSTUserDefaultManager defaultManager] setBool:audioCatchOnlyWifi forKey:KAUDIO_CATCH_ONLY_WIFI];
}

@end
