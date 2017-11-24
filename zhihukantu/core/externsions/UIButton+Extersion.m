//
//  UIButton+Extersion.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/20.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "UIButton+Extersion.h"
#import <YYCategories/YYCategories.h>

@implementation UIButton(Extersion)

- (void)verticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = (CGSize){[self.titleLabel.text widthForFont:self.titleLabel.font], self.titleLabel.font.lineHeight};
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

@end
