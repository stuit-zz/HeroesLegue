//
//  HLConnectionManager.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "HLConnectionManager.h"

@implementation HLConnectionManager {
    RKObjectManager *objectManager;
    RKManagedObjectStore *managedObjectStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (const HLConnectionManager *)sharedManager {
    static const HLConnectionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HLConnectionManager alloc] init];
    });
    return instance;
}


- (void)configureRestKit {

    NSURL *baseURL = [NSURL URLWithString:SERVER_URL];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];


    objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    if (!managedObjectModel)
        return;
    
    managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    NSError *error;
    if (!RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error))
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
    
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Heroes-League.sqlite"];
    if (![managedObjectStore addSQLitePersistentStoreAtPath:path
                                     fromSeedDatabaseAtPath:nil
                                          withConfiguration:nil options:nil error:&error])
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
    
    [managedObjectStore createManagedObjectContexts];
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:managedObjectStore.persistentStoreCoordinator];
    [NSManagedObjectContext MR_setRootSavingContext:managedObjectStore.persistentStoreManagedObjectContext];
    [NSManagedObjectContext MR_setDefaultContext:managedObjectStore.mainQueueManagedObjectContext];
}

- (NSString *)getObjectsAtPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                    userParams:(NSDictionary *)userParams
                      delegate:(id<HLConnectionManagerDelegate>)delegate {
    NSString *requestIdentifier = [self makeIdentifier];
    
    NSString *hash = [[[NSString stringWithFormat:@"%@%@%@", requestIdentifier, MARVEL_PRIVATE_KEY, MARVEL_PUBLIC_KEY] md5] lowercaseString];
    
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{@"apikey": MARVEL_PUBLIC_KEY,
                                                                                       @"ts": requestIdentifier,
                                                                                       @"hash": hash}];
    if (parameters)
        [queryParams addEntriesFromDictionary:parameters];
    
    if (userParams == nil)
        userParams = @{};
    
    __block NSDictionary *_userParams = userParams;
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"%@%@", API_PATHERN, path]
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if ([delegate respondsToSelector:@selector(connectionDidFinishWithOperation:mappingResult:userParams:error:)]) {
                                                      [delegate connectionDidFinishWithOperation:operation
                                                                                   mappingResult:mappingResult
                                                                                      userParams:_userParams
                                                                                           error:nil];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  if ([delegate respondsToSelector:@selector(connectionDidFinishWithOperation:mappingResult:userParams:error:)]) {
                                                      [delegate connectionDidFinishWithOperation:operation
                                                                                   mappingResult:nil
                                                                                      userParams:_userParams
                                                                                           error:error];
                                                  }
                                              }];
    return requestIdentifier;
}

- (void)addMappingForEntityName:(NSString *)entityName attributeMappings:(NSDictionary *)attributeMappings ids:(NSArray *)ids pathPattern:(NSString *)pathPattern {
    if (!managedObjectStore)
        return;
    
    RKEntityMapping *objectMapping = [RKEntityMapping mappingForEntityForName:entityName
                                                         inManagedObjectStore:managedObjectStore];
    
    [objectMapping addAttributeMappingsFromDictionary:attributeMappings];
    objectMapping.identificationAttributes = ids;
    
    RKResponseDescriptor *characterResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:objectMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:[NSString stringWithFormat:@"%@%@", API_PATHERN, pathPattern]
                                                keyPath:@"data.results"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:characterResponseDescriptor];
}

- (NSString *)makeIdentifier {
    NSDate *date = [NSDate date];
    NSString *identifier = [[NSString alloc] initWithFormat:@"%f", [date timeIntervalSince1970]];
    return identifier;
}

@end
