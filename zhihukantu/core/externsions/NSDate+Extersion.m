//
//  NSDate+Extersion.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/20.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "NSDate+Extersion.h"

@implementation NSDate(Extersion)

- (NSString *)dateString {
    int oneSecend = 60;
    NSTimeInterval timeIntervalSinceNow = fabs(self.timeIntervalSinceNow);
    if (timeIntervalSinceNow < 3 * oneSecend) {
        return @"刚刚";
    } else if (timeIntervalSinceNow < 60 * oneSecend) {
        return [NSString stringWithFormat:@"%d分钟前", (int)(timeIntervalSinceNow / oneSecend)];
    } else if (timeIntervalSinceNow < 24 * 60 * oneSecend) {
        return [NSString stringWithFormat:@"%d小时前", (int)(timeIntervalSinceNow / (60 * oneSecend))];
    } else if (timeIntervalSinceNow < 44 * 60 * oneSecend) {
        return @"昨天";
    } else if (timeIntervalSinceNow < 10 * 24 * 60 * oneSecend) {
        return [NSString stringWithFormat:@"%d天前", (int)(timeIntervalSinceNow / (24 * 60 * oneSecend))];
    } else {
        NSDateFormatter * dateFmt = [[NSDateFormatter alloc] init];
        dateFmt.dateFormat = @"yyyy年MM月dd日 HH:mm";
        return [dateFmt stringFromDate:self];
    }
}

@end
