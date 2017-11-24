//
//  XSTSectionVM.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/5.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTSectionVM.h"

@implementation XSTSectionVM

- (NSMutableArray<XSTCellVM *> *)cellVMList {
    if (!_cellVMList) {
        _cellVMList = [NSMutableArray array];
    }
    
    return _cellVMList;
}

@end
