//
//  XSTSectionVM.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/5.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSTCellVM.h"

@interface XSTSectionVM : NSObject

@property (nonatomic, strong) XSTCellVM * headerVM;
@property (nonatomic, strong) NSMutableArray<XSTCellVM*> * cellVMList;
@property (nonatomic, strong) XSTCellVM * footerVM;

@end
