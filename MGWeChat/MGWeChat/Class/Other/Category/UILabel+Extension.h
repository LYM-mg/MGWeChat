//
//  UILabel+Extension.h
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+ (UILabel *)labelWithText:(NSString *)text sizeFont:(UIFont *)sizeFont textColor:(UIColor *)textColor;

+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;

+ (CGFloat)heightForExpressionText:(NSAttributedString *)expressionText width:(CGFloat)width;
@end
