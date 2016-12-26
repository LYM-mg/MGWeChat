//
//  FriendCircleContainPhotoView.h
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FriendCircleViewModel;
@interface FriendCircleContainPhotoView : UICollectionView

/** 模型 */
@property (nonatomic,strong) FriendCircleViewModel *friendCircleViewModel;

/** <#注释#> */
@property (nonatomic,strong) NSArray *pictureArr;

@end


#pragma mark - MGPictureCell
@interface MGPictureCell : UICollectionViewCell

/** 配图URL */
@property (nonatomic,copy) NSURL *imageURL;

/** 图片数组 */
@property (nonatomic,strong) UIImageView *peituView;

/** 模型 */
@property (nonatomic,strong) FriendCircleViewModel *friendCircleViewModel;

@end
