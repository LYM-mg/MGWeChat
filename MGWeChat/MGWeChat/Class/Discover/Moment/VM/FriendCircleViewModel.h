//
//  FriendCircleViewModel.h
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendCircleModel.h"

@interface FriendCircleViewModel : NSObject

/// 朋友圈说说模型
@property (nonatomic, strong) FriendCircleModel *status;

/// 用户头像
@property (nonatomic, readonly) NSString *iconName;

/// 用户名字
@property (nonatomic, readonly) NSString *name;

/// 内容
@property (nonatomic, copy) NSString *msgContent;

/// 配图
@property (nonatomic, strong) NSArray *picNamesArray;

/// 配图
@property (nonatomic, readonly) NSString *time;

+ (instancetype)viewModelWithStatus:(FriendCircleModel *)status;

/// 是否展开
@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;


@end
