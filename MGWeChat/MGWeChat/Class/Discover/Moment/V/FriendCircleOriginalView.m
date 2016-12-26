//
//  FriendCircleOriginalView.m
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCircleOriginalView.h"


// 根据具体font而定
CGFloat maxContentLabelHeight = 0;

@implementation FriendCircleOriginalView
{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    UIButton *_moreButton;
    
//    LZPhotoContainerView *_photoContainerView;
    
    BOOL _shouldOpenContentLabel;
    
    /// 文字的高度
    MASConstraint *_contentLabelHeightConstraint;
    /// 配图视图顶部约束
    MASConstraint *_topConstraint;
    /// 配图视图底部约束
    MASConstraint *_bottomConstraint;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _shouldOpenContentLabel = NO;
    
    // 头像
    _iconView = [UIImageView new];
    
    // 名字
    _nameLable = [UILabel labelWithTitle:@"" color:KColor(54, 71, 121) fontSize:14 alignment:NSTextAlignmentLeft];
    
    // 正文
    _contentLabel = [UILabel labelWithTitle:@"" color:KColor(54, 71, 121) fontSize:15 alignment:NSTextAlignmentLeft];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3 - 10;
    }
    
    // 更多
    _moreButton = [UIButton buttonWithTitle:@"全文" imageName:nil target:self action:@selector(moreButtonClick)];
    [_moreButton setTitleColor:KColor(92, 140, 193) forState:UIControlStateNormal];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 图片
    _photoContainerView = [[LZPhotoContainerView alloc] init];
    
    [self addSubview:_iconView];
    [self addSubview:_nameLable];
    [self addSubview:_contentLabel];
    [self addSubview:_moreButton];
    [self addSubview:_photoContainerView];
    
    CGFloat margin = 10;
    // 头像
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(self).with.offset(margin);
        make.top.equalTo(self.mas_top).with.offset(margin);
    }];
    
    // 名字
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView);
        make.left.equalTo(_iconView.mas_right).with.offset(margin);
        make.right.equalTo(self.mas_right).with.offset(-margin);
    }];
    
    // 内容
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLable);
        make.right.equalTo(self.mas_right).with.offset(-margin);
        make.top.equalTo(_nameLable.mas_bottom).with.offset(margin);
        _contentLabelHeightConstraint = make.height.equalTo(@20);
    }];
    
    // 更多(展开按钮)
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLable);
        make.top.equalTo(_contentLabel.mas_bottom).offset(0);
        make.height.equalTo(@30);
    }];
    
    // 图片
    [_photoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLable);
        _topConstraint = make.top.equalTo(_moreButton.mas_bottom).offset(margin);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        _bottomConstraint = make.bottom.equalTo(_photoContainerView).offset(margin);
    }];
}

- (void)setViewModel:(LZMomentsViewModel *)viewModel
{
    _viewModel = viewModel;
    
    _iconView.image = [UIImage imageNamed:viewModel.status.iconName];
    _nameLable.text = viewModel.status.name;
    
    _shouldOpenContentLabel = NO;
    
    
    [self setupContentViewWithContent:viewModel.msgContent];
    
    [self setupPictureViewWithURLs:viewModel.status.picNamesArray];
}

- (void)setupContentViewWithContent:(NSString *)content
{
    CGFloat margin = 10;
    BOOL hasContent = content.length > 0;
    _contentLabel.hidden = _moreButton.hidden = !hasContent;
    
    [_topConstraint uninstall];
    if (content.length) {  // 有文字
        _contentLabel.text = content;
        
        if (self.viewModel.shouldShowMoreButton) { // 如果文字高度超过60
            _moreButton.hidden = NO;
            
            [_contentLabelHeightConstraint uninstall];
            if (self.viewModel.isOpening) { // 如果需要展开
                [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
            } else {
                
                [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    _contentLabelHeightConstraint = make.height.equalTo(@(maxContentLabelHeight));
                }];
                [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
            }
            
            
            [_photoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                _topConstraint = make.top.equalTo(_moreButton.mas_bottom).offset(margin);
            }];
        }else {  // 没有超过60
            _moreButton.hidden = YES;
            [_photoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                _topConstraint = make.top.equalTo(_contentLabel.mas_bottom).offset(margin);
            }];
        }
        
    }else {  // 没有文字
        [_photoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            _topConstraint = make.top.equalTo(_nameLable.mas_bottom).offset(margin);
        }];
    }
}

- (void)setupPictureViewWithURLs:(NSArray *)urls
{
    CGFloat margin = 10;
    // 1. 设置配图视图数据
    _photoContainerView.urls = urls;
    
    // 2. 是否隐藏视图
    BOOL hasPicture = urls.count > 0;
    _photoContainerView.hidden = !hasPicture;
    
    // 3. 判断是否有配图
    [_bottomConstraint uninstall];
    if (hasPicture) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            _bottomConstraint = make.bottom.equalTo(_photoContainerView).offset(margin);
        }];
    } else {
        
        if (self.viewModel.shouldShowMoreButton) {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                _bottomConstraint = make.bottom.equalTo(_moreButton).offset(margin);
            }];
        }else {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                _bottomConstraint = make.bottom.equalTo(_contentLabel).offset(margin);
            }];
        }
        
    }
}

// 展开文字高度超过的按钮
- (void)moreButtonClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LZMoreButtonClickedNotification object:self userInfo:@{LZMoreButtonClickedNotificationKey : self.indexPath}];
    
    //    if (self.moreButtonClickedBlock) {
    //        self.moreButtonClickedBlock(self.indexPath);
    //    }
}
@end
