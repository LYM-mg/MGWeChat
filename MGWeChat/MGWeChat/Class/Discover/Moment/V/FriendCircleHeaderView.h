//
//  FriendCircleHeaderView.h
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCircleHeaderView : UIView

/** 头像 */
//@property (nonatomic,weak) UIImageView *iconView;

/** 点击头像回调 */
@property (nonatomic,copy) void (^iconButtonClickHander)();


- (void)updateHeight:(CGFloat)height;

@end
