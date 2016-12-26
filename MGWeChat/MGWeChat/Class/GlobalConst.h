//
//  GlobalConst.h
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalConst : NSObject

#pragma mark - 常量
/** 全局间距10 */
UIKIT_EXTERN  CGFloat MGMargin;

/** 导航栏高度64 */
UIKIT_EXTERN  CGFloat MGNavHeight;

/** Tabbar高度48 */
UIKIT_EXTERN  CGFloat MGTabBarHeight;

#pragma mark - 通知
/** 登录成功的通知 */
extern NSString *const MGLoginSuccessNotification;

/** 点击朋友圈全文的通知 */

#pragma mark - 循环利用标识符
/** 联系人的cell的循环利用标识符 */
UIKIT_EXTERN NSString *const KFriendCellIdentifier;

/** 朋友圈👬的cell的循环利用标识符 */
UIKIT_EXTERN NSString *const KFriendCircleCellIdentifier;



@end
