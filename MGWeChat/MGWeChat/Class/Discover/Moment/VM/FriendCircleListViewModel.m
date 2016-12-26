//
//  FriendCircleListViewModel.m
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCircleListViewModel.h"
#import "FriendCircleModel.h"
#import "FriendCircleViewModel.h"

@interface FriendCircleListViewModel ()

@end

@implementation FriendCircleListViewModel
#pragma mark - 懒加载属性
- (NSMutableArray *)statusList {
    if (_statusList == nil) {
        _statusList = [[NSMutableArray alloc] init];
    }
    return _statusList;
}


/** 加载数据 */
- (void)loadStatusWithCount:(NSInteger)count Completed:(void (^)(BOOL isSuccessed))completed
{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"马云",
                            @"马化腾",
                            @"乔布斯",
                            @"雷军",
                            @"柳传志",
                            @"王江民",
                            @"丁磊",
                            @"鲍岳桥",
                            @"李彦宏",
                            @"张朝阳",
                            ];
    
    NSArray *textArray = @[@"1.此版本是有史以来Github上最牛逼的高仿微信项目没有之一,采用MVVM和MVC两种开发架构思想,纯代码开发.",
                           @"https://github.com/nacker",
                           @"2.今天全程神勇的日本队则抵挡住了美国队和加拿大队的攻击，以37秒60获得亚军，打破亚洲纪录。美国队以37秒62获得第三，但被判犯规被取消成绩。中国队第四棒开始时还在第四位置，但最后张培萌被加拿大的德格拉塞超越，最终以37秒90获得第四，加拿大队以37秒64获得第三.",
                           @"3.北京时间8月20日，里约奥运会男子篮球半决赛美国西班牙再次狭路相逢，最终西班牙以76比82不敌美国，加索尔最终拿到23分9篮板，再次倒在了美国队的脚下，止步决赛。",
                           @"4.北京时间8月20日，据美媒体报道，得知易建联即将加盟洛杉矶湖人队之后，前湖人队和中国男篮的主帅，外号“银狐”的德尔-哈里斯给予昔日弟子阿联很高的评价，并且很看好他的第二次NBA之旅。..."
                           ];
    
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"帮二哥点STAR。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真，再回首恍然如梦，再回首我心依旧，只有那不变的长路伴着我",
                               @"帮二哥点STAR",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你"];
    
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
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        FriendCircleModel *model = [[FriendCircleModel alloc] init];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        //        model.msgContent = @"";
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(10);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        
        // 点赞
        int likeItemsRandom = arc4random_uniform(10);
        NSMutableArray *tempLikeItems = [NSMutableArray new];
        for (int i = 0; i < likeItemsRandom; i++) {
            FriendCircleCellLikeItemModel *likeModel = [[FriendCircleCellLikeItemModel alloc] init];
            likeModel.userId = @"666";
            likeModel.userName = namesArray[i];
            [tempLikeItems addObject:likeModel];
        }
        model.likeItemsArray = [tempLikeItems copy];
        
        // 回复
        int commentRandom = arc4random_uniform(6);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            FriendCircleCellCommentItemModel *commentItemModel = [FriendCircleCellCommentItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.firstUserName = namesArray[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentItemsArray = [tempComments copy];
        
        FriendCircleViewModel *momentsViewModel = [FriendCircleViewModel viewModelWithStatus:model];
        [arrayM addObject:momentsViewModel];
        
        //        KLog(@"%@",arrayM);
    }
    
    [self.statusList addObjectsFromArray:arrayM];
    
    completed(YES);
}


