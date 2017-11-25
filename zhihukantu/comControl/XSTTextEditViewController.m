//
//  XSTTextEditViewController.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/6.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTTextEditViewController.h"

@interface XSTTextEditViewController ()

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIView * textFieldContentView;
@property (nonatomic, strong) UIScrollView * contentView;
@property (nonatomic, strong) UIButton * rightBtn;

@property (nonatomic, copy) void(^blkComplated)(BOOL success, NSString * newStr);

@property (nonatomic, assign) BOOL textChanged;

@end

@implementation XSTTextEditViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentView = [[UIScrollView alloc] init];
        _contentView.frame = self.view.bounds;
        _contentView.alwaysBounceVertical = YES;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_contentView];
        
        self.textFieldContentView = [[UIView alloc] initWithFrame:(CGRect){0, 30, ScreenW, 50}];
        _textFieldContentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_textFieldContentView];
        
        self.textField = [[UITextField alloc] initWithFrame:(CGRect){20, 0, ScreenW - 40, 50}];
        _textField.backgroundColor = UIColorHex(0xffffff);
        _textField.font = XSTSkin.fontB;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        
        [self.textFieldContentView addSubview:_textField];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    
    
    [self setLeftNavigationItems:@[@"取消"] clicked:^(id sender, NSInteger index) {
        @strongify(self);
        [self onCancelBtnClicked:sender];
    }];
    
    
    [self setRightNavigationItems:@[self.rightBtn] clicked:^(id sender, NSInteger index) {
        @strongify(self);
        [self.textField endEditing:YES];
        if (self.blkComplated) {
            self.blkComplated(YES, self.textField.text);
        }
        if (self.navigationController.viewControllers.firstObject == self) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
    self.rightBtn.enabled = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)onCancelBtnClicked:(id)sender {
    [self.textField endEditing:YES];
    if (self.textField.text.length > 0 && self.textChanged) {
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:nil message:@"保存本次编辑？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * notSave = [UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.navigationController.viewControllers.firstObject == self) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [super onCancelBtnClicked:sender];
            }
        }];
        UIAlertAction * save = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.blkComplated) {
                self.blkComplated(YES, self.textField.text);
            }
            if (self.navigationController.viewControllers.firstObject == self) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [super onCancelBtnClicked:sender];
            }
        }];
        [alter addAction:notSave];
        [alter addAction:save];
        [self presentViewController:alter animated:YES completion:nil];
        
    } else {
        [super onCancelBtnClicked:sender];
    }
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        _rightBtn.enabled = NO;
        _rightBtn.frame = (CGRect){CGPointZero, {40, 40}};
    }
    
    return _rightBtn;
}

+ (instancetype)instanceWithTitle:(NSString *)title text:(NSString*)text placeholder:(NSString *)placeholder complated:(void (^)(BOOL, NSString *))complated {
    XSTTextEditViewController * vc = [[XSTTextEditViewController alloc] init];
    vc.title = title;
    vc.textField.text = text;
    vc.textField.placeholder = placeholder;
    vc.blkComplated = complated;
    [[NSNotificationCenter defaultCenter] addObserver:vc selector:@selector(onTextDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    return vc;
}

- (void)onTextDidChanged:(NSNotification *)notification {
    self.textChanged = YES;
    self.rightBtn.enabled = self.textField.text.length > 0;
}

@end

