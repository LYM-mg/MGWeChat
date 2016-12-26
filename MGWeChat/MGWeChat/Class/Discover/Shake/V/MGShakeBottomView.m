//
//  MGShakeBottomView.m
//  MGWeChat
//
//  Created by ming on 16/8/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGShakeBottomView.h"
#import "MGBaseButton.h"

@interface MGShakeBottomView ()

@property (nonatomic, strong) MGBaseButton *peopleButton;
@property (nonatomic, strong) MGBaseButton *musicButton;
@property (nonatomic, strong) MGBaseButton *tvButton;

/** 选中按钮 */
@property (nonatomic, weak) MGBaseButton *selectedButton;
@end

@implementation MGShakeBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.peopleButton = [self setupBtnWithTitle:@"人" imageNormal:@"Shake_icon_people" imageSelected:@"Shake_icon_peopleHL" index:MGShakePeopleButton];
        self.musicButton = [self setupBtnWithTitle:@"歌曲" imageNormal:@"Shake_icon_music" imageSelected:@"Shake_icon_musicHL" index:MGShakeMusicButton];
        self.tvButton = [self setupBtnWithTitle:@"电视" imageNormal:@"Shake_icon_tv" imageSelected:@"Shake_icon_tvHL" index:MGShakeTvButton];
        
        [self buttonClick:self.peopleButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.width / self.subviews.count;
    CGFloat h = self.height;
    for (int i = 0; i < self.subviews.count; i++) {
        MGBaseButton *btn = self.subviews[i];
        btn.width = w;
        btn.height = h;
        btn.x = i * w;
        btn.y = 0;
    }
}

/** 快速创建按钮 */
- (MGBaseButton *)setupBtnWithTitle:(NSString *)title imageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected index:(MGShakeButtonType)index {
    MGBaseButton *btn = [[MGBaseButton alloc] init];
    btn.tag = index;
    [btn setImage:[UIImage imageNamed:imageNormal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitlePositionWithType:KButtonTitlePostionTypeBottom];
    [self addSubview:btn];
    return btn;
}

- (void)buttonClick:(MGBaseButton *)btn {
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;
    
    // 代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(shakeBottomView:withShakeButtonType:)]) {
        [self.delegate shakeBottomView:self withShakeButtonType:(MGShakeButtonType)self.selectedButton.tag];
    }
}

@end
