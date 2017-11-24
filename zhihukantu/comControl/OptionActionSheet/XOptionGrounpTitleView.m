//
//  XOptionGrounpTitleView.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XOptionGrounpTitleView.h"

@interface XOptionGrounpTitleView ()



@end

@implementation XOptionGrounpTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = skin.colorTitle;
        _titleLabel.font = [XSTSkin fontD];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = (CGRect){10, 0, self.width - 30, self.height};
}

@end
