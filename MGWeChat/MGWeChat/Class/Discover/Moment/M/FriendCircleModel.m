//
//  FriendCircleModel.m
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCircleModel.h"

#pragma markr - FriendCircleModel
@implementation FriendCircleModel

- (NSString *)time {
    return @"1分钟之前";
}

- (NSMutableAttributedString *)likesStr {
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"Like"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    
    for (int i = 0; i < self.likeItemsArray.count; i++) {
        FriendCircleCellLikeItemModel *model = self.likeItemsArray[i];
        if (i > 0) {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        [attributedText appendAttributedString:[self generateAttributedStringWithLikeItemModel:model]];
        ;
    }
    
    return attributedText;
}

- (NSMutableAttributedString *)generateAttributedStringWithLikeItemModel:(FriendCircleCellLikeItemModel *)model
{
    NSString *text = model.userName;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor blueColor];
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.userId} range:[text rangeOfString:model.userName]];
    
    return attString;
}

@end


#pragma markr - FriendCircleCellLikeItemModel
@implementation FriendCircleCellLikeItemModel

@end

#pragma markr - FriendCircleCellCommentItemModel
@implementation FriendCircleCellCommentItemModel


@end