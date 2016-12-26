//
//  MGShakeBottomView.h
//  MGWeChat
//
//  Created by ming on 16/8/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MGShakePeopleButton,  // 人
    MGShakeMusicButton,  // 音乐
    MGShakeTvButton  // 电视
} MGShakeButtonType;


@class MGShakeBottomView,MGBaseButton;

@protocol MGShakeBottomViewDelegate <NSObject>

- (void)shakeBottomView:(MGShakeBottomView *)shakeBottomView withShakeButtonType:(MGShakeButtonType)type;
@end


@interface MGShakeBottomView : UIView

/** 代理 */
@property (nonatomic,weak) id<MGShakeBottomViewDelegate> delegate;

@end
