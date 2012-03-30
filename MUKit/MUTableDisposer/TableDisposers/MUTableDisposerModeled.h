//
//  MUTableDisposerModeled.h
//  MUKitTest
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposer.h"
#import "MUCellDataModeled.h"


@interface MUTableDisposerModeled : MUTableDisposer
{
    NSMutableDictionary* registeredClasses;
}

- (void) registerCellData:(Class)aCellDataClass forModel:(Class)aModelClass;
- (void) setupModels:(NSArray*)aModels forSectionAtIndex:(NSUInteger)aSectionIndex;
- (void) setupModels:(NSArray*)aModels forSection:(MUSectionReadonly*)aSection;

@end
