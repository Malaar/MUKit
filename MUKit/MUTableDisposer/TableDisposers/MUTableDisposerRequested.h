//
//  MUTableDisposerRequested.h
//  MUKitTest
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposerModeled.h"
#import "MUSectionReadonly.h"


@interface MUTableDisposerRequested : MUTableDisposerModeled
{
    NSMutableDictionary* requests;
}

- (void) designateRequest:(id)aRequest forSectionAtIndex:(NSUInteger)aSectionIndex;
- (void) designateRequest:(id)aRequest forSection:(MUSectionReadonly*)aSection;

- (void) reloadDataForSectionAtIndex:(NSUInteger)aSectionIndex;
- (void) reloadDataForSection:(MUSectionReadonly*)aSection;
- (void) reloadDataForAllSections;

@end
