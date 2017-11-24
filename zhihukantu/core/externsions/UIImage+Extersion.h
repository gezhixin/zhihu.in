//
//  UIImage+Extersion.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/14.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Extersion)

- (UIImage *)imageByScreenScaleToSize:(CGSize)size;

- (UIImage *)jpgIamgeZiped;
- (NSData *)jpgDataZiped;

+ (UIImage *)bookImageWithTitle:(NSString *)title;

@end
