//
//  XSTNavigationViewController.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/9.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTNavigationViewController.h"
#import "XSTBaseViewController.h"
#import "UINavigationBar+Externsion.h"

@interface XSTNavigationViewController ()

@end

@implementation XSTNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17], NSForegroundColorAttributeName:[UIColor colorWithRGB:0x333333]}];
    
    self.navigationBar.hiddenBottomLine = YES;
//    [self hidderNavBarSubviews:self.navigationBar];
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.myBackgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    _myBackgroundView.userInteractionEnabled = NO;
    _myBackgroundView.frame = CGRectMake(0, -20, ScreenW, 64);
    _myBackgroundView.backgroundColor = [UIColor colorWithRGB:0xffffff alpha:1];
//    [self.navigationBar insertSubview:_myBackgroundView atIndex:0];
}

- (void)dealloc {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.navigationBar sendSubviewToBack:self.myBackgroundView];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(self.viewControllers.count > 0) {
        if ([viewController isKindOfClass:[XSTBaseViewController class]]) {
            XSTBaseViewController * vc = (XSTBaseViewController *)viewController;
            if (!vc.disableDefaultCancelBtn) {
                [vc setDefaultNavCancelItem];
            }
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

- (void)popViewController:(XSTBaseViewController *)vc {
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc popoedToViewController];
}

- (void)hidderNavBarSubviews:(UIView *)view {
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber10_11) {
        for (UIView * v in view.subviews) {
            NSString * classStr = NSStringFromClass([v class]);
            if ([classStr isEqualToString:@"_UINavigationBarModernPromptView"] || [classStr isEqualToString:@"_UINavigationBarContentView"]) {
                continue;
            }
            v.hidden = YES;
        }
    } else {
        for (UIView * v in view.subviews) {
            v.hidden = 0;
        }
    }
}

- (void)setNavBarBackgroundColor:(UIColor *)navBarBackgroundColor {
    self.myBackgroundView.backgroundColor = navBarBackgroundColor;
}

@end
