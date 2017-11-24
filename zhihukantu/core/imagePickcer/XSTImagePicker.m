//
//  XSTImagePicker.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/19.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTImagePicker.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface XSTImagePicker () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign) BOOL allowEditing;
// 是否过滤掉视频
@property (nonatomic, assign) BOOL shouldFilterMovie;

@property (nonatomic, copy) BLKImagePickerResult blkImagePickerResult;

@property (nonatomic, weak) UIViewController * pikerViewController;

@end

@implementation XSTImagePicker

- (void)pickImageInViewController:(UIViewController *)viewController enableEdit:(BOOL)enableEdit filterMovie:(BOOL)filterMove result:(BLKImagePickerResult)result {
    
    self.allowEditing = enableEdit;
    self.shouldFilterMovie = filterMove;
    self.blkImagePickerResult = result;
    
    PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
    if (author == PHAuthorizationStatusRestricted || author == PHAuthorizationStatusDenied){
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机权限已经关闭，请到“隐私”－“相机”下打开权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action1];
        [viewController presentViewController:alert animated:YES completion:nil];
        return;
    }
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    self.pikerViewController = pickerImage;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        NSMutableArray *mediaTypes = [NSMutableArray arrayWithArray:[UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType]];
        if (self.shouldFilterMovie) {
            for (NSString *tmp in mediaTypes) {
                if ([tmp isEqualToString:@"public.movie"]) {
                    [mediaTypes removeObject:tmp];
                    break;
                }
            }
        }
        pickerImage.mediaTypes = mediaTypes;
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = self.allowEditing;
    [viewController presentViewController:pickerImage animated:YES completion:^{
        
    }];
}

- (void)takePhotoInViewController:(UIViewController *)viewController enableEdit:(BOOL)enableEdit result:(BLKImagePickerResult)result {
    self.allowEditing = enableEdit;
    self.blkImagePickerResult = result;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([[UIDevice currentDevice] systemVersion].floatValue > 7.0){
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusAuthorized //允许
            || authStatus == AVAuthorizationStatusNotDetermined //用户未明确。通常是应用程序没有访问过，第一次访问系统会弹出提示框
            )
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            self.pikerViewController = picker;
            picker.delegate = self;
            picker.allowsEditing = self.allowEditing;//设置可编辑
            picker.sourceType = sourceType;
            [viewController presentViewController:picker animated:YES completion:^{
                
            }];//进入照相界面
        }
        else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机权限已经关闭，请到“隐私”－“相机”下打开权限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action1];
            [viewController presentViewController:alert animated:YES completion:nil];
        }
        
    }
}

- (void)hideWithAnimated:(BOOL)animated {
    [self.pikerViewController dismissViewControllerAnimated:animated completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //使用截取后的图片方便显示
        UIImage* image = self.allowEditing ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.blkImagePickerResult) {
            self.blkImagePickerResult(picker, image);
        }
    }
}

@end
