//
//  MGPictureModel.m
//  MGWeChat
//
//  Created by ming on 16/8/20.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGPictureModel.h"

@implementation MGPictureModel

- (void)getThumbnail_pic:(NSString *)thumbnail_pic{
    _thumbnail_pic = thumbnail_pic;
    
    self.thumbnail_URL = [NSURL URLWithString:thumbnail_pic];
}

@end
