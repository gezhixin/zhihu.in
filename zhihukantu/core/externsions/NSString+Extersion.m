//
//  NSString+Extersion.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/3/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "NSString+Extersion.h"

@implementation NSString(Extersion)

- (NSAttributedString *)arrtrStringWithFont:(UIFont *)font color:(UIColor *)color {
   return [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: color}];
}

- (NSString *)pinyinOfFistLetter {
    
    if (self.length == 0) {
        return nil;
    }
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:[self substringToIndex:1]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
    
}

- (NSString *)stringWithMaxLen:(NSUInteger)len {
    if (self.length > len) {
        return [NSString stringWithFormat:@"%@…", [self substringToIndex:len - 1]];
    } else {
        return self;
    }
}

@end
