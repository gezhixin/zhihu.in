//
//  XOptionItem.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XOptionItem : NSObject

@property (nonatomic, strong) UIImage * normalImage;
@property (nonatomic, strong) UIImage * selectImage;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UIColor * normalColor;
@property (nonatomic, strong) UIColor * selectColor;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
