//
//  XSTSectionSeparateCellVM.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/5.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTCellVM.h"

@interface XSTSectionSeparateCellVM : XSTCellVM

@property (nonatomic, assign) CGFloat height;

+ (instancetype)vmWithHeight:(CGFloat)height;

@end
