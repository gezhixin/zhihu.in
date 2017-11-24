//
//  XSTImagePicker.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/19.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BLKImagePickerResult)(UIViewController * pickerViewController, UIImage *image);

@interface XSTImagePicker : NSObject

- (void)pickImageInViewController:(UIViewController *)viewController
                       enableEdit:(BOOL)enableEdit
                      filterMovie:(BOOL)filterMove
                           result:(BLKImagePickerResult)result;

- (void)takePhotoInViewController:(UIViewController *)viewController
                       enableEdit:(BOOL)enableEdit
                           result:(BLKImagePickerResult)result;

- (void)hideWithAnimated:(BOOL)animated;

@end
