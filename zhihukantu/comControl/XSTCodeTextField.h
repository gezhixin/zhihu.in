//
//  XSTCodeTextField.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/24.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSTCodeTextField : UITextField

@property (nonatomic, assign) int index;

@property (nonatomic, assign) BOOL activty;

@property (nonatomic, copy) BOOL(^nextStep)(XSTCodeTextField * textField);
@property (nonatomic, copy) BOOL(^lastStep)(XSTCodeTextField * textField);
@property (nonatomic, copy) void(^didEdit)(XSTCodeTextField * textField);

- (void)clear;

@end
