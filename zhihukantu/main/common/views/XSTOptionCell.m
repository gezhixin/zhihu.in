//
//  XSTOptionCell.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/13.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTOptionCell.h"
#import <YYCategories/YYCategories.h>
#import <SDWebImage/UIImageView+WebCache.h>


@interface XSTOptionCell ()

@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * optionLabel;
@property (nonatomic, strong) UILabel * rightTextLabel;
@property (nonatomic, strong) UIImageView * rightImageView;
@property (nonatomic, strong) UIImageView * rightIcon;
@property (nonatomic, strong) UIImageView * bottomLine;

@end

@implementation XSTOptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showBottomLine = YES;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.icon = [[UIImageView alloc] init];
    [self.contentView addSubview:_icon];
    
    self.optionLabel = [[UILabel alloc] init];
    _optionLabel.font = [XSTSkin fontB];
    _optionLabel.textColor = skin.colorTitle;
    [self.contentView addSubview:_optionLabel];
    
    self.rightTextLabel = [[UILabel alloc] init];
    _rightTextLabel.font = [XSTSkin fontC];
    _rightTextLabel.textColor = skin.colorDetailContent;
    _rightTextLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightTextLabel];
    
    self.rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_rightImageView];
    
    self.rightIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_rightIcon];
    
    self.bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = skin.colorLine;
    [self addSubview:_bottomLine];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutUI];
}

- (void)layoutUI {
    
    
    if (self.optionItem.icon == nil &&
        self.optionItem.rightIcon == nil &&
        self.optionItem.rightImage == nil &&
        self.optionItem.rightText == nil &&
        self.optionItem.option != nil) {
        CGFloat w = [self.optionLabel.text widthForFont:_optionLabel.font];
        self.optionLabel.frame = CGRectMake((self.width - w) / 2, 0, w, self.height);
        
        self.bottomLine.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
        
        self.optionLabel.textColor = [UIColor redColor];
        return;
    }
    
    self.optionLabel.textColor = skin.colorTitle;
    
    self.bottomLine.frame = CGRectMake(15, self.height - 0.5, self.width - 15, 0.5);
    
    self.icon.frame = CGRectMake(15, (self.height - self.icon.image.size.height) / 2, self.icon.image.size.width, self.icon.image.size.height);
    
    CGFloat w = [self.optionLabel.text widthForFont:_optionLabel.font];
    CGFloat h = _optionLabel.font.lineHeight;
    self.optionLabel.frame = CGRectMake(_icon.right + (_icon.image == nil ? 0 : 8), (self.height - h) / 2, w, h);
    
    self.rightIcon.frame = CGRectMake(self.width - 10 - _rightIcon.image.size.width, (self.height - _rightIcon.image.size.height) / 2, _rightIcon.image.size.width, self.rightIcon.image.size.height);
    
    CGSize size = _rightImageSize.height > 0 && _rightImageSize.width > 0 ? _rightImageSize : _rightImageView.image.size;
    self.rightImageView.frame = CGRectMake(self.rightIcon.left - (_rightIcon.image == nil ? 0 : 6) - size.width, (self.height - size.height) / 2, size.width, size.height);
    self.rightTextLabel.frame = CGRectMake(_rightImageView.left - (_rightImageView.image == nil ? 0 : 6) - 150, (self.height - _rightTextLabel.font.lineHeight) / 2, 150, _rightTextLabel.font.lineHeight);
}

- (void)setOptionItem:(XSTOptionItem *)optionItem {
    _optionItem = optionItem;

    @weakify(self);
    
    self.icon.image = optionItem.icon;
    
    if (optionItem.icon == nil && optionItem.iconUrl.length > 0) {
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:optionItem.iconUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self);
            [self setNeedsLayout];
        }];
    }
    
    self.optionLabel.text = optionItem.option;
    self.rightTextLabel.text = optionItem.rightText;
    
    self.rightImageView.image = optionItem.rightImage;
    if (optionItem.rightImage == nil && optionItem.rightImageUrl.length > 0) {
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:optionItem.rightImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self);
            [self setNeedsLayout];
        }];
    }
    
    self.rightIcon.image = optionItem.rightIcon;
    if (optionItem.rightIcon == nil && optionItem.rightIconUrl.length > 0) {
        [self.rightIcon sd_setImageWithURL:[NSURL URLWithString:optionItem.rightIconUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self);
            [self setNeedsLayout];
        }];
    }
    self.rightImageSize = optionItem.rightImageSize;
    
    [self setNeedsLayout];
}

- (void)setRightImageSize:(CGSize)rightImageSize {
    _rightImageSize = rightImageSize;
    [self setNeedsLayout];
}

- (void)setShowBottomLine:(BOOL)showBottomLine {
    
    if (_showBottomLine == showBottomLine) {
        return;
    }
    
    _showBottomLine = showBottomLine;
    
    self.bottomLine.hidden = !_showBottomLine;
}

@end


@implementation XSTOptionItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 48;
    }
    return self;
}

- (void)updateHeight {
    CGFloat rightImageHeight = self.rightImageSize.height > 0 && self.rightImageSize.width ? self.rightImageSize.height : self.rightImage.size.height;
    self.height = MAX(32, MAX(self.icon.size.height, MAX(self.rightIcon.size.height, rightImageHeight))) + 16;
}

+ (instancetype)rightArrowOptionItem:(NSString *)option {
    XSTOptionItem * item = [[XSTOptionItem alloc] init];
    item.option = option;
    item.rightIcon = [UIImage imageNamed:@"icon_right_arrow.png"];
    return item;
}

@end

