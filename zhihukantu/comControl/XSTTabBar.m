//
//  KWHomePageTabBar.m
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/1.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import "XSTTabBar.h"
#import "XTabBarViewController.h"


@interface XSTTabBar ()

@property (nonatomic, strong) NSArray<NSString*> * barItems;
@property (nonatomic, strong) UIVisualEffectView * backgrandView;
@property (nonatomic, strong) NSMutableArray<UIButton*> * buttons;
@property (nonatomic, strong) UIImageView * bottomLine;

@end

@implementation XSTTabBar

- (instancetype)initWithFrame:(CGRect)frame barItem:(NSArray<NSString*>*)barItems
{
    self = [super initWithFrame:frame];
    if (self) {
        self.barItems = barItems;
        _buttons = [NSMutableArray arrayWithCapacity:3];
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    
    self.backgrandView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.backgrandView.frame = self.bounds;
    [self addSubview:_backgrandView];
    
    self.bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = skin.colorMainTint;
    _bottomLine.frame = CGRectMake(0, self.height - 2, 0, 2);
    [self addSubview:_bottomLine];
    
    NSUInteger count = self.barItems.count;
    
    CGFloat btnW = self.width / count;
    for (int i = 0; i < count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitleColor:skin.colorTitle forState:UIControlStateNormal];
        [btn setTitleColor:skin.colorMainTint forState:UIControlStateSelected];
        [btn setTitle:_barItems[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(onItemBtnClicked:) forControlEvents:UIControlEventAllEvents];
        [self addSubview:btn];
        
        btn.frame = CGRectMake(i * btnW, 0, btnW, self.height);

        [_buttons addObject:btn];
    }
    
    self.bottomLine.frame = [self _bottomLineFrameOfIndex:0];
}

#pragma mark - setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    for (int i = 0; i < _buttons.count; i++) {
        _buttons[i].selected = i == selectedIndex;
    }
    
    CGRect bottomLineRect = [self _bottomLineFrameOfIndex:selectedIndex];
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLine.frame = bottomLineRect;
    }];
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    self.backgrandView.alpha = backgroundAlpha;
}

#pragma mark - Actions
- (void)onItemBtnClicked:(UIButton *)sender {
    if ([self.delegate tabBar:self shouldSelectIndex:sender.tag]) {
        self.selectedIndex = sender.tag;
    }
}

#pragma mark -  Privite
- (CGRect)_bottomLineFrameOfIndex:(NSUInteger)index {
    CGFloat bottomLineW = [_barItems[index] widthForFont:_buttons.firstObject.titleLabel.font];
    CGFloat itemW = self.width / _buttons.count;
    CGFloat bottomLineX = index * itemW + (itemW - bottomLineW) / 2;
    CGRect  bottomLineRect = CGRectMake(bottomLineX, self.height - 2, bottomLineW, 2);
    return bottomLineRect;
}

@end
