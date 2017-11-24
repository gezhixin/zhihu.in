//
//  XSTIconTitleActionBar.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/20.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSTIconTitleActionItem : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * selectTitle;

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) UIImage * selectImage;

@property (nonatomic, assign) BOOL disable;

+ (instancetype)itemWithTitle:(NSString*)title icon:(UIImage*)icon;

@end

@interface XSTIconTitleActionBar : UIView

@property (nonatomic, strong) UIVisualEffectView * backgroundView;

- (instancetype)initWithItems:(NSArray<XSTIconTitleActionItem*>*)items aciton:(void(^)(NSInteger index))action;

@end
