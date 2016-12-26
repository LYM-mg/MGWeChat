//
//  UILabel+Extension.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "UILabel+Extension.h"
#import "MLLinkLabel.h"

@implementation UILabel (Extension)

+ (UILabel *)labelWithText:(NSString *)text sizeFont:(UIFont *)sizeFont textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = sizeFont;
    label.textColor = textColor;
    return label;
}

+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    //    label.preferredMaxLayoutWidth =
    [label sizeToFit];
    return label;
}


static MLLinkLabel * kProtypeLabel() {
    static MLLinkLabel *_protypeLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _protypeLabel = [MLLinkLabel new];
        _protypeLabel.font = [UIFont systemFontOfSize:14.0f];
        _protypeLabel.numberOfLines = 0;
        //        _protypeLabel.textInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _protypeLabel.lineHeightMultiple = 1.1f;
        UIColor *highLightColor = [UIColor blueColor];
        _protypeLabel.linkTextAttributes = @{NSForegroundColorAttributeName : highLightColor};
        _protypeLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor],NSBackgroundColorAttributeName:kDefaultActiveLinkBackgroundColorForMLLinkLabel};
    });
    return _protypeLabel;
}

+ (CGFloat)heightForExpressionText:(NSAttributedString *)expressionText width:(CGFloat)width
{
    MLLinkLabel *label = kProtypeLabel();
    label.attributedText = expressionText;
    return [label preferredSizeWithMaxWidth:width].height;
}

@end
