//
//  XSTSectionSeparateCellVM.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/5.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTSectionSeparateCellVM.h"

@implementation XSTSectionSeparateCellVM


+ (instancetype)vmWithHeight:(CGFloat)height {
    XSTSectionSeparateCellVM * vm = [[XSTSectionSeparateCellVM alloc] init];
    vm.height = height;
    return vm;
}

- (void)setHeight:(CGFloat)height {
    _height = height;
    self.sizeRange = (ASSizeRange){{ScreenW, height}, {ScreenW, height}};
}

- (ASCellNodeBlock)cellNodeBlock {
    return ^ {
        ASCellNode * node = [ASCellNode new];
        node.backgroundColor = [UIColor clearColor];
        return node;
    };
}

@end
