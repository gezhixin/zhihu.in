//
//  XSTNavTitleView.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/6.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSTNavTitleView : UIView

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subTitleLabel;

+ (instancetype)viewWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end
