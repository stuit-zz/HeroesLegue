//
//  NSDictionary+HLAdditions.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "NSDictionary+HLAdditions.h"

@implementation NSDictionary (HLAdditions)

- (id)objForKey:(id)aKey {
    return [[self objectForKey:aKey] nullToNil];
}

- (id)objForKey:(id)aKey withDefault:(id)value {
    return [[self objectForKey:aKey] defaultToNil:value];
}

@end
