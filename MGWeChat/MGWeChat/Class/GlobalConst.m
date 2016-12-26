//
//  GlobalConst.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "GlobalConst.h"

@implementation GlobalConst

#pragma mark - 常量
/** 全局间距10 */
CGFloat MGMargin = 10;

/** 导航栏高度64 */
CGFloat MGNavHeight = 64;

/** Tabbar高度48 */
CGFloat MGTabBarHeight = 48;

#pragma mark - 通知
/** 登录成功的通知 */
NSString *const MGLoginSuccessNotification = @"MGLoginSuccessNotification";


/** 点击朋友圈全文的通知 */

#pragma mark - 循环利用标识符
/** 联系人的cell的循环利用标识符 */
NSString *const KFriendCellIdentifier = @"KFriendCellIdentifier";

/** 朋友圈👬的cell的循环利用标识符 */
NSString *const KFriendCircleCellIdentifier = @"KFriendCircleCellIdentifier";




@end
