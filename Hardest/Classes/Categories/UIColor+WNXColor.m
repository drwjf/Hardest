//
//  UIColor+WNXColor.m
//  Hardest
//
//  Created by MacBook on 16/4/7.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "UIColor+WNXColor.h"

@implementation UIColor (WNXColor)

+ (instancetype)colorWithR:(int)red g:(int)green b:(int)blue {
    UIColor *color = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
    return color;
}

@end