//
//  XOptionActionSheet.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XOptionGrounpItem.h"

@class XOptionActionSheet;

typedef void(^XOptionActionSheetClicked)(XOptionActionSheet * sheet, NSIndexPath * indexPath, XOptionItem * item);

@interface XOptionActionSheet : UIView

@property (nonatomic, strong) NSArray<XOptionGrounpItem*> * optionGrounps;

@property (nonatomic, copy) XOptionActionSheetClicked blkAction;

- (instancetype)initWithTitle:(NSString*)title
                optionGrounps:(NSArray<XOptionGrounpItem*>*)optionGrounps
                optionClicked:(XOptionActionSheetClicked)optionClicked;

+ (instancetype)showWithTitle:(NSString *)title optionGrounps:(NSArray<XOptionGrounpItem*>*)optionGrounps optionClicked:(XOptionActionSheetClicked)optionClicked;

- (void)reloadOption;

@end
