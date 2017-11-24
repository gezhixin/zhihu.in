//
//  NSString+Extersion.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/3/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Extersion)

- (NSAttributedString *)arrtrStringWithFont:(UIFont *)font color:(UIColor *)color;

- (NSString *)pinyinOfFistLetter;

- (NSString *)stringWithMaxLen:(NSUInteger)line;

@end
