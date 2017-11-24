//
//  JGProgressHUD+Extersion.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/20.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <JGProgressHUD/JGProgressHUD.h>

@interface JGProgressHUD(Extersion)

+ (instancetype)toast:(NSString *)msg;

+ (instancetype)toast:(NSString *)msg dismissTime:(NSInteger)time;

+ (instancetype)toast:(NSString *)msg dismissTime:(NSInteger)time inView:(UIView *)inView;

+ (instancetype)showSuccess:(NSString *)tip;

@end
