//
//  XSTBaseViewController.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/2.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTBaseViewController.h"
#import <YYCategories/YYCategories.h>
#import "XSTNavigationViewController.h"
#import "JGProgressHUD+Extersion.h"

@interface XSTBaseViewController () {

}

@property (nonatomic, strong) UIActivityIndicatorView * juhua;

@property (nonatomic, strong) JGProgressHUD * jprogressView;

@end

@implementation XSTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = skin.colorNormalBackground;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.navigationController.viewControllers.count > 1 && !self.disablePanPopo) {
            __weak XSTBaseViewController * weakVC = self;
            self.navigationController.interactivePopGestureRecognizer.delegate = (id <UIGestureRecognizerDelegate>)weakVC;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        } else {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;

        }
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showJLoadingWithTips:(NSString *)tips {
    self.jprogressView.textLabel.text = tips;
    self.jprogressView.indicatorView = [[JGProgressHUDIndeterminateIndicatorView alloc] init];
    [self.jprogressView showInView:self.view animated:YES];
}

- (void)showJSuccessWithTips:(NSString *)tips {
    self.jprogressView.textLabel.text = tips;
    self.jprogressView.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
    [self.jprogressView showInView:self.view animated:YES];
    [self.jprogressView dismissAfterDelay:1];
    _jprogressView = nil;
}

- (void)showJFailWithTips:(NSString *)tips {
    self.jprogressView.textLabel.text = tips;
    self.jprogressView.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init];
    [self.jprogressView dismissAfterDelay:1];
    _jprogressView = nil;
}

- (void)dissmissJLoadingView {
    [self.jprogressView dismissAnimated:YES];
    _jprogressView = nil;
}

- (void)setDefaultNavCancelItem {
    UIImage * image = [UIImage imageNamed:@"nav_back_up_light"];
    @weakify(self);
    [self setLeftNavigationItems:@[image] clicked:^(id sender, NSInteger index) {
        @strongify(self);
        [self onCancelBtnClicked:sender];
    }];
}

- (void)setDefaultMoreMenuClicked:(void(^)(id sender, NSInteger index))clicked {
    [self setRightNavigationItems:@[[UIImage imageNamed:@"icon_more"]] clicked:clicked];
}

- (void)onCancelBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setDisablePanPopo:(BOOL)disablePanPopo {
    _disablePanPopo = disablePanPopo;
    
    if ([self isViewLoaded]) {
        if (self.navigationController.viewControllers.count > 1 && !_disablePanPopo) {
            __weak XSTBaseViewController * weakVC = self;
            self.navigationController.interactivePopGestureRecognizer.delegate = (id <UIGestureRecognizerDelegate>)weakVC;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        } else {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)showLoadAnimation:(BOOL)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (show) {
            if (_juhua == nil) {
                _juhua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            }
            [self.view addSubview:_juhua];
            _juhua.center = self.view.center;
            _juhua.top = self.view.height / 4;
            [self.view bringSubviewToFront:_juhua];
            [_juhua startAnimating];
        } else {
            [_juhua stopAnimating];
            [_juhua removeFromSuperview];
        }
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:_juhua];
}

- (void)setRightNavigationItems:(NSArray *)items clicked:(void(^)(id sender, NSInteger index))clicked {
    [self setNavigationItems:items isLeft:NO clicked:clicked];
}

- (void)setLeftNavigationItems:(NSArray *)items clicked:(void(^)(id sender, NSInteger index))clicked {
    [self setNavigationItems:items isLeft:YES clicked:clicked];
}

- (void)setNavigationItems:(NSArray *)items isLeft:(BOOL)isLeft clicked:(void(^)(id sender, NSInteger index))clicked {
    NSMutableArray * itemList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < items.count; i++) {
        id item = items[i];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        if ([item isKindOfClass:[NSString class]]) {
            NSString * title = (NSString *)item;
            if (title.length == 0) {
                continue;
            }
            [btn setTitle:title forState:UIControlStateNormal];
            CGFloat btnWidth = [title widthForFont:btn.titleLabel.font] + 16;
            btn.frame = CGRectMake(0, 0, btnWidth, 40);
        } else if ([item isKindOfClass:[UIImage class]]) {
            UIImage * image = (UIImage*)item;
            [btn setImage:image forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, 0, image.size.width + 16, 40);
        } else if ([item isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)item;
        } else if ([item isKindOfClass:[UIView class]]) {
            UIView * view = (UIView *)item;
            [btn addSubview:view];
            btn.frame = view.frame;
            view.frame = btn.bounds;
        } else {
            NSAssert(NO, @"NavigationItem 类型不支持");
            continue;
        }
        
        btn.tag = i;
        [btn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (clicked) {
                clicked(sender, ((UIButton *)sender).tag);
            }
        }];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [itemList addObject:barItem];
        
    }
    
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = itemList;
    } else {
        self.navigationItem.rightBarButtonItems = itemList;
    }
}

- (void)popoedToViewController {
    
}

- (void)setNavBarBackgroundColor:(UIColor *)navBarBackgroundColor {
    if ([self.navigationController isKindOfClass:[XSTNavigationViewController class]]) {
        ((XSTNavigationViewController*)self.navigationController).navBarBackgroundColor = navBarBackgroundColor;
    }
}

- (void)setNavBarBackgroundAlpha:(CGFloat)navBarBackgroundAlpha {
    _navBarBackgroundAlpha = navBarBackgroundAlpha;
    if ([self.navigationController isKindOfClass:[XSTNavigationViewController class]]) {
        ((XSTNavigationViewController*)self.navigationController).myBackgroundView.alpha = navBarBackgroundAlpha;
    }
}

- (JGProgressHUD *)jprogressView {
    if (!_jprogressView) {
        _jprogressView = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    }
    return _jprogressView;
}

@end
