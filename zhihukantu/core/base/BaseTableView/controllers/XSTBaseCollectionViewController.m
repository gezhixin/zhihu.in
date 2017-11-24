//
//  XSTBaseCollectionViewController.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/7/5.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTBaseCollectionViewController.h"

@interface XSTBaseCollectionViewController ()  {
}

@end

@implementation XSTBaseCollectionViewController

- (instancetype)init {
    ASDisplayNode * node = [[ASDisplayNode alloc] init];
    node.backgroundColor = skin.colorNormalBackground;
    self = [super initWithNode:node];
    if (self) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        ASCollectionNode * tableNode = [[ASCollectionNode alloc] initWithCollectionViewLayout:layout];
        tableNode.delegate = self;
        tableNode.dataSource = self;
        tableNode.allowsSelection = YES;
        tableNode.view.alwaysBounceVertical = YES;
        tableNode.backgroundColor = [UIColor clearColor];
        [self.node addSubnode:tableNode];
        self.tableNode = tableNode;
        @weakify(self);
        self.node.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
            @strongify(self);
            return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:self.tableNode];
        };
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - ASCollectionView Data Source
- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    return self.tableData.count;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return self.tableData[section].cellVMList.count;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSTCellVM * cellVM = self.tableData[indexPath.section].cellVMList[indexPath.row];
    return cellVM.sizeRange;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSTCellVM * cellVM = self.tableData[indexPath.section].cellVMList[indexPath.row];
    return [cellVM cellBlockWithCollectionNode:collectionNode indexPath:indexPath];
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForHeaderInSection:(NSInteger)section {
    XSTCellVM * hvm = self.tableData[section].headerVM;
    return hvm.sizeRange;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForFooterInSection:(NSInteger)section {
     XSTCellVM * hvm = self.tableData[section].footerVM;
    return hvm.sizeRange;
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XSTCellVM * hvm = self.tableData[indexPath.section].headerVM;
        return hvm.cellNodeBlock ? hvm.cellNodeBlock() : [ASCellNode new];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        XSTCellVM * fvm = self.tableData[indexPath.section].footerVM;
        return fvm.cellNodeBlock ? fvm.cellNodeBlock() : [ASCellNode new];
    } else {
        return [ASCellNode new];
    }
}

- (NSArray<NSString *> *)collectionNode:(ASCollectionNode *)collectionNode supplementaryElementKindsInSection:(NSInteger)section {
    return @[UICollectionElementKindSectionHeader, UICollectionElementKindSectionFooter];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0 && self.headerBackgroundNode) {
        self.headerBackgroundNode.frame = CGRectMake(0, scrollView.contentOffset.y, scrollView.width, ABS(scrollView.contentOffset.y));
    }
}

- (NSMutableArray<XSTSectionVM *> *)tableData {
    if (!_tableData) {
        _tableData = [NSMutableArray array];
    }
    
    return _tableData;
}


@end
