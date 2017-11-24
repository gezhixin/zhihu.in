//
//  XSTCodeTextField.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/24.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTCodeTextField.h"

@interface XSTCodeTextField () <UITextFieldDelegate>

@end

@implementation XSTCodeTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        [self initView];
        self.activty = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initView {
    self.keyboardType = UIKeyboardTypePhonePad;
    self.textColor = skin.colorTitle;
    self.textAlignment = NSTextAlignmentCenter;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
    self.layer.borderWidth = 1;
}

- (void)clear {
    self.activty = NO;
    self.text = nil;
}

- (void)setActivty:(BOOL)activty {
    _activty = activty;
    if (activty) {
        self.layer.borderColor = skin.colorTitle.CGColor;
        self.userInteractionEnabled = YES;
        [self becomeFirstResponder];
    } else {
        self.layer.borderColor = skin.colorLine.CGColor;
        self.userInteractionEnabled = NO;
        [self resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.didEdit) {
        self.didEdit(self);
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    textField.text = string;
    if (self.text.length > 0) {
        if (self.nextStep) {
            BOOL next = self.nextStep(self);
            if (next) {
                self.activty = NO;
            }
        }
    }
    return NO;
}

- (void)deleteBackward {
    
    if (self.text.length == 0) {
        if (self.lastStep) {
            BOOL next = self.lastStep(self);
            if (next) {
                self.activty = NO;
            }
        }
    }
    [super deleteBackward];
    
}

- (void)onTextChanged:(NSNotification *)notfication {
    if (self.text.length > 0) {
        if (self.nextStep) {
            BOOL next = self.nextStep(self);
            if (next) {
                self.activty = NO;
            }
        }
    }
}

@end
