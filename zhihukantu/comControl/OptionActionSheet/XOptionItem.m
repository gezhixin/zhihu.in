//
//  XOptionItem.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XOptionItem.h"

@implementation XOptionItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectColor = skin.colorMainTint;
        self.normalColor = skin.colorTitle;
    }
    return self;
}

- (CGFloat)cellHeight {
    return self.normalImage ? self.normalImage.size.height + 30 : 46;
}

@end
