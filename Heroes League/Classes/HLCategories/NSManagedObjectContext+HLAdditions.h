//
//  NSManagedObjectContext+HLAdditions.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/4/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (HLAdditions)

+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;

@end
