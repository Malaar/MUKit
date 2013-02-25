//
//  MUCoreDataManager.m
//  Pro-Otdyh
//
//  Created by Malaar on 16.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCoreDataManager.h"


@implementation MUCoreDataManager

@dynamic contextConcurrencyType;
@dynamic migrationPolicy;
@synthesize persistentStoreName;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//==============================================================================
- (NSManagedObjectContext *) managedObjectContext
{
    
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:self.contextConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
        _managedObjectContext.mergePolicy = NSOverwriteMergePolicy;
    }
    return _managedObjectContext;
}

//==============================================================================
- (NSManagedObjectModel *)managedObjectModel
{
    
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:[NSBundle mainBundle]]];    
    [_managedObjectModel retain];
    return _managedObjectModel;
}

//==============================================================================
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectoryURL =  [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeUrl = [NSURL URLWithString:self.persistentStoreName relativeToURL:documentsDirectoryURL];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSError *error = nil;
    NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType 
                                                                         configuration:nil 
                                                                                   URL:storeUrl 
                                                                               options:self.migrationPolicy
                                                                                 error:&error];
    
    if (!store)
    {
        // !!!!
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

//==============================================================================
- (void) saveContext
{
    NSManagedObjectContext* moc = self.managedObjectContext;
    
    @synchronized(moc)
    {
        NSError* error = nil;
        if(moc.hasChanges && ![moc save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//==============================================================================
- (NSString*) persistentStoreName
{
    NSAssert(NO, @"Override this!!!");
    return nil;
}

//==============================================================================
- (NSManagedObjectContextConcurrencyType)contextConcurrencyType
{
    return NSConfinementConcurrencyType;
}

//==============================================================================
- (NSDictionary*)migrationPolicy
{
    return @{
    NSMigratePersistentStoresAutomaticallyOption : [NSNumber numberWithBool:YES],
    NSInferMappingModelAutomaticallyOption : [NSNumber numberWithBool:YES]
    };
}

//==============================================================================
- (void)resetStore
{
    NSAssert(NO, @"Override this!!!");
}

//==============================================================================
- (void)removeAllEntitiesWithName:(NSString *)entityName
{
    NSFetchRequest *allEntities = [[NSFetchRequest new] autorelease];
    allEntities.entity = [NSEntityDescription entityForName:entityName
                                     inManagedObjectContext:self.managedObjectContext];
    [allEntities setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *entities = [self.managedObjectContext executeFetchRequest:allEntities error:&error];
    for (NSManagedObject *object in entities)
    {
        [self.managedObjectContext deleteObject:object];
    }
    
}

//==============================================================================
/**
 * Remove all data from storage asynchronously. Call this method from main thread.
 */
- (void)resetStoreAsycWithCallback:(void(^)(void))aCallback
{
    NSAssert(NO, @"Override this!!!");
}

//==============================================================================
/**
 * Remove all entities with names `entityName` from context `moc`
 */
- (void)removeAllEntitiesWithName:(NSString *)entityName inMOC:(NSManagedObjectContext*)moc
{
    NSFetchRequest *allEntities = [[NSFetchRequest new] autorelease];
    allEntities.entity = [NSEntityDescription entityForName:entityName
                                     inManagedObjectContext:moc];
    [allEntities setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *entities = [moc executeFetchRequest:allEntities error:&error];
    for (NSManagedObject *object in entities)
    {
        [moc deleteObject:object];
    }
}

@end
