//
//  KWUITabBarViewController.h
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/1.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTabBar.h"
#import "XSTBaseViewController.h"

@protocol XTabBarControllerDelegate;

typedef NS_ENUM(NSInteger, XTabBarPosition) {
    XTabBarPositionTop,
    XTabBarPositionBottom,
};

@interface XTabBarViewController : XSTBaseViewController <XTabBarDelegate>

@property(nullable, nonatomic, copy) NSArray<UIViewController *> *viewControllers;

@property(nullable, nonatomic, assign) UIViewController *selectedViewController;

@property (nonatomic, assign) BOOL scrollEnabled;

@property(nonatomic) NSUInteger selectedIndex;

@property (nonatomic, assign) BOOL selectAnimated;

@property(nullable, nonatomic, weak) id<XTabBarControllerDelegate> delegate;

@property(nullable, nonatomic) XTabBar * tabBar;

- (void)setTabBar:(XTabBar * _Nullable)tabBar position:(XTabBarPosition)position;

@end


@protocol XTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(nullable XTabBarViewController *)tabBarController shouldSelectViewController:(nullable UIViewController *)viewController;
- (void)tabBarController:(nullable XTabBarViewController *)tabBarController didSelectViewController:(nullable UIViewController *)viewController;

@end

