//
//  FriendCircleListViewModel.h
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendCircleListViewModel : NSObject

/// 朋友圈说说视图模型数组
@property (nonatomic, strong) NSMutableArray *statusList;

/** 加载数据 */
- (void)loadStatusWithCount:(NSInteger)count Completed:(void (^)(BOOL isSuccessed))completed;

/** 加载更多数据 */
- (void)loadMoreStatusWithCount:(NSInteger)count Completed:(void (^)(BOOL isSuccessed))completed;

/** 选中哪条说说 */
- (void)didClickLickButtonInCellWithIndexPath:(NSIndexPath *)indexPath success:(void (^)())success failure:(void (^)())failure;


@end
