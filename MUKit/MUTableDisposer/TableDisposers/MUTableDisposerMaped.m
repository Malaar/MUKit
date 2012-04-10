//
//  MUTableDisposerMaped.m
//  MUKitTest
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposerMaped.h"

@implementation MUTableDisposerMaped

//==============================================================================
- (void) mapFromObject
{
    for(MUSectionReadonly* section in sections)
    {
        if([section isKindOfClass:[MUSectionWritable class]])
        {
            [(MUSectionWritable*)section mapFromObject];
        }
    }
}

//==============================================================================
- (void) mapToObject
{
    for(MUSectionReadonly* section in sections)
    {
        if([section isKindOfClass:[MUSectionWritable class]])
        {
            [(MUSectionWritable*)section mapToObject];
        }
    }
}

@end
