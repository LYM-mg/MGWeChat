//
//  FriendModel.h
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject
/** 头像字符串 */
@property(nonatomic,copy)NSString *photo;
/** 用户名称 */
@property(nonatomic,copy)NSString *userName;
/** 用户ID*/
@property(nonatomic,copy)NSString *userId;
/** 没有头像 */
@property(nonatomic,copy)NSString *phoneNO;

/** 字典转模型 */
+ (instancetype)friendModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
