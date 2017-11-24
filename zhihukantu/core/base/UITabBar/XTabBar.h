//
//  XTabBar.h
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/1.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTabBar;

@protocol XTabBarDelegate <NSObject>

- (BOOL)tabBar:(XTabBar *)tabBar shouldSelectIndex:(NSInteger)index;
- (void)tabBar:(XTabBar *)tabBar didSelectIndex:(NSInteger)index;

@end

@interface XTabBar : UIView

@property (nonatomic, weak) id<XTabBarDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedIndex;

@end
