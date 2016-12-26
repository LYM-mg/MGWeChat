//
//  FriendCircleViewModel.m
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCircleViewModel.h"

extern CGFloat maxContentLabelHeight;

@implementation FriendCircleViewModel
{
    CGFloat _lastContentWidth;
}

+ (instancetype)viewModelWithStatus:(FriendCircleModel *)status {
    FriendCircleViewModel *obj = [[self alloc] init];
    
    obj.status = status;
    
    return obj;
}

- (NSString *)description {
    return self.status.description;
}

- (NSString *)name
{
    return self.status.name;
}

- (NSString *)iconName
{
    return self.status.iconName;
}

- (NSString *)time
{
    return self.status.time;
}

- (NSArray *)picNamesArray{
    return  self.status.picNamesArray;
}

- (NSString *)msgContent
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGSize textSize = [self.status.msgContent sizeWithFont:[UIFont systemFontOfSize:15] maxW:contentW];
        if (textSize.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return self.status.msgContent;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

@end
