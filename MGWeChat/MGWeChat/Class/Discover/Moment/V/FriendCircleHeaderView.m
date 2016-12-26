//
//  FriendCircleHeaderView.m
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCircleHeaderView.h"

@interface FriendCircleHeaderView ()
{
    UIImageView *_backgroundImageView; /** 背景图片 */
    UIImageView *_iconView; /** 头像 */
    UILabel *_nameLabel; /** 昵称 */
    UIView *_backView;
}
@end

@implementation FriendCircleHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIView *backView = [[UIView alloc] init];
    backView.clipsToBounds = YES;
    
    _backgroundImageView = [UIImageView new];
    _backgroundImageView.image = [UIImage imageNamed:@"AlbumHeaderBackgrounImage.jpg"];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    typeof(self) __weak weakSelf = self;
    _iconView = [UIImageView new];
    _iconView.userInteractionEnabled = YES;
    _iconView.image = [UIImage imageNamed:@"me.jpg"];
    _iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconView.layer.borderWidth = 3;
    [_iconView setTapActionWithBlock:^{
        if (weakSelf.iconButtonClickHander)
        weakSelf.iconButtonClickHander();
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"MG明明就是你";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [self addSubview:backView];
    [backView addSubview:_backgroundImageView];
    [self addSubview:_iconView];
    [self addSubview:_nameLabel];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).insets(UIEdgeInsetsMake(-20, 0, 40, 0));
        make.edges.equalTo(backView).insets(UIEdgeInsetsMake(-20, 0, 40, 0));
    }];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_bottom).offset(-15);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_iconView.mas_left).offset(-15);
        make.centerY.equalTo(_iconView).offset(-5);
    }];
}

- (void)updateHeight:(CGFloat)height {
    self.height = height;
    
    if (self.height == 200) {
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }else{
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
