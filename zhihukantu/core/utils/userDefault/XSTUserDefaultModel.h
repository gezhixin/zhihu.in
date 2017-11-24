//
//  XSTUserDefaultModel.h
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/31.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSTDBProtocol.h"

@interface XSTUserDefaultModel : NSObject<XSTDBProtocol>

@property (nonatomic, copy) NSString * key;
@property (nonatomic, copy) NSString * value;

@end
