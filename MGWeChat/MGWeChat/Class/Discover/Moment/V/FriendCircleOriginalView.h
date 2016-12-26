//
//  FriendCircleOriginalView.h
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FriendCircleViewModel;

@interface FriendCircleOriginalView : UIView

@property (nonatomic, strong) FriendCircleViewModel *viewModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@end
