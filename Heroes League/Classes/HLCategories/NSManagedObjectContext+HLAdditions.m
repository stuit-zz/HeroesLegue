//
//  NSManagedObjectContext+HLAdditions.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/4/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "NSManagedObjectContext+HLAdditions.h"

@implementation NSManagedObjectContext (HLAdditions)

+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context {
    [self MR_setRootSavingContext:context];
}

+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc {
    [self MR_setDefaultContext:moc];
}

@end
