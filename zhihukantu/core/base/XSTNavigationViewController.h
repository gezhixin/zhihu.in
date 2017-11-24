//
//  XSTNavigationViewController.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/9.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface XSTNavigationViewController : ASNavigationController

@property (nonatomic, strong) UIVisualEffectView * myBackgroundView;
@property (nonatomic, strong) UIColor * navBarBackgroundColor;

- (void)popViewController:(XSTBaseViewController *)vc;

@end
