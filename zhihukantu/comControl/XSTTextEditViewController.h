//
//  XSTTextEditViewController.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/6.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTBaseViewController.h"

@interface XSTTextEditViewController : XSTBaseViewController

+ (instancetype)instanceWithTitle:(NSString *)title
                             text:(NSString *)text
                      placeholder:(NSString*)placeholder
                        complated:(void(^)(BOOL success, NSString * newText))complated;

@end
