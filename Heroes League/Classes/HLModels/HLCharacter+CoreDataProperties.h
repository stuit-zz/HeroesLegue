//
//  HLCharacter+CoreDataProperties.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/6/16.
//  Copyright © 2016 HL. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HLCharacter.h"

NS_ASSUME_NONNULL_BEGIN

@interface HLCharacter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *info;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *serverID;
@property (nullable, nonatomic, retain) NSString *thumbnailURL;
@property (nullable, nonatomic, retain) NSSet<HLComics *> *comics;
@property (nullable, nonatomic, retain) NSSet<HLEvent *> *events;
@property (nullable, nonatomic, retain) NSSet<HLSerie *> *series;
@property (nullable, nonatomic, retain) NSSet<HLStory *> *stories;

@end

@interface HLCharacter (CoreDataGeneratedAccessors)

- (void)addComicsObject:(HLComics *)value;
- (void)removeComicsObject:(HLComics *)value;
- (void)addComics:(NSSet<HLComics *> *)values;
- (void)removeComics:(NSSet<HLComics *> *)values;

- (void)addEventsObject:(HLEvent *)value;
- (void)removeEventsObject:(HLEvent *)value;
- (void)addEvents:(NSSet<HLEvent *> *)values;
- (void)removeEvents:(NSSet<HLEvent *> *)values;

- (void)addSeriesObject:(HLSerie *)value;
- (void)removeSeriesObject:(HLSerie *)value;
- (void)addSeries:(NSSet<HLSerie *> *)values;
- (void)removeSeries:(NSSet<HLSerie *> *)values;

- (void)addStoriesObject:(HLStory *)value;
- (void)removeStoriesObject:(HLStory *)value;
- (void)addStories:(NSSet<HLStory *> *)values;
- (void)removeStories:(NSSet<HLStory *> *)values;

@end

NS_ASSUME_NONNULL_END
