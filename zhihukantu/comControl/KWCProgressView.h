//
//  KWCProgressView.h
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/30.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KWCProgressView : UIView


@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat track;

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic) float progressWidth;

@end
