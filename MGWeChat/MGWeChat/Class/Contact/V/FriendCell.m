//
//  FriendCell.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCell.h"
#import "UIView+Extension.h"
#import "FriendModel.h"
#import "Masonry.h"

@interface FriendCell ()
/** icon头像 */
@property (nonatomic,weak) UIImageView *iconView;
/** 用户名称 */
@property (nonatomic,weak) UILabel *nameLabel;
@end

@implementation FriendCell

- (void)awakeFromNib {
     [self setUpUI];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 私有方法 创建UI
- (void)setUpUI {
    /** icon头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    _iconView = iconView;
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(MGMargin);
        make.top.mas_equalTo(self.contentView).mas_offset(0.5*MGMargin);
        make.width.height.mas_equalTo(45);
    }];
    
    /** 用户名称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).mas_offset(MGMargin);
        make.centerY.mas_equalTo(iconView.mas_centerY);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - 重写联系人模型 
- (void)setFriendModel:(FriendModel *)friendModel{
    _friendModel = friendModel;
    
    [self.iconView getImageWithURL:friendModel.photo placeholder:@"default_portrait"];
    self.nameLabel.text = friendModel.userName;
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
