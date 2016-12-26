//
//  MineHeaderView.m
//  MGWeChat
//
//  Created by ming on 16/8/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()
/** 回调 */
@property (nonatomic,copy) void (^headerHander)();
@end

@implementation MineHeaderView

/**
 *  快速创建headerView
 */
+ (instancetype)mineHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MineHeaderView class]) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    UITapGestureRecognizer *userIconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconTap:)];
    self.userIconImageView.userInteractionEnabled = YES;
    [self.userIconImageView addGestureRecognizer:userIconTap];
}

#pragma mark - Action
- (IBAction)mineHeaderViewClick {
    if (self.headerHander) {
        self.headerHander();
    }
}

- (void)mineHeaderViewWithHander:(void (^)())headerHander{
    self.headerHander = headerHander;
}

- (void)userIconTap:(UITapGestureRecognizer *)userIconTap {
    MGPS(@"点击了头像  修改");
}

@end
