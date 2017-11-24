//
//  XSTVerifyCodePopoView.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/24.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSTVerifyCodePopoView : UIView

@property (nonatomic, copy) void(^inputComplated)(XSTVerifyCodePopoView * view);
@property (nonatomic, copy) void(^dissmissed)();

@property (nonatomic, copy) NSString * phoneNumber;

- (void)showAnimation;
- (void)dismiss;

@end
