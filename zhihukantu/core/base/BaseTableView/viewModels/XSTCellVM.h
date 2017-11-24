//
//  XSTCellVM.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/5.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface XSTCellVM : NSObject

@property (nonatomic, strong) id item;
@property (nonatomic, copy) ASCellNodeBlock cellNodeBlock;
@property (nonatomic, assign) ASSizeRange sizeRange;

- (ASCellNodeBlock)cellBlockWithCollectionNode:(ASCollectionNode *)collectionNode indexPath:(NSIndexPath*)indexPath;

@end
