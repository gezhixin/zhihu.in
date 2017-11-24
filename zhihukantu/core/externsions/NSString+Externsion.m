//
//  NSString+Externsion.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/2.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "NSString+Externsion.h"

@implementation NSString(Externsion)

- (instancetype)cutWithLen:(NSInteger)len {
    if (self.length > len) {
        return [NSString stringWithFormat:@"%@…", [self substringToIndex:len - 1]];
    } else {
        return self;
    }
}

@end
