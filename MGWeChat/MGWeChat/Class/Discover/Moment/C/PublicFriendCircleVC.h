//
//  PublicFriendCircleVC.h
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "WXBasicController.h"

@interface PublicFriendCircleVC : WXBasicController

- (instancetype)initWithImages:(NSArray *)images;

- (void)setSendButtonClickedBlock:(void(^)(NSString *text,NSArray *images))sendButtonClickedHander;
@end
