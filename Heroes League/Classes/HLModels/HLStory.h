//
//  HLStory.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/5/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLStory : NSManagedObject

@property NSDictionary *thumbnailDictionary;

@end

NS_ASSUME_NONNULL_END

#import "HLStory+CoreDataProperties.h"
