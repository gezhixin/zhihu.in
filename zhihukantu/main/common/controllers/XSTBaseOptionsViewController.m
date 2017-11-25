//
//  XSTBaseOptionsViewController.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/14.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTBaseOptionsViewController.h"

@interface XSTBaseOptionsViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation XSTBaseOptionsViewController

- (void)loadView {
    [super loadView];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = skin.colorNormalBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -  setter
- (void)setOptionItems:(NSArray<NSArray<XSTOptionItem *> *> *)optionItems {
    _optionItems = optionItems;
    [self.tableView reloadData];
}

#pragma mark -  UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.optionItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionItems[section].count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 20;
    } else {
        XSTOptionItem * item = self.optionItems[indexPath.section][indexPath.row - 1];
        return item.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"grounpHeaderCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"grounpHeaderCell"];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    } else {
        XSTOptionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XSTOptionCell"];
        if (cell == nil) {
            cell = [[XSTOptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XSTOptionCell"];
        }
        cell.optionItem = self.optionItems[indexPath.section][indexPath.row - 1];
        cell.showBottomLine = !(indexPath.row == self.optionItems[indexPath.section].count);
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        return;
    }
    
    XSTOptionItem * item = self.optionItems[indexPath.section][indexPath.row - 1];
    [self optionDidSelected:item IndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section]];
}

- (void)optionDidSelected:(XSTOptionItem *)option IndexPath:(NSIndexPath *)indexPath {
    
}

- (void)reloadOptions {
    [self.tableView reloadData];
}

@end
