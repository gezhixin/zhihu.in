//
//  JGProgressHUD+Extersion.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/20.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "JGProgressHUD+Extersion.h"

@implementation JGProgressHUD(Extersion)

+ (instancetype)toast:(NSString *)msg {
    return [JGProgressHUD toast:msg dismissTime:1.5];
}

+ (instancetype)toast:(NSString *)msg dismissTime:(NSInteger)time {
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    return [JGProgressHUD toast:msg dismissTime:time inView:keyWindow];
}

+ (instancetype)toast:(NSString *)msg dismissTime:(NSInteger)time inView:(UIView *)inView {
    JGProgressHUD * toast = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    toast.indicatorView = nil;
    toast.userInteractionEnabled =NO;
    toast.textLabel.text = msg;
    [toast showInView:inView];
    [toast dismissAfterDelay:time animated:YES];
    return toast;
}

+ (instancetype)showSuccess:(NSString *)tip {
     UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    JGProgressHUD * jprogress = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    jprogress.textLabel.text = @"导入成功";
    jprogress.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
    jprogress.userInteractionEnabled =NO;
    jprogress.textLabel.text = tip;
    [jprogress showInView:keyWindow];
    [jprogress dismissAfterDelay:1.5 animated:YES];
    return jprogress;
}

@end
