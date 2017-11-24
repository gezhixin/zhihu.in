//
//  XSTBaseViewController.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/2.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface XSTBaseViewController : ASViewController

@property (nonatomic, strong) UIColor * navBarBackgroundColor;
@property (nonatomic, assign) CGFloat navBarBackgroundAlpha;

@property (nonatomic, assign) BOOL disablePanPopo;

@property (nonatomic, assign) BOOL disableDefaultCancelBtn;

- (void)showLoadAnimation:(BOOL)show;

- (void)setDefaultNavCancelItem;

- (void)setDefaultMoreMenuClicked:(void(^)(id sender, NSInteger index))clicked;

- (void)setRightNavigationItems:(NSArray *)items clicked:(void(^)(id sender, NSInteger index))clicked;

- (void)setLeftNavigationItems:(NSArray *)items clicked:(void(^)(id sender, NSInteger index))clicked;

- (void)onCancelBtnClicked:(id)sender;

- (void)popoedToViewController;

//提示控件
- (void)showJLoadingWithTips:(NSString *)tips;
- (void)showJSuccessWithTips:(NSString *)tips;
- (void)showJFailWithTips:(NSString *)tips;
- (void)dissmissJLoadingView;

@end
