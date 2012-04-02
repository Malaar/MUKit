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
    [registeredClasses setObject:aCellDataClass forKey:aModelClass];
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
        Class cellDataClass = [registeredClasses objectForKey:[model class]];
        
        NSAssert(cellDataClass, (NSString*)([NSString stringWithFormat:@"Model doesn't have registered cellData class %@", NSStringFromClass([model class])]));
        NSAssert([cellDataClass isSubclassOfClass:[MUCellDataModeled class]], @"CellData must be subclass of MUCellDataModeled!");

        MUCellDataModeled* cellData = [[[cellDataClass alloc] initWithModel:model] autorelease];
        if(cellData)
        {
            if(modeledDelegate && [modeledDelegate respondsToSelector:@selector(tableDisposer:didCreateCellData:)])
                [modeledDelegate tableDisposer:self didCreateCellData:cellData];

            [aSection addCellData:cellData];
        }
    }

    [aSection reloadWithAnimation:UITableViewRowAnimationMiddle];
}

@end
