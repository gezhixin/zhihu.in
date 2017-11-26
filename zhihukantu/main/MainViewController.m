//
//  MainViewController.m
//  zhihukantu
//
//  Created by gezhixin on 2017/11/25.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "MainViewController.h"
#import "XSTHttpManager.h"
#import "UserInfoCellVM.h"
#import "XSTUserInfoSettingViewController.h"
#import "XSTNavigationViewController.h"
#import "XSTTextEditViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) NSURLSessionDataTask * task;

@property (nonatomic, strong) NSMutableDictionary * filter;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filter = [NSMutableDictionary dictionary];
    [self.filter setObject:@"成都" forKey:@"location"];
    self.title = [self.filter objectForKey:@"location"];
    @weakify(self);
    [self setRightNavigationItems:@[@"过滤", @"刷新"] clicked:^(id sender, NSInteger index) {
        @strongify(self);
        if (index == 0) {
            [self showFilter];
        } else if (index == 1) {
            [self fetchData];
        }
    }];
    
    [self fetchData];
}

- (void)showFilter {
//    XSTUserInfoSettingViewController * vc = [[XSTUserInfoSettingViewController alloc] init];
    XSTTextEditViewController * vc = [XSTTextEditViewController instanceWithTitle:@"地区"
                                                                             text:[self.filter objectForKey:@"location"]
                                                                      placeholder:@"" complated:^(BOOL success, NSString *newText) {
                                                                          if (success && newText) {
                                                                              [self.filter setObject:newText forKey:@"location"];
                                                                              self.title = [self.filter objectForKey:@"location"];
                                                                              [self fetchData];
                                                                          }
                                                                      }];
    XSTNavigationViewController * nav = [[XSTNavigationViewController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)fetchData {
    [XSTHttpManager getWithUrl:@"http://192.168.0.108:8080/user/s" parma:@{@"location": [self.filter objectForKey:@"location"], @"count": @(5000)} complated:^(NSDictionary *resultDic, int code, NSString *msg) {
        if (code == 0) {
            [self.tableData removeAllObjects];
            NSArray<NSDictionary*> * userList = [resultDic objectForKey:@"data"];
            XSTSectionVM * section = [[XSTSectionVM alloc] init];
            for (NSDictionary * userDic in userList) {
                UserInfoCellVM * vm = [[UserInfoCellVM alloc] init];
                vm.avart = [userDic objectForKey:@"avart"];
                vm.userPageUrl = [userDic objectForKey:@"home_page_url"];
                vm.userToken = [userDic objectForKey:@"url_token"];
                
                [section.cellVMList addObject:vm];
            }
            
            [self.tableData addObject:section];
            [self.tableNode reloadData];
        }
    }];
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoCellVM * vm = (UserInfoCellVM*)self.tableData[indexPath.section].cellVMList[indexPath.row];
    NSString * url = [NSString stringWithFormat:@"zhihu://people/%@", vm.userToken];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(velocity.y>0)
    {
        self.navigationController.navigationBar.hidden = YES;
    }
    else
    {
        self.navigationController.navigationBar.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
