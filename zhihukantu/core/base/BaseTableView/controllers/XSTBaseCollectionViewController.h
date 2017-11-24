//
//  XSTBaseCollectionViewController.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/5.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTBaseViewController.h"
#import "XSTSectionVM.h"

@interface XSTBaseCollectionViewController : XSTBaseViewController <
ASCollectionDelegate,
ASCollectionDataSource
>

@property (nonatomic, strong) ASCollectionNode * tableNode;
@property (nonatomic, strong) ASDisplayNode * headerBackgroundNode;
@property (nonatomic, strong) NSMutableArray<XSTSectionVM*>* tableData;


@end
