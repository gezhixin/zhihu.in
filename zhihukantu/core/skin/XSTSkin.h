//
//  XSTSkin.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/2/2.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Font Define

@interface XSTSkin : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Color
@property (nonatomic, strong, readonly) UIColor * colorMainTint;
@property (nonatomic, strong, readonly) UIColor * colorHeighlight;
@property (nonatomic, strong, readonly) UIColor * colorTitle;
@property (nonatomic, strong, readonly) UIColor * colorSubTitle;
@property (nonatomic, strong, readonly) UIColor * colorDetailContent;
@property (nonatomic, strong, readonly) UIColor * colorPlaceholder;
@property (nonatomic, strong, readonly) UIColor * colorCellHighlight;
@property (nonatomic, strong, readonly) UIColor * colorLine;
@property (nonatomic, strong, readonly) UIColor * colorNormalBackground;
@property (nonatomic, strong, readonly) UIColor * colorBlockBackground;

#pragma mark - Font
/*
 * 用A、B……从大到小规定使用的字体
 */
@property (nonatomic, strong, class, readonly)  UIFont * bFontBig;
@property (nonatomic, strong, class, readonly)  UIFont * fontA;
@property (nonatomic, strong, class, readonly)  UIFont * fontB;
@property (nonatomic, strong, class, readonly)  UIFont * fontC;
@property (nonatomic, strong, class, readonly)  UIFont * fontD;
@property (nonatomic, strong, class, readonly)  UIFont * fontE;
@property (nonatomic, strong, class, readonly)  UIFont * fontF;

/* 粗体 */
@property (nonatomic, strong, class, readonly)  UIFont * bFontA;
@property (nonatomic, strong, class, readonly)  UIFont * bFontB;
@property (nonatomic, strong, class, readonly)  UIFont * bFontC;
@property (nonatomic, strong, class, readonly)  UIFont * bFontD;
@property (nonatomic, strong, class, readonly)  UIFont * bFontE;
@property (nonatomic, strong, class, readonly)  UIFont * bFontF;

@end
