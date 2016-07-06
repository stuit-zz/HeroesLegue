//
//  HLConnectionManager.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HLClientAPI [HLConnectionManager sharedManager]

@protocol HLConnectionManagerDelegate <NSObject>

@optional

- (void)connectionDidFinishWithOperation:(RKObjectRequestOperation *)operation
                           mappingResult:(RKMappingResult *)mappingResult
                              userParams:(NSDictionary *)userParams
                                   error:(NSError *)error;

@end

@interface HLConnectionManager : NSObject

+ (const HLConnectionManager *)sharedManager;

- (NSString *)getObjectsAtPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                    userParams:(NSDictionary *)userParams
                      delegate:(id<HLConnectionManagerDelegate>)delegate;

- (void)addMappingForEntityName:(NSString *)entityName
              attributeMappings:(NSDictionary *)attributeMappings
                            ids:(NSArray *)ids
                    pathPattern:(NSString *)pathPattern;

- (void)configureRestKit;

@end
