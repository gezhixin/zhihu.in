//
//  XOptionGrounpItem.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XOptionItem.h"

@interface XOptionGrounpItem : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray<XOptionItem*>* optionItems;

@end
