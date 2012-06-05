//
//  MUCoreDataManager.m
//  Pro-Otdyh
//
//  Created by Malaar on 16.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCoreDataManager.h"


@implementation MUCoreDataManager

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
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
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
                                                                               options:nil 
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

@end
