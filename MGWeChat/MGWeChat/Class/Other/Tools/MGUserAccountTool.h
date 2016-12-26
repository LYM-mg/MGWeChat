//
//  MGUserAccountTool.h
//  MGWeChat
//
//  Created by ming on 16/8/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGUserAccountTool : NSObject

/** 真正的过期时间 */
@property (nonatomic,strong) NSNumber *experise_in;
/** 真正的过期时间 */
@property (nonatomic,strong) NSDate *experise_date;
/** 账号 */
@property (nonatomic,copy) NSString *accountName;
/** 密码 */
@property (nonatomic,copy) NSString *password;

/**
 *  快速创建
 */
+ (instancetype)shareInstance;
/**
 *  保存登录信息
 *
 *  @return 是否
 */
- (BOOL)saveAccount;

/**
 *  是否登录
 *
 *  @return 是否登录
 */
- (BOOL)isUserLogin;

@end
