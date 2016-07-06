//
//  HLConnectionManager+HLRequests.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "HLConnectionManager+HLRequests.h"

@implementation HLConnectionManager (HLRequests)

- (NSString *)getCharactersWithOffset:(int)offset delegate:(id<HLConnectionManagerDelegate>)delegate {
    
    NSDictionary *requestParams = @{@"offset":@(offset)};
    NSDictionary *userParams = @{REQUEST_FIELD:REQUEST_FIELD_GET_CHARACTERS};
    return [HLClientAPI getObjectsAtPath:REQUEST_METHOD_GET_CHARACTERS
                              parameters:requestParams
                              userParams:userParams
                                delegate:delegate];
}

- (NSString *)getCharacterComicsWithID:(NSNumber *)charID delegate:(id<HLConnectionManagerDelegate>)delegate {
    
    NSDictionary *userParams = @{REQUEST_FIELD:REQUEST_FIELD_GET_CHARACTER_COMICS,
                                 CHARACTER_ID_FIELD:charID};
    return [HLClientAPI getObjectsAtPath:[NSString stringWithFormat:REQUEST_METHOD_GET_CHARACTER_COMICS, (long)charID.integerValue]
                              parameters:nil
                              userParams:userParams
                                delegate:delegate];
}

- (NSString *)getCharacterEventsWithID:(NSNumber *)charID delegate:(id<HLConnectionManagerDelegate>)delegate {
    
    NSDictionary *userParams = @{REQUEST_FIELD:REQUEST_FIELD_GET_CHARACTER_EVENTS,
                                 CHARACTER_ID_FIELD:charID};
    return [HLClientAPI getObjectsAtPath:[NSString stringWithFormat:REQUEST_METHOD_GET_CHARACTER_EVENTS, (long)charID.integerValue]
                              parameters:nil
                              userParams:userParams
                                delegate:delegate];
}

- (NSString *)getCharacterSeriesWithID:(NSNumber *)charID delegate:(id<HLConnectionManagerDelegate>)delegate {
    
    NSDictionary *userParams = @{REQUEST_FIELD:REQUEST_FIELD_GET_CHARACTER_SERIES,
                                 CHARACTER_ID_FIELD:charID};
    return [HLClientAPI getObjectsAtPath:[NSString stringWithFormat:REQUEST_METHOD_GET_CHARACTER_SERIES, (long)charID.integerValue]
                              parameters:nil
                              userParams:userParams
                                delegate:delegate];
}

- (NSString *)getCharacterStoriesWithID:(NSNumber *)charID delegate:(id<HLConnectionManagerDelegate>)delegate {
    
    NSDictionary *userParams = @{REQUEST_FIELD:REQUEST_FIELD_GET_CHARACTER_STORIES,
                                 CHARACTER_ID_FIELD:charID};
    return [HLClientAPI getObjectsAtPath:[NSString stringWithFormat:REQUEST_METHOD_GET_CHARACTER_STORIES, (long)charID.integerValue]
                              parameters:nil
                              userParams:userParams
                                delegate:delegate];
}

- (void)setupMapping {
    [self addMappingForEntityName:@"HLCharacter"
                attributeMappings:@{@"name": @"name",
                                    @"id": @"serverID",
                                    @"thumbnail": @"thumbnailDictionary",
                                    @"description": @"info"}
                              ids:@[@"serverID"]
                      pathPattern:REQUEST_FIELD_GET_CHARACTERS];
    
    [self addMappingForEntityName:@"HLComics"
                attributeMappings:@{@"id": @"serverID",
                                    @"title": @"title",
                                    @"thumbnail": @"thumbnailDictionary"}
                              ids:@[@"serverID"]
                      pathPattern:REQUEST_FIELD_GET_CHARACTER_COMICS];
    
    [self addMappingForEntityName:@"HLEvent"
                attributeMappings:@{@"id": @"serverID",
                                    @"title": @"title",
                                    @"thumbnail": @"thumbnailDictionary"}
                              ids:@[@"serverID"]
                      pathPattern:REQUEST_FIELD_GET_CHARACTER_EVENTS];
    
    [self addMappingForEntityName:@"HLSerie"
                attributeMappings:@{@"id": @"serverID",
                                    @"title": @"title",
                                    @"thumbnail": @"thumbnailDictionary"}
                              ids:@[@"serverID"]
                      pathPattern:REQUEST_FIELD_GET_CHARACTER_SERIES];
    
    [self addMappingForEntityName:@"HLStory"
                attributeMappings:@{@"id": @"serverID",
                                    @"title": @"title",
                                    @"thumbnail": @"thumbnailDictionary"}
                              ids:@[@"serverID"]
                      pathPattern:REQUEST_FIELD_GET_CHARACTER_STORIES];
}

@end
