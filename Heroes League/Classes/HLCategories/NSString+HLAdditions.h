//
//  NSString+HBAdditions.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface NSString (TVAdditions)

- (NSString*)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet*)characterSet;
- (NSString*)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet*)characterSet;
- (NSString*)stringByTrimmingLeadingAndTrailingWhitespaceAndNewlines;
- (NSString*)firstLettersWithWordNum:(int)num;
- (NSString*)trimStr;
- (CGSize)sizeOfFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont*)font boundingRectToWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeWithFont:(UIFont*)font boundingRectToHeight:(CGFloat)height;
- (NSString*)md5;
+ (NSString*)nilToEmpty:(NSString *)str;
+ (NSString*)uniqueID;


@end
