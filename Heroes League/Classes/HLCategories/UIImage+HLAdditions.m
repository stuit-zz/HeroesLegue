//
//  UIImage+HLAdditions.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/6/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "UIImage+HLAdditions.h"

@implementation UIImage (HLAdditions)

+ (UIImage *)randomColoredImageWithText:(NSString *)text size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor *color = [UIColor randomColor];
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    CGRect area = CGRectMake(0, 0, size.width, size.height);
    CGContextFillRect(ctx, area);
    
    UIFont *font = [UIFont systemFontOfSize:size.height / 2];
    CGSize bnds = [text sizeWithFont:font boundingRectToHeight:size.height];
    CGPoint pnt = CGPointMake((size.width - bnds.width) / 2, (size.height - bnds.height) / 2);
    area = CGRectMake(pnt.x, pnt.y, bnds.width, bnds.height);
    [text drawInRect:area withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
