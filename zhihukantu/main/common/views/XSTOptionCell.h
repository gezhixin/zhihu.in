//
//  XSTOptionCell.h
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/13.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSTOptionItem : NSObject

@property (nonatomic, strong) NSString * option;
@property (nonatomic, strong) UIImage  * icon;
@property (nonatomic, strong) NSString * iconUrl;
@property (nonatomic, strong) UIImage  * rightIcon;
@property (nonatomic, strong) NSString * rightIconUrl;
@property (nonatomic, strong) UIImage  * rightImage;
@property (nonatomic, strong) NSString * rightImageUrl;
@property (nonatomic, strong) NSString * rightText;
@property (nonatomic, assign) CGFloat    height;
@property (nonatomic, assign) CGSize     rightImageSize;


+ (instancetype)rightArrowOptionItem:(NSString *)option;

- (void)updateHeight;

@end

@interface XSTOptionCell : UITableViewCell

@property (nonatomic, assign) CGSize rightImageSize;

@property (nonatomic, assign) BOOL  showBottomLine;

@property (nonatomic, strong) XSTOptionItem * optionItem;

@end
