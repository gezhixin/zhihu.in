//
//  UIImage+Extersion.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/14.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "UIImage+Extersion.h"
#import <YYCategories/YYCategories.h>

@implementation UIImage(Extersion)

- (UIImage *)imageByScreenScaleToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)jpgIamgeZiped {
    return [UIImage imageWithData:[self jpgDataZiped]];
}

- (NSData *)jpgDataZiped {
    NSData* data = UIImageJPEGRepresentation(self, 1);
    if (data.length > 1024 * 1014 * 2) {
        data = UIImageJPEGRepresentation(self, 0.1);
    } else if (data.length > 1024 * 1024) {
        data = UIImageJPEGRepresentation(self, 0.3);
    } else if (data.length>512*1024) {
        data=UIImageJPEGRepresentation(self, 0.5);
    } else if (data.length>200*1024) {
        data=UIImageJPEGRepresentation(self, 0.9);
    }
    return data;
}

+ (UIImage *)bookImageWithTitle:(NSString *)title {
    
    NSString * imageName = [NSString stringWithFormat:@"%@.jpg", title.md5String];
    NSString * imagePath = [[XSTDirectoryConfig sharedInstance].tempDirectory stringByAppendingPathComponent:imageName];
    
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    
    if (!image) {
        UIView * view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, 160, 160 * 438 / 303}];
        view.backgroundColor = [UIColor colorWithRGB:0x8DB6CD];
        UITextView * textView = [[UITextView alloc] initWithFrame:(CGRect){12, 12, view.width - 24, view.height - 30}];
        textView.textColor = [UIColor colorWithRGB:0xFFFAF0];
        textView.font = [UIFont boldSystemFontOfSize:28];
        textView.text = title;
        textView.backgroundColor = [UIColor clearColor];
        [view addSubview:textView];
        
        image = [view snapshotImage];
        NSData* data = UIImageJPEGRepresentation(image, 1);
        [data writeToFile:imagePath atomically:YES];
    }
    
    return image;
}

@end
