//
//  MUTableDisposerModeled.m
//  MUKitTest
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposerModeled.h"

@implementation MUTableDisposerModeled

@synthesize modeledDelegate;

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        registeredClasses = [NSMutableDictionary new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [registeredClasses release];
    
    [super dealloc];
}

//==============================================================================
- (void) registerCellData:(Class)aCellDataClass forModel:(Class)aModelClass
{
    [registeredClasses setObject:NSStringFromClass(aCellDataClass) forKey:NSStringFromClass(aModelClass)];
}

//==============================================================================
- (void) setupModels:(NSArray*)aModels forSectionAtIndex:(NSUInteger)aSectionIndex
{
    MUSectionReadonly* section = [self sectionByIndex:aSectionIndex];
    [self setupModels:aModels forSection:section];
}

//==============================================================================
- (void) setupModels:(NSArray*)aModels forSection:(MUSectionReadonly*)aSection
{
    NSAssert(aSection, @"aSection is nil!!!");
    
    for(id model in aModels)
    {
        MUCellDataModeled* cellData = [self cellDataFromModel:model];
        if(cellData)
        {
            [aSection addCellData:cellData];

            if(modeledDelegate && [modeledDelegate respondsToSelector:@selector(tableDisposer:didCreateCellData:)])
            {
                [modeledDelegate tableDisposer:self didCreateCellData:cellData];
            }

        }
    }

}

- (MUCellDataModeled*)cellDataFromModel:(id)aModel
{
    NSString* modelClassName = NSStringFromClass([aModel class]);
    NSString* cellDataClassName = [registeredClasses objectForKey:modelClassName];
    Class cellDataClass = NSClassFromString(cellDataClassName);
    
    if(!cellDataClass && modeledDelegate && [modeledDelegate respondsToSelector:@selector(tableDisposer:cellDataClassForUnregisteredModel:)])
    {
        cellDataClass = [modeledDelegate tableDisposer:self cellDataClassForUnregisteredModel:aModel];
    }
    
    NSAssert(cellDataClass, (NSString*)([NSString stringWithFormat:@"Model doesn't have registered cellData class %@", NSStringFromClass([aModel class])]));
    NSAssert([cellDataClass isSubclassOfClass:[MUCellDataModeled class]], @"CellData must be subclass of MUCellDataModeled!");
    
    MUCellDataModeled* cellData = [[[cellDataClass alloc] initWithModel:aModel] autorelease];

    return cellData;
}

@end
