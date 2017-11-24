//
//  XSTCellVM.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/5.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTCellVM.h"

@implementation XSTCellVM

- (ASCellNodeBlock)cellBlockWithCollectionNode:(ASCollectionNode *)collectionNode indexPath:(NSIndexPath *)indexPath {
    return self.cellNodeBlock;
}

@end
