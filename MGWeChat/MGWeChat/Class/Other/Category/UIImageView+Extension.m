//
//  UIImageView+Extension.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)


//    [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:placeholder]];
- (void)getImageWithURL:(NSString *)url placeholder:(NSString *)placeholder
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholder]];
}

@end
