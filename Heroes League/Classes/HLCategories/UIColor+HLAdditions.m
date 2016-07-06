//
//  UIColor+HLAdditions.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/5/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "UIColor+HLAdditions.h"

@implementation UIColor (HLAdditions)

+ (UIColor *)colorWithHex:(int)hex {
    return [UIColor colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(int)hex alpha:(float)alpha {
    return [UIColor colorWithRed:((float) ((hex & 0xFF0000) >> 16))/255.0 green:((float) ((hex & 0xFF00) >> 8))/255.0 blue:((float) (hex & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