/** 加载更多数据 */
- (void)loadMoreStatusWithCount:(NSInteger)count Completed:(void (^)(BOOL isSuccessed))completed{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"马云",
                            @"马化腾",
                            @"乔布斯",
                            @"雷军",
                            @"柳传志",
                            @"王江民",
                            @"丁磊",
                            @"鲍岳桥",
                            @"李彦宏",
                            @"张朝阳",
                            ];
    
    NSArray *textArray = @[@"1.此版本是有史以来Github上最牛逼的高仿微信项目没有之一,采用MVVM和MVC两种开发架构思想,纯代码开发.",
                           @"https://github.com/LYM-mg.com",
                           @"2.如果各位下客能帮我点STAR,半个月STAR500+,我会陆陆续续发布待实现功能其实已经做完,一个月STAR1000+我会把微信主要功能全部实现发布出来,两个月STAR2000+我会发布纯Swift版,纯Swift版采用纯代码开发已经做的差不多了.就看大伙的手能不能点STAR了.希望大家不要下完就跑了.作为作者的二哥会很心痛的.",
                           @"2.如果各位下客能帮我点STAR,半个月STAR500+,我会陆陆续续发布待实现功能其实已经做完,一个月STAR1000+我会把微信主要功能全部实现发布出来,两个月STAR2000+我会发布纯Swift版,纯Swift版采用纯代码开发已经做的差不多了.就看大伙的手能不能点STAR了.希望大家不要下完就跑了.会很心痛的.",
                           @"3.我之前接触过很多项目,就有一个项目中的朋友圈整个控制器4千行,尼玛4千行了这项目怎么迭代,现在300行解决了朋友圈的问题,还在优化中..."
                           ];
    
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"帮二哥点STAR。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真，再回首恍然如梦，再回首我心依旧，只有那不变的长路伴着我",
                               @"帮忙点STAR",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你"];
    
    NSArray *picImageNamesArray = @[ @"http://h.hiphotos.baidu.com/image/w%3D2048/sign=e7e477224334970a4773172fa1f2d0c8/50da81cb39dbb6fd1d515a2b0b24ab18972b37b0.jpg",
                                     @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=d0f37d60fa1986184147e8847ed52f73/a1ec08fa513d26973a06f05c57fbb2fb4216d8de.jpg",
                                     @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=a0e078ee552c11dfded1b823571f63d0/eaf81a4c510fd9f91513ea64272dd42a2834a4b3.jpg",
                                     @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=091af36f9a22720e7bcee5fa4ff30b46/5243fbf2b2119313b093a9bd67380cd790238dee.jpg",
                                     @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=d8a403cd1c178a82ce3c78a0c23b728d/63d9f2d3572c11dff36e4622612762d0f703c270.jpg",
                                     @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=93cf6adecc1b9d168ac79d61c7e6b48f/a71ea8d3fd1f41347203fd7f271f95cad1c85eff.jpg",
                                     @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=aa593826bc096b6381195950380b8744/0dd7912397dda1440d2b93bbb0b7d0a20cf4869d.jpg",
                                     @"http://g.hiphotos.baidu.com/image/w%3D2048/sign=6f0576085e6034a829e2bf81ff2b4854/71cf3bc79f3df8dc27207098cf11728b4710289e.jpg",
                                     @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=a0e078ee552c11dfded1b823571f63d0/eaf81a4c510fd9f91513ea64272dd42a2834a4b3.jpg"
                                     ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        FriendCircleModel *model = [[FriendCircleModel alloc] init];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        //        model.msgContent = @"";
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(10);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        // 点赞
        int likeItemsRandom = arc4random_uniform(10);
        NSMutableArray *tempLikeItems = [NSMutableArray new];
        for (int i = 0; i < likeItemsRandom; i++) {
            FriendCircleCellLikeItemModel *likeModel = [[FriendCircleCellLikeItemModel alloc] init];
            likeModel.userId = @"666";
            likeModel.userName = namesArray[i];
            [tempLikeItems addObject:likeModel];
        }
        model.likeItemsArray = [tempLikeItems copy];
        
        // 回复
        int commentRandom = arc4random_uniform(6);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            FriendCircleCellCommentItemModel *commentItemModel = [FriendCircleCellCommentItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.firstUserName = namesArray[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentItemsArray = [tempComments copy];
        
        
        FriendCircleViewModel *momentsViewModel = [FriendCircleViewModel viewModelWithStatus:model];
        [arrayM addObject:momentsViewModel];
        
        //        KLog(@"%@",arrayM);
    }
    
    [self.statusList addObjectsFromArray:arrayM];
    
    //    KLog(@"%@",self.statusList);
    
    completed(YES);
}


/** 选中哪条说说 */
- (void)didClickLickButtonInCellWithIndexPath:(NSIndexPath *)indexPath success:(void (^)())success failure:(void (^)())failure{
    FriendCircleViewModel *model = self.statusList[indexPath.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.status.likeItemsArray];
//    NSString *name = [[EMClient sharedClient] currentUsername];
    NSString *name = @"明明";
    if (!model.status.isLiked) {
        FriendCircleCellLikeItemModel *likeModel = [FriendCircleCellLikeItemModel new];
        likeModel.userName = name;
        likeModel.userId = name;
        [temp addObject:likeModel];
        model.status.liked = YES;
    } else {
        FriendCircleCellLikeItemModel *tempLikeModel = nil;
        for (FriendCircleCellLikeItemModel *likeModel in model.status.likeItemsArray) {
            if ([likeModel.userId isEqualToString:name]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        [temp removeObject:tempLikeModel];
        model.status.liked = NO;
    }
    model.status.likeItemsArray = [temp copy];
    
    if (success) {
        success();
    }
}


@end
