//
//  UserInfoCellVM.m
//  zhihukantu
//
//  Created by gezhixin on 2017/11/25.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "UserInfoCellVM.h"
#import "UserCellNode.h"

@implementation UserInfoCellVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sizeRange = (ASSizeRange){{ScreenW / 2, 0}, {ScreenW, ScreenH}};
    }
    return self;
}

- (ASCellNodeBlock)cellBlockWithCollectionNode:(ASCollectionNode *)collectionNode indexPath:(NSIndexPath*)indexPath {
    @weakify(self);
    return ^ {
        @strongify(self);
        UserCellNode * node = [[UserCellNode alloc] init];
        node.imageNode.URL = [NSURL URLWithString:self.avart];
        return node;
    };
}

@end
