//
//  HLConnectionManager+HLRequests.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "HLConnectionManager.h"

@interface HLConnectionManager (HLRequests)

- (void)setupMapping;

- (NSString *)getCharactersWithOffset:(int)offset delegate:(id<HLConnectionManagerDelegate>)delegate;
- (NSString *)getCharacterComicsWithID:(NSNumber *)charID delegate:(id<HLConnectionManagerDelegate>)delegate;
- (NSString *)getCharacterEventsWithID:(NSNumber *)charID delegate:(id<HLConnectionManagerDelegate>)delegate;
- (NSString *)getCharacterSeriesWithID:(NSNumber *)charID delegate:(id<HLConnectionManagerDelegate>)delegate;
- (NSString *)getCharacterStoriesWithID:(NSNumber *)charID delegate:(id<HLConnectionManagerDelegate>)delegate;

@end
