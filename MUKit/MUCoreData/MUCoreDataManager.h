//
//  MUCoreDataManager.h
//  Pro-Otdyh
//
//  Created by Malaar on 16.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MUCoreDataManager : NSObject

@property (nonatomic, strong, readonly) NSString* persistentStoreName;

@property (nonatomic, strong, readonly) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator* persistentStoreCoordinator;

- (void) saveContext;

- (void)resetStore;
- (void)removeAllEntitiesWithName:(NSString *)entityName;

/**
 * Remove all data from storage asynchronously. Call this method from main thread.
 */
- (void)resetStoreAsycWithCallback:(void(^)(void))aCallback;
/**
 * Remove all entities with names `entityName` from context `moc`
 */
- (void)removeAllEntitiesWithName:(NSString *)entityName inMOC:(NSManagedObjectContext*)moc;

@end
