//
//  MineHeaderView.h
//  MGWeChat
//
//  Created by ming on 16/8/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *userDescripLabel;

/**
 *  快速创建headerView
 */
+ (instancetype)mineHeaderView;

- (void)mineHeaderViewWithHander:(void(^)())headerHander;
@end
