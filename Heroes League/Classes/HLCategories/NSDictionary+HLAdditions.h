//
//  NSDictionary+HLAdditions.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HLAdditions)

- (id)objForKey:(id)aKey;
- (id)objForKey:(id)aKey withDefault:(id)value;

@end
