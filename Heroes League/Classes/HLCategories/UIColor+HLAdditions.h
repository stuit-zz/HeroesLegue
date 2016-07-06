//
//  UIColor+HLAdditions.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/5/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HLAdditions)

+ (UIColor *)colorWithHex:(int)hex;
+ (UIColor *)colorWithHex:(int)hex alpha:(float)alpha;
+ (UIColor *)randomColor;

@end
