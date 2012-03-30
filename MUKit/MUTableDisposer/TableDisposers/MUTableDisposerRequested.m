//
//  MUTableDisposerRequested.m
//  MUKitTest
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposerRequested.h"

@implementation MUTableDisposerRequested

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        requests = [NSMutableDictionary new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [requests release];
    
    [super dealloc];
}

//==============================================================================
- (void) designateRequest:(id)aRequest forSectionAtIndex:(NSUInteger)aSectionIndex
{
    [requests setObject:aRequest forKey:[NSNumber numberWithInt:aSectionIndex]];

    // setup completion block
    {
        NSArray* models = nil;
        MUSectionReadonly* section = [self sectionByIndex:aSectionIndex];
        [section removeAllCellData];
        [self setupModels:models forSection:section];
    }
}

//==============================================================================
- (void) designateRequest:(id)aRequest forSection:(MUSectionReadonly*)aSection
{
    NSUInteger index = [self indexBySection:aSection];
    [self designateRequest:aRequest forSectionAtIndex:index];
}

//==============================================================================
- (void) reloadData
{
}

//==============================================================================
- (void) reloadDataForSectionAtIndex:(NSUInteger)aSectionIndex
{
    [[self sectionByIndex:aSectionIndex] removeAllCellData];
    
    id request = [requests objectForKey:[NSNumber numberWithInt:aSectionIndex]];
    [request start];
}

//==============================================================================
- (void) reloadDataForSection:(MUSectionReadonly*)aSection
{
    [self reloadDataForSectionAtIndex:[self indexBySection:aSection]];
}

//==============================================================================
- (void) reloadDataForAllSections
{
    for(MUSectionReadonly* section in sections)
    {
        [self reloadDataForSection:section];
    }
}

//==============================================================================

@end
