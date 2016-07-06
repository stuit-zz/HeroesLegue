//
//  HLEvent+CoreDataProperties.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/7/16.
//  Copyright © 2016 HL. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HLEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface HLEvent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *serverID;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *thumbnailURL;
@property (nullable, nonatomic, retain) NSSet<HLCharacter *> *characters;

@end

@interface HLEvent (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(HLCharacter *)value;
- (void)removeCharactersObject:(HLCharacter *)value;
- (void)addCharacters:(NSSet<HLCharacter *> *)values;
- (void)removeCharacters:(NSSet<HLCharacter *> *)values;

@end

NS_ASSUME_NONNULL_END
