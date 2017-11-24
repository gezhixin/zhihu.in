//
//  UINavigationBar+Externsion.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/2.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "UINavigationBar+Externsion.h"

@implementation UINavigationBar(Externsion)

- (void)setHiddenBottomLine:(BOOL)hiddenBottomLine {
    if (hiddenBottomLine) {
        [self hiddenNavBottomLine:self];
    } else {
        [self showNavBottomLine:self];
    }
}

- (BOOL)hiddenBottomLine {
    return [self isBottomLineHiddened:self];
}

- (BOOL)isBottomLineHiddened:(UIView *)view {
    for (UIView * v in view.subviews) {
        [self hiddenNavBottomLine:v];
        if ([v isKindOfClass:[UIImageView class]] && v.frame.size.height < 1) {
            return v.hidden;
        }
    }
    
    return YES;
}

- (void)hiddenNavBottomLine:(UIView *)view {
    for (UIView * v in view.subviews) {
        [self hiddenNavBottomLine:v];
        if ([v isKindOfClass:[UIImageView class]] && v.frame.size.height < 4) {
            v.hidden = YES;
            return;
        }
    }
}

- (void)showNavBottomLine:(UIView *)view {
    for (UIView * v in view.subviews) {
        [self showNavBottomLine:v];
        if ([v isKindOfClass:[UIImageView class]] && v.frame.size.height < 4) {
            v.hidden = NO;
            return;
        }
    }
}

@end
