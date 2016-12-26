//
//  FriendCircleCell.h
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendCircleViewModel,FriendCircleCell,FriendCircleOriginalView;

@protocol FriendCircleCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(FriendCircleCell *)cell;
- (void)didClickcCommentButtonInCell:(FriendCircleCell *)cell;

@end

@interface FriendCircleCell : UITableViewCell

@property (nonatomic, weak) id<FriendCircleCellDelegate> delegate;

// 原创
@property (nonatomic, strong) FriendCircleOriginalView *originalView;

@property (nonatomic, strong) FriendCircleViewModel *viewModel;

@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic, copy) void (^operationButtonClick)(NSIndexPath *indexPath);

@end
