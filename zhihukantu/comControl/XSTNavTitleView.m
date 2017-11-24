//
//  XSTNavTitleView.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/6.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTNavTitleView.h"

@interface XSTNavTitleView ()

@end

@implementation XSTNavTitleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithRGB:0x333333];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        self.subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:10];
        _subTitleLabel.textColor = [UIColor colorWithRGB:0x333333];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subTitleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = (CGRect){0, 3, self.width, _titleLabel.font.lineHeight};
    self.subTitleLabel.frame = (CGRect){0, self.titleLabel.bottom + 2, self.width, _subTitleLabel.font.lineHeight};
}

+ (instancetype)viewWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    XSTNavTitleView * titleView = [[XSTNavTitleView alloc] init];
    titleView.titleLabel.text = title;
    titleView.subTitleLabel.text = subTitle;
    titleView.frame = (CGRect){0, 0, ScreenW, 60};
    return titleView;
}

@end
