//
//  KWHomePageTabBar.h
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/1.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import "XTabBar.h"

@interface XSTTabBar : XTabBar

@property (nonatomic, assign) CGFloat backgroundAlpha;

- (instancetype)initWithFrame:(CGRect)frame barItem:(NSArray<NSString*>*)barItems;

@end
