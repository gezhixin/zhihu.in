//
//  UserCellNode.h
//  zhihukantu
//
//  Created by gezhixin on 2017/11/25.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface UserCellNode : ASCellNode

@property (nonatomic, strong) ASNetworkImageNode * imageNode;
@property (nonatomic, strong) ASTextNode * title;
@property (nonatomic, strong) ASTextNode * subTitleNode;

@end
