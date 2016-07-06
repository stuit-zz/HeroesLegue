//
//  NSObject+HLAdditions.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "NSObject+HLAdditions.h"

@implementation NSObject (HLAdditions)

- (id)nullToNil {
    if (self == (id)[NSNull null]) {
        return nil;
    }
    return self;
}

- (id)defaultToNil:(id)value {
    if (self == (id)[NSNull null]) {
        return value;
    }
    return self;
}

@end
