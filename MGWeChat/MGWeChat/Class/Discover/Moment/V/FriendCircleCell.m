//
//  FriendCircleCell.m
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCircleCell.h"
#import "FriendCircleModel.h"
//#import "FriendCircleOriginalView.h"
#import "LZOperationMenu.h"
#import "FriendCircleContainPhotoView.h"

@interface FriendCircleCell ()
{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    UIButton *_moreButton;
    
//    FriendCircleContainPhotoView *_photoContainerView;
    
    BOOL _shouldOpenContentLabel;
    
    // 时间
    UILabel *_timeLabel;
    // 回复  叫出评论点赞
    UIButton *_operationButton;
    
    LZOperationMenu *_operationMenu;
}
@end



@implementation FriendCircleCell

// 根据具体font而定
CGFloat maxContentLabelHeight = 0;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    // 原创朋友圈
    // 头像 占位图片 @"avatar_default_big"
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     @"0.jpg",
                                     @"2.jpg",
                                     @"3.jpg",
                                     ];
    int iconImageRandomIndex = arc4random_uniform(5);
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(MGMargin, MGMargin, 40, 40)];
    _iconView.image = [UIImage imageNamed:iconImageNamesArray[iconImageRandomIndex]];
    
    // 名字
    _nameLable = [UILabel labelWithTitle:@"MG明明就是你" color:MGRGBColor(54, 71, 121) fontSize:14 alignment:NSTextAlignmentLeft];
    _nameLable.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+MGMargin,MGMargin, MGScreenW - _iconView.width - MGMargin, 40);
    
    // 正文
    NSArray *titleArr = [NSArray arrayWithObjects:
                         @"0.北京时间8月20日，据美媒体报道，得知易建联即将加盟洛杉矶湖人队之后，前湖人队和中国男篮的主帅，外号“银狐”的德尔-哈里斯给予昔日弟子阿联很高的评价，并且很看好他的第二次NBA之旅。",
                         @"1.此版本是有史以来Github上最牛逼的高仿微信项目没有之一,采用MVVM和MVC两种开发架构思想,纯代码开发.",
                         @"https://github.com/nacker",
                         @"2.今天全程神勇的日本队则抵挡住了美国队和加拿大队的攻击，以37秒60获得亚军，打破亚洲纪录。美国队以37秒62获得第三，但被判犯规被取消成绩。中国队第四棒开始时还在第四位置，但最后张培萌被加拿大的德格拉塞超越，最终以37秒90获得第四，加拿大队以37秒64获得第三.",
                         @"3.北京时间8月20日，里约奥运会男子篮球半决赛美国西班牙再次狭路相逢，最终西班牙以76比82不敌美国，加索尔最终拿到23分9篮板，再次倒在了美国队的脚下，止步决赛。",
                         @"4.北京时间8月20日，据美媒体报道，得知易建联即将加盟洛杉矶湖人队之后，前湖人队和中国男篮的主帅，外号“银狐”的德尔-哈里斯给予昔日弟子阿联很高的评价，并且很看好他的第二次NBA之旅。...",nil];
    int contentRandomIndex = arc4random_uniform(5);
    _contentLabel = [UILabel labelWithTitle:titleArr[contentRandomIndex] color:MGRGBColor(54, 71, 121) fontSize:15 alignment:NSTextAlignmentLeft];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.numberOfLines = 0;
    _contentLabel.x = CGRectGetMinX(_nameLable.frame);
    _contentLabel.y = CGRectGetMaxY(_iconView.frame)+MGMargin;
    _contentLabel.width = MGScreenW - _iconView.width - 3*MGMargin;
    [_contentLabel sizeToFit];

    // 图片
    NSArray *picImageNamesArray = @[
                                    @"http://h.hiphotos.baidu.com/image/w%3D2048/sign=e7e477224334970a4773172fa1f2d0c8/50da81cb39dbb6fd1d515a2b0b24ab18972b37b0.jpg",
                                    @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=d0f37d60fa1986184147e8847ed52f73/a1ec08fa513d26973a06f05c57fbb2fb4216d8de.jpg",
                                    @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=a0e078ee552c11dfded1b823571f63d0/eaf81a4c510fd9f91513ea64272dd42a2834a4b3.jpg",
                                    @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=091af36f9a22720e7bcee5fa4ff30b46/5243fbf2b2119313b093a9bd67380cd790238dee.jpg",
                                    @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=d8a403cd1c178a82ce3c78a0c23b728d/63d9f2d3572c11dff36e4622612762d0f703c270.jpg",
                                    @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=93cf6adecc1b9d168ac79d61c7e6b48f/a71ea8d3fd1f41347203fd7f271f95cad1c85eff.jpg",
                                    @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=aa593826bc096b6381195950380b8744/0dd7912397dda1440d2b93bbb0b7d0a20cf4869d.jpg",
                                    @"http://g.hiphotos.baidu.com/image/w%3D2048/sign=6f0576085e6034a829e2bf81ff2b4854/71cf3bc79f3df8dc27207098cf11728b4710289e.jpg",
                                    @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=a0e078ee552c11dfded1b823571f63d0/eaf81a4c510fd9f91513ea64272dd42a2834a4b3.jpg"
                                    ];
    int picImageRandomIndex = arc4random_uniform(9);
    UIImageView *_photoContainerView = [UIImageView new];
    _photoContainerView.frame = CGRectMake(CGRectGetMinX(_contentLabel.frame),CGRectGetMaxY(_contentLabel.frame)+MGMargin, MGScreenW - CGRectGetMinX(_contentLabel.frame) - MGMargin, 140);
    _photoContainerView.contentMode = UIViewContentModeScaleToFill;
    [_photoContainerView getImageWithURL:picImageNamesArray[picImageRandomIndex] placeholder:@"AlbumHeaderBackgrounImage.jpg"];
    
    
    // 时间
     _timeLabel =  [UILabel labelWithTitle:@"22:25" color:[UIColor lightGrayColor] fontSize:13 alignment:NSTextAlignmentLeft];
    _timeLabel.frame = CGRectMake(CGRectGetMinX(_contentLabel.frame),CGRectGetMaxY(_photoContainerView.frame)+MGMargin, 80, 30);
    
     // 点赞+回复按钮
    _operationButton = [UIButton new];
    [_operationButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _operationButton.frame = CGRectMake(MGScreenW-MGMargin-25,CGRectGetMaxY(_photoContainerView.frame)+MGMargin, 25, 25);
    
    [self.contentView  addSubview:_iconView];
    [self.contentView  addSubview:_nameLable];
    [self.contentView  addSubview:_contentLabel];
    [self.contentView  addSubview:_moreButton];
    [self.contentView  addSubview:_photoContainerView];
    [self.contentView  addSubview:_timeLabel];
    [self.contentView  addSubview:_operationButton];
   
//     self.frame = CGRectMake(0,0, MGScreenW, CGRectGetMaxY(_timeLabel.frame) + MGMargin);
    
//    _operationMenu = [[LZOperationMenu alloc] init];
//    __weak typeof(self) weakSelf = self;
//    [_operationMenu setLikeButtonClickedOperation:^{
//        if ([weakSelf.delegate respondsToSelector:@selector(didClickLikeButtonInCell:)]) {
//            [weakSelf.delegate didClickLikeButtonInCell:weakSelf];
//        }
//    }];
//    [_operationMenu setCommentButtonClickedOperation:^{
//        if ([weakSelf.delegate respondsToSelector:@selector(didClickcCommentButtonInCell:)]) {
//            [weakSelf.delegate didClickcCommentButtonInCell:weakSelf];
//        }
//    }];
//    _operationMenu.frame = CGRectMake(MGScreenW-MGMargin-25,CGRectGetMinY(_operationButton.frame), 115, 25);
//    [self.contentView addSubview:_operationMenu];
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
////    self.contentView.frame = CGRectMake(0,0, MGScreenW, CGRectGetMaxY(_timeLabel.frame) + MGMargin);
//}

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//}

- (void)setViewModel:(FriendCircleViewModel *)viewModel
{
    _viewModel = viewModel;
//    _originalView.viewModel = viewModel;
//    _originalView.indexPath = self.indexPath;
//    _timeLabel.text = viewModel.time;
    
    
//    [_dividerTopConstraint uninstall];
//    if (!viewModel.status.commentItemsArray.count && !viewModel.status.likeItemsArray.count) {
//        _commentBgView.hidden = YES;
//        [_divider mas_makeConstraints:^(MASConstraintMaker *make) {
//            _dividerTopConstraint = make.top.equalTo(_timeLabel.mas_bottom).offset(MGMargin);
//        }];
//    }else {
//        _commentBgView.hidden = NO;
//        _commentBgView.viewModel = viewModel;
//        [_divider mas_makeConstraints:^(MASConstraintMaker *make) {
//            _dividerTopConstraint = make.top.equalTo(_commentBgView.mas_bottom).offset(MGMargin);
//        }];
//    }
}

- (void)operationButtonClicked:(UIButton *)btn {
//    _operationMenu.show = !_operationMenu.isShowing;
//    
//    if (btn != _operationButton && _operationMenu.isShowing) {
//        _operationMenu.show = NO;
//    }
}

// 更多按钮的点击
- (void)moreButtonClick:(UIButton *)btn{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    UIButton *btn = (UIButton *)[touch view];
    [self operationButtonClicked:btn];
    
//    if (_operationMenu.isShowing) {
//        _operationMenu.show = NO;
//    }
}

@end
