//
//  XSTSkin.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/2.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTSkin.h"

@implementation XSTSkin

+ (instancetype)sharedInstance {
    static XSTSkin * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XSTSkin alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadColor];
    }
    return self;
}

- (void)loadColor {
    
    _colorMainTint = [UINavigationController new].navigationBar.tintColor;
    _colorHeighlight = UIColorHex(0x06af5e);
    _colorTitle = UIColorHex(0x333333);
    _colorSubTitle = UIColorHex(0x555555);
    _colorDetailContent = UIColorHex(0x777777);
    _colorPlaceholder = UIColorHex(0xd0d0d0);
    _colorCellHighlight = UIColorHex(0xeeeeee);
    _colorLine = UIColorHex(0xdddddd);
    _colorNormalBackground = UIColorHex(0xf9f9f9);
    _colorBlockBackground = [UIColor whiteColor];
}

+ (UIFont *)fontA {
    return XFontSize(18);
}

+ (UIFont *)fontB {
    return XFontSize(16);
}

+ (UIFont *)fontC {
    return XFontSize(15);
}

+ (UIFont *)fontD {
    return XFontSize(14);
}

+ (UIFont *)fontE {
    return XFontSize(12);
}

+ (UIFont *)fontF {
    return XFontSize(10);
}

+ (UIFont *)bFontBig {
    return XBoldFontSize(22);
}

+ (UIFont *)bFontA {
    return XBoldFontSize(18);
}

+ (UIFont *)bFontB {
    return XBoldFontSize(16);
}

+ (UIFont *)bFontC {
    return XBoldFontSize(15);
}

+ (UIFont *)bFontD {
    return XBoldFontSize(14);
}

+ (UIFont *)bFontE {
    return XBoldFontSize(12);
}

+ (UIFont *)bFontF {
    return XBoldFontSize(10);
}

@end
