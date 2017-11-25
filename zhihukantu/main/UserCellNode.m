//
//  UserCellNode.m
//  zhihukantu
//
//  Created by gezhixin on 2017/11/25.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "UserCellNode.h"

@interface UserCellNode () <ASNetworkImageNodeDelegate>


@end

@implementation UserCellNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageNode = [[ASNetworkImageNode alloc] init];
        self.imageNode.delegate = self;
        [self addSubnode:_imageNode];
    }
    return self;
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    CGFloat w = ScreenW / 2 - 1;
    if (self.imageNode.image) {
        CGFloat h = w * self.imageNode.image.size.height / self.imageNode.image.size.width;
        
        self.imageNode.style.preferredSize = CGSizeMake(w, h);
    } else {
        self.imageNode.style.preferredSize = CGSizeMake(w, w);
    }
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:(UIEdgeInsets){0, 0, 0, 0} child:self.imageNode];
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    [self setNeedsLayout];
}

@end
