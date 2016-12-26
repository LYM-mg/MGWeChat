//
//  FriendCell.h
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendModel;
@interface FriendCell : UITableViewCell

/** 联系人模型 */
@property (nonatomic,strong) FriendModel *friendModel;
@end
