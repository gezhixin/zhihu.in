//
//  XSTVerifyCodePopoView.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/24.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTVerifyCodePopoView.h"
#import "XSTCodeTextField.h"

@interface XSTVerifyCodePopoView () {
    int timerCounter;
}
@property (nonatomic, strong) UIScrollView * contentView;
@property (nonatomic, strong) UIVisualEffectView * backgroudView;

@property (nonatomic, strong) UIView * inpurtContentView;

@property (nonatomic, strong) UILabel * tipsLabel;
@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UIButton * resendBtn;
@property (nonatomic, strong) UIButton * closeBtn;

@property (nonatomic, strong) NSMutableArray<XSTCodeTextField*>* textFieldList;

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation XSTVerifyCodePopoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textFieldList = [NSMutableArray arrayWithCapacity:4];
        [self initView];
        [self startTimer];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void) initView {
    self.backgroundColor = [UIColor clearColor];
    self.frame = [UIScreen mainScreen].bounds;

    self.backgroudView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.backgroudView.backgroundColor = [UIColor colorWithRGB:0x0 alpha:0.0];
    self.backgroudView.frame = self.bounds;
    self.backgroudView.alpha = 0;
    [self addSubview:_backgroudView];
    
    self.contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.contentView.showsVerticalScrollIndicator = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.alwaysBounceVertical = YES;
    [self addSubview:_contentView];
    
    
    self.inpurtContentView = [[UIView alloc] initWithFrame:CGRectMake(30, 84, ScreenW - 60, 0)];
    self.inpurtContentView.layer.cornerRadius = 5;
    self.inpurtContentView.layer.masksToBounds = YES;
    self.inpurtContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_inpurtContentView];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"icon_close_21"] forState:UIControlStateNormal];
    _closeBtn.frame = CGRectMake(_inpurtContentView.width - 40, 0, 40, 40);
    [_closeBtn addTarget:self action:@selector(onCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [_inpurtContentView addSubview:_closeBtn];
    
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, _inpurtContentView.width - 20, [XSTSkin fontB].lineHeight)];
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.text = @"输入验证码";
    _tipsLabel.font = [XSTSkin bFontA];
    _tipsLabel.textColor = skin.colorTitle;
    [_inpurtContentView addSubview:_tipsLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:(CGRect){10, _tipsLabel.bottom + 10, _inpurtContentView.width - 20, [XSTSkin fontE].lineHeight}];
    self.phoneLabel.font = [XSTSkin fontE];
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneLabel.textColor = skin.colorDetailContent;
    [_inpurtContentView addSubview:_phoneLabel];
    
    self.resendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_resendBtn addTarget:self action:@selector(onReSendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _resendBtn.layer.borderColor = skin.colorDetailContent.CGColor;
    _resendBtn.layer.cornerRadius = 2;
    _resendBtn.layer.borderWidth = 0.5;
    [_resendBtn setTitleColor:skin.colorSubTitle forState:UIControlStateNormal];
    [_resendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    _resendBtn.titleLabel.font = [XSTSkin fontE];
    _resendBtn.frame = CGRectMake((_inpurtContentView.width - 70) / 2, _phoneLabel.bottom + 15, 70, 24);
    [_inpurtContentView addSubview:_resendBtn];
    
    CGFloat left = (_inpurtContentView.width - 184) / 2;
    for (int i = 0; i < 4; i++) {
        XSTCodeTextField * codeTextField = [[XSTCodeTextField alloc] initWithFrame:CGRectMake(left + 48 * i, _resendBtn.bottom + 36, 40, 40)];
        codeTextField.activty = i == 0;
        codeTextField.index = i;
        @weakify(self);
        codeTextField.nextStep = ^BOOL(XSTCodeTextField *textField) {
            @strongify(self);
            if (textField.index < 3) {
                self.textFieldList[textField.index + 1].activty = YES;
            } else if (textField.index == 3) {
                if (self.inputComplated) {
                    self.inputComplated(self);
                }
            }
            return NO;
        };
        codeTextField.lastStep = ^BOOL(XSTCodeTextField *textField) {
            @strongify(self);
            if (textField.index > 0) {
                self.textFieldList[textField.index - 1].activty = YES;
            }
            
            return textField.index != 0;
        };
        codeTextField.didEdit = ^(XSTCodeTextField *textField) {
            @strongify(self);
            for (int i = textField.index + 1; i < 4; i++) {
                [self.textFieldList[i] clear];
            }
        };
        [_inpurtContentView addSubview:codeTextField];
        [self.textFieldList addObject:codeTextField];
    }
    
    self.inpurtContentView.height = self.textFieldList.firstObject.bottom + 40;
    self.inpurtContentView.top = 0 - self.inpurtContentView.height;
}

- (void)onCloseAction:(id)sender {
    [self dismiss];
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    _phoneNumber = [phoneNumber copy];
    self.phoneLabel.text = _phoneNumber;
}

- (void)showAnimation {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroudView.alpha = 1;
        self.inpurtContentView.top = 84;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [self endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroudView.alpha = 0;
        self.inpurtContentView.top = 0 - self.inpurtContentView.height;
    } completion:^(BOOL finished) {
        if (self.dissmissed) {
            self.dissmissed();
        }
        [self removeFromSuperview];
    }];
}


- (void)startTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    timerCounter = 51;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimerCallBack:) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)onTimerCallBack:(id)sender {
    timerCounter --;
    if (timerCounter <= 0) {
        [self.resendBtn setTitle:@"从新发送" forState:UIControlStateNormal];
        self.resendBtn.enabled = YES;
        [self stopTimer];
    } else {
        NSString * title = [NSString stringWithFormat:@"%d 秒", timerCounter];
        [self.resendBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)onReSendBtnClicked:(UIButton *)sender {
    [self startTimer];
}

@end
