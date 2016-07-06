//
//  NSString+HBAdditions.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "NSString+HLAdditions.h"

@implementation NSString (TVAdditions)

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingLeadingAndTrailingWhitespaceAndNewlines {
    NSString* result = self;
    result = [result stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    result = [result stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return result;
}

- (NSString *)firstLettersWithWordNum:(int)num {
    NSMutableString *firstChars = [NSMutableString string];
    NSString *word;
    NSArray *words = [[self stringByTrimmingLeadingAndTrailingWhitespaceAndNewlines] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSInteger len = MIN(words.count, num);
    for (int i = 0; i < len; i++) {
        word = [words objectAtIndex:i];
        if (word.length > 0) {
            NSString *firstChar = [word substringToIndex:1];
            [firstChars appendString:[firstChar uppercaseString]];
        }
    }
    return [firstChars copy];
}

- (NSString *)trimStr {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (CGSize)sizeOfFont:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

- (CGSize)sizeWithFont:(UIFont*)font boundingRectToWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    
    //Contains both width & height ... Needed: The height
    return textRect.size;
}

- (CGSize)sizeWithFont:(UIFont*)font boundingRectToHeight:(CGFloat)height {
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    
    //Contains both width & height ... Needed: The height
    return textRect.size;
}

- (NSString *)md5 {
    const char * pointer = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(pointer, (CC_LONG)strlen(pointer), md5Buffer);
    
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [string appendFormat:@"%02x",md5Buffer[i]];
    
    return string;
}

+ (NSString *)nilToEmpty:(NSString *)str {
    if (!str) {
        return @"";
    }
    return str;
}

+ (NSString *)uniqueID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    
    NSString * uuidStr = (__bridge_transfer NSString*)CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    return uuidStr;
}

@end
