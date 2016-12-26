//
//  FriendCircleModel.h
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FriendCircleCellLikeItemModel, FriendCircleCellCommentItemModel;

#pragma markr - FriendCircleModel
@interface FriendCircleModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSArray *picNamesArray;
@property (nonatomic, copy) NSString *time;

/** <#注释#> */
@property (nonatomic,copy) NSString *thumbnail_pic;

/** <#注释#> */
@property (nonatomic,strong) NSURL *thumbnail_URL;

@property (nonatomic, strong) NSArray<FriendCircleCellLikeItemModel *> *likeItemsArray;
@property (nonatomic, strong) NSArray<FriendCircleCellCommentItemModel *> *commentItemsArray;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

// 是否点赞
@property (nonatomic, assign, getter = isLiked) BOOL liked;


// 点赞文字
@property (nonatomic, copy) NSMutableAttributedString *likesStr;

@end


#pragma markr - FriendCircleCellLikeItemModel
@interface FriendCircleCellLikeItemModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@end

#pragma markr - FriendCircleCellCommentItemModel
@interface FriendCircleCellCommentItemModel : NSObject

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@end
