//
//  XSTIconTitleActionBar.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/20.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTIconTitleActionBar.h"
#import "UIButton+Extersion.h"

@interface XSTIconTitleActionBar ()

@property (nonatomic, strong) NSArray<XSTIconTitleActionItem*>* items;
@property (nonatomic, strong) NSMutableArray<UIButton*> * btns;

@property (nonatomic, copy) void(^blkAction)(NSInteger index);

@end

@implementation XSTIconTitleActionBar

- (instancetype)initWithItems:(NSArray<XSTIconTitleActionItem*>*)items aciton:(void(^)(NSInteger index))action {
    if (self = [super init]) {
        self.items = items;
        self.blkAction = action;
        self.btns = [NSMutableArray arrayWithCapacity:items.count];
        [self _initUI];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
    
    CGFloat w = self.width / self.btns.count;
    for (int i = 0; i < self.btns.count; i++) {
        UIButton * btn = self.btns[i];
        btn.frame = (CGRect){w * i, 0, w, self.height};
        [btn verticalImageAndTitle:2];
    }
}

- (void)_initUI {
    
    self.backgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self addSubview:_backgroundView];
    
    for (int i = 0; i < self.items.count; i++) {
        XSTIconTitleActionItem * item = self.items[i];
        UIButton * btn = [self btnWithItem:item];
        btn.enabled = !item.disable;
        btn.tag = i;
        [self addSubview:btn];
        [self.btns addObject:btn];
    }
}

- (UIButton *)btnWithItem:(XSTIconTitleActionItem *)item {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleColor:skin.colorSubTitle forState:UIControlStateNormal];
    [btn setTitle:item.selectTitle forState:UIControlStateSelected];
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setImage:item.selectImage forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)onBtnClicked:(UIButton *)btn {
    if (self.blkAction) {
        self.blkAction(btn.tag);
    }
}

@end

@implementation XSTIconTitleActionItem

+ (instancetype)itemWithTitle:(NSString*)title icon:(UIImage*)icon {
    XSTIconTitleActionItem * item = [[XSTIconTitleActionItem alloc] init];
    item.image = icon;
    item.title = title;
    return item;
}

@end
