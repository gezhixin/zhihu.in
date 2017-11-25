//
//  XSTBaseOptionsViewController.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/14.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTBaseViewController.h"
#import "XSTOptionCell.h"

@interface XSTBaseOptionsViewController : XSTBaseViewController

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray<NSArray<XSTOptionItem*>*> * optionItems;

- (void)optionDidSelected:(XSTOptionItem *)option IndexPath:(NSIndexPath *)indexPath;

- (void)reloadOptions;

@end
