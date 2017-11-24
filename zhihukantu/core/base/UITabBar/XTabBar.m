//
//  XTabBar.m
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/1.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import "XTabBar.h"

@implementation XTabBar

#pragma mark - Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self.delegate tabBar:self didSelectIndex:selectedIndex];
}

@end
