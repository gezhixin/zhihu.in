//
//  XSTSearchBar.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/9.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTSearchBar.h"

@interface XSTSearchBar ()

@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, strong) UITextField * searchTextField;

@end

@implementation XSTSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
        self.showsCancelButton = NO;
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(onCancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
        
        _showCustormCancelBtn = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(50 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            UIView * backView = [self _getSubViewOfClass:@"UISearchBarBackground" view:self];
            backView.alpha = 0;
            self.searchTextField = (UITextField *)[self _getSubViewOfClass:@"UITextField" view:self];
            self.searchTextField.borderStyle = UITextBorderStyleNone;
            self.searchTextField.backgroundColor = skin.colorNormalBackground;
            self.alpha = 1;
            [self setNeedsLayout];
        });
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnWidth = self.showCustormCancelBtn ? 40 : 0;
    self.cancelBtn.frame = CGRectMake(self.width - btnWidth, 0, btnWidth, 40);
    self.cancelBtn.centerY = self.searchTextField.centerY;
    self.searchTextField.width = self.cancelBtn.left - self.searchTextField.left;
}

#pragma mark - Action
- (void)onCancelBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]) {
        [self.delegate searchBarCancelButtonClicked:self];
    }
}

#pragma mark - Private
- (UIView*)_getSubViewOfClass:(NSString*)str view:(UIView *)superView {
    if ([superView isKindOfClass:NSClassFromString(str)]) {
        return superView;
    }
    
    for (UIView * view in superView.subviews) {
        UIView * v =  [self _getSubViewOfClass:str view:view];
        if (v) return v;
    }
    return nil;
}

- (void)setShowCustormCancelBtn:(BOOL)showCustormCancelBtn {
    if (showCustormCancelBtn == _showCustormCancelBtn) {
        return;
    }
    
    _showCustormCancelBtn = showCustormCancelBtn;
    [self setNeedsLayout];
}

@end
