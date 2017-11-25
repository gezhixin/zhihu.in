//
//  XSTUserInfoSettingViewController.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/14.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTUserInfoSettingViewController.h"
#import "XSTTextEditViewController.h"

@interface XSTUserInfoSettingViewController ()

@end

@implementation XSTUserInfoSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"过滤";
    
    [self loadOptions];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserInfoChangedNotification:) name:KUserInfoChanged object:nil];
    
    if (self.navigationController.viewControllers.firstObject == self) {
        @weakify(self);
        [self setLeftNavigationItems:@[@"关闭"] clicked:^(id sender, NSInteger index) {
            @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)loadOptions {
    
    XSTOptionItem * locationItem = [XSTOptionItem rightArrowOptionItem:@"地区"];
    locationItem.rightText = @"成都";
    
    XSTOptionItem * genderItem = [XSTOptionItem rightArrowOptionItem:@"性别"];
    NSArray * genderStrArr = @[@"未知", @"男", @"女"];
    genderItem.rightText = genderStrArr[2];
    
    XSTOptionItem * educationItem = [XSTOptionItem rightArrowOptionItem:@"学校"];
    educationItem.rightText = @"";
    
    XSTOptionItem * businessItem = [XSTOptionItem rightArrowOptionItem:@"行业"];
    businessItem.rightText = @"";
    
    
    self.optionItems = @[@[locationItem, genderItem, educationItem, businessItem]];
}

- (void)optionDidSelected:(XSTOptionItem *)option IndexPath:(NSIndexPath *)indexPath {
    if ([option.option isEqualToString:@"地区"]) {
        XSTTextEditViewController * vc = [XSTTextEditViewController instanceWithTitle:@"设置地区" text:@"aaf" placeholder:@"填写地区" complated:^(BOOL success, NSString *newText) {
            if (success) {
            }
        }];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([option.option isEqualToString:@"学校"]) {
        XSTTextEditViewController * vc = [XSTTextEditViewController instanceWithTitle:@"设置学校" text:@"" placeholder:@"填写学校" complated:^(BOOL success, NSString *newText) {
            if (success) {
            }
        }];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([option.option isEqualToString:@"性别"]) {
        UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"修改性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        @weakify(self);
        UIAlertAction * alertAction0 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
        }];
        
        UIAlertAction * alertAction1 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
        }];
        
        UIAlertAction * alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:alertAction0];
        [alertControl addAction:alertAction1];
        [alertControl addAction:alertAction2];
        
        [self presentViewController:alertControl animated:YES completion:nil];
    }
}


- (void)onUserInfoChangedNotification:(NSNotification *)notification {
    [self loadOptions];
    [self reloadOptions];
}

@end
