//
//  XOptionTableViewCell.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/9/12.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XOptionTableViewCell.h"

@interface XOptionTableViewCell ()

@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * bottomLine;

@end

@implementation XOptionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)initUI {
    
    self.backgroundColor = [UIColor whiteColor];
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = view;
    
    self.icon = [[UIImageView alloc] init];
    [self.contentView addSubview:_icon];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize imageSize = self.icon.image.size;
    if (imageSize.width > 0) {
        self.icon.frame = (CGRect){15,(self.height - imageSize.height) / 2, imageSize};
    }
    
    CGFloat titleLeft = imageSize.width > 0 ? self.icon.right + 10 : 15;
    self.titleLabel.frame = (CGRect){titleLeft, 0, self.width - titleLeft - 15, self.height};
}

- (void)setOptionItem:(XOptionItem *)optionItem {
    
    _optionItem = optionItem;
    
    self.icon.image = _optionItem.isSelected ? (_optionItem.selectImage == nil ? _optionItem.normalImage : _optionItem.selectImage) : _optionItem.normalImage;
    self.titleLabel.text = _optionItem.title;
    self.titleLabel.textColor = _optionItem.isSelected ? _optionItem.selectColor : _optionItem.normalColor;
}

@end
