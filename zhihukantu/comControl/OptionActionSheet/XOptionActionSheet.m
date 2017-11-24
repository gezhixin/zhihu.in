//
//  XOptionActionSheet.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XOptionActionSheet.h"
#import "XOptionGrounpItem.h"
#import "XOptionGrounpTitleView.h"
#import "XOptionTableViewCell.h"

@interface XOptionActionSheet ()<UITableViewDelegate, UITableViewDataSource> {
    CGFloat optionHeight;
}

@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * closeBtn;
@property (nonatomic, strong) UIView * titleViewBottomLine;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSString * title;

@end

@implementation XOptionActionSheet

+ (instancetype)showWithTitle:(NSString *)title
                optionGrounps:(NSArray<XOptionGrounpItem*>*)optionGrounps
                optionClicked:(XOptionActionSheetClicked)optionClicked {
    
    XOptionActionSheet * sheet = [[XOptionActionSheet alloc] initWithTitle:title optionGrounps:optionGrounps optionClicked:optionClicked];
    [sheet show];
    return sheet;
}

- (instancetype)initWithTitle:(NSString*)title
                optionGrounps:(NSArray<XOptionGrounpItem*>*)optionGrounps
                optionClicked:(XOptionActionSheetClicked)optionClicked{
    self = [super init];
    if (self) {
        [self initUI];
        
        self.title = title;
        self.optionGrounps = optionGrounps;
        self.blkAction = optionClicked;
    }
    
    return self;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.top = self.height - self.contentView.height;
        self.backgroundView.backgroundColor = [UIColor colorWithRGB:0x0 alpha:0.45];
    }];
}

- (void)dissmis {
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.top = self.height;
        self.backgroundView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)initUI {
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor colorWithRGB:0x0 alpha:0.0];
    [self addSubview:_backgroundView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
    [self.backgroundView addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleView];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_closeBtn setImage:[UIImage imageNamed:@"icon_close_21"] forState:UIControlStateNormal];
    @weakify(self);
    [_closeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(self);
        [self dissmis];
    }];
    [self.titleView addSubview:_closeBtn];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = skin.colorTitle;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleView addSubview:_titleLabel];
    
    self.titleViewBottomLine = [[UIView alloc] init];
    _titleViewBottomLine.backgroundColor = skin.colorLine;
    [self.titleView addSubview:_titleViewBottomLine];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, CGFLOAT_MIN)];
    _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, CGFLOAT_MIN)];
    _tableView.sectionHeaderHeight = CGFLOAT_MIN;
    _tableView.sectionFooterHeight = CGFLOAT_MIN;
    [self.contentView addSubview:_tableView];
}

- (void)reloadOption {
    [self.tableView reloadData];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)_layoutUI {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundView.frame = self.bounds;
    
    self.contentView.width = self.width;
    
    self.titleView.frame = (CGRect){CGPointZero, self.width, 46};
    self.titleLabel.frame = self.titleView.bounds;
    self.closeBtn.frame = (CGRect){self.titleView.width - 40, 0, 40, self.titleView.height};
    self.titleViewBottomLine.frame = (CGRect){0, self.titleView.height - 0.5, self.titleView.width, 0.5};
    
    self.tableView.frame = (CGRect){0, _titleView.bottom, self.contentView.width, MIN(380, optionHeight)};
    
    self.contentView.frame = (CGRect){0, self.height, self.width, self.tableView.bottom};
}

- (void)setOptionGrounps:(NSArray<XOptionGrounpItem *> *)optionGrounps {
    _optionGrounps = optionGrounps;
    
    CGFloat height = 0;
    
    for (XOptionGrounpItem * grounp in optionGrounps) {
        if (grounp.title.length > 0) {
            height += 40;
        }
        
        for (XOptionItem * optionItem in grounp.optionItems) {
            height += optionItem.cellHeight;
        }
    }
    
    optionHeight = height;
    
    [self _layoutUI];
    [self.tableView reloadData];
}

- (void)onBackgroundTap:(UITapGestureRecognizer *)tap {
    [self dissmis];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    XOptionGrounpItem * grounpItem = self.optionGrounps[section];
    return grounpItem.title.length > 0 ? 40 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XOptionItem * item = self.optionGrounps[indexPath.section].optionItems[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.optionGrounps.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionGrounps[section].optionItems.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XOptionGrounpItem * grounpItem = self.optionGrounps[section];
    if (grounpItem.title.length > 0) {
        XOptionGrounpTitleView * titleView = [[XOptionGrounpTitleView alloc] init];
        titleView.titleLabel.text = grounpItem.title;
        return titleView;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XOptionTableViewCell * cell = (XOptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"XOptionTableViewCell"];
    if (cell == nil) {
        cell = [[XOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XOptionTableViewCell"];
    }
    
    cell.optionItem = self.optionGrounps[indexPath.section].optionItems[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.blkAction) {
        self.blkAction(self, indexPath, self.optionGrounps[indexPath.section].optionItems[indexPath.row]);
    }
}

@end
