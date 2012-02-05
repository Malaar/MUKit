//
//  MUBOTitledID.m
//  MUKit
//
//  Created by Malaar on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTitledID.h"


@implementation MUTitledID

@synthesize ID;
@synthesize title;

//==============================================================================
+ (id) titledIDWithID:(id)aID title:(NSString*)aTitle
{
    return [[[MUTitledID alloc] initWithID:aID title:aTitle] autorelease];
}

//==============================================================================
- (id) initWithID:(id)aID title:(NSString*)aTitle
{
    if( (self = [super init]) )
    {
        self.ID = aID;
        self.title = aTitle;
    }
    
    return self;
}

//==============================================================================
- (void) dealloc
{
    [ID release];
    [title release];
    
    [super dealloc];
}

//==============================================================================
- (id) copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithID:ID title:title];
}

//==============================================================================
- (NSString*) description
{
    return [NSString stringWithFormat:@"{%@, %@}", ID, title];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation NSArray (MUTitledID)

//==============================================================================
- (MUTitledID*) titledIDByID:(id) aID
{
    MUTitledID* result = nil;
    
    if([aID isKindOfClass:[NSString class]])
    {
        for(MUTitledID* titledID in self)
        {
            if([titledID.ID isEqualToString:aID])
            {
                result = titledID;
                break;
            }
        }
    }
    else
    {
        for(MUTitledID* titledID in self)
        {
            if([titledID.ID isEqual:aID])
            {
                result = titledID;
                break;
            }
        }
    }

    return result;
}

//==============================================================================
- (MUTitledID*) titledIDByTitle:(NSString*) aTitle
{
    MUTitledID* result = nil;
    
    for(MUTitledID* titledID in self)
    {
        if([titledID.ID isEqualToString:aTitle])
        {
            result = titledID;
            break;
        }
    }
    
    return result;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end