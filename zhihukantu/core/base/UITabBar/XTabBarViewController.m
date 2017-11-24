//
//  KWUITabBarViewController.m
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/1.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import "XTabBarViewController.h"

@interface XTabBarViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * contentView;

@end

@implementation XTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.contentView.pagingEnabled = YES;
        self.contentView.scrollEnabled = NO;
        self.contentView.delegate = self;
        self.contentView.bounces = NO;
        self.contentView.showsVerticalScrollIndicator = NO;
        self.contentView.showsHorizontalScrollIndicator = NO;
        self.contentView.bouncesZoom = NO;
        self.contentView.alwaysBounceVertical = NO;
        self.contentView.alwaysBounceHorizontal = NO;
        [self.view addSubview:self.contentView];
    }
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.contentView.frame = self.view.bounds;
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController * vc =  _viewControllers[i];
        vc.view.frame = (CGRect){_contentView.width * i, 0, _contentView.size};
    }
    _contentView.contentSize = CGSizeMake(self.contentView.width * _viewControllers.count, self.contentView.height - 1);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - layout

#pragma mark - setter
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (selectedIndex >= _viewControllers.count) {
        return;
    }
    _selectedIndex = selectedIndex;
    self.tabBar.selectedIndex = selectedIndex;
}

- (void)setTabBar:(XTabBar *)tabBar {
    _tabBar = tabBar;
    _tabBar.delegate = self;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    self.contentView.scrollEnabled = scrollEnabled;
}

- (BOOL)scrollEnabled {
    return self.contentView.scrollEnabled;
}

- (void)setTabBar:(XTabBar *)tabBar position:(XTabBarPosition)position {
    if (_tabBar) {
        [_tabBar removeFromSuperview];
    }
    
    _tabBar = tabBar;
    _tabBar.delegate = self;
    [self.view addSubview:_tabBar];
    CGFloat top = position == XTabBarPositionTop ? 0 : self.view.frame.size.height - _tabBar.frame.size.height;
    _tabBar.frame = CGRectMake(0, top, _tabBar.frame.size.width, _tabBar.frame.size.height);
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = [viewControllers copy];
    CGFloat  contentWidth = _contentView.frame.size.width;
    CGFloat  contentHeight = _contentView.frame.size.height;
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController * vc =  viewControllers[i];
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(contentWidth * i, 0, contentWidth, contentHeight);
        [_contentView addSubview:vc.view];
    }
    _contentView.contentSize = CGSizeMake(self.contentView.width * viewControllers.count, self.contentView.height - 1);
}

#pragma mark -  UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    if ((int)offsetX % (int)scrollView.width == 0) {
        self.selectedIndex = MIN(self.viewControllers.count - 1, MAX(0, (int)(offsetX / scrollView.width)));
    }
}

#pragma mark - XTabBarDelegate
- (BOOL)tabBar:(XTabBar *)tabBar shouldSelectIndex:(NSInteger)index {
    if (index < _viewControllers.count) {
        if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
            return [_delegate tabBarController:self shouldSelectViewController:_viewControllers[index]];
        } else {
            return YES;
        }
    } else {
        return NO;
    }
    
}

- (void)tabBar:(XTabBar *)tabBar didSelectIndex:(NSInteger)index {
    if (index >= _viewControllers.count) {
        return;
    }
    if (self.selectAnimated || self.scrollEnabled) {
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.contentOffset = CGPointMake(self.contentView.frame.size.width * index, 0);
        }];
    } else {
        self.contentView.contentOffset = CGPointMake(self.contentView.frame.size.width * index, 0);
    }
    if([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [_delegate tabBarController:self didSelectViewController:_viewControllers[index]];
    }
}

@end
