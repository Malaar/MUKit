//
//  MUCellDataTextPair.m
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextPair.h"

@implementation MUCellDataTextPair

@synthesize title, titleFont, titleColor;
@synthesize text, textFont, textColor;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super initWithObject:aObject key:aKey];
    if(self)
    {
        titleFont = [UIFont systemFontOfSize:16];
        titleColor = [UIColor blackColor];
        
        textFont = [UIFont systemFontOfSize:16];
        textColor = [UIColor blackColor];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [title release];
    [titleColor release];
    [text release];
    [textColor release];
    
    [super dealloc];
}

#pragma mark - Maping
//==============================================================================
- (void) mapFromObject
{
    if (object && key)
        text = [[object valueForKey:key] retain];
}

//==============================================================================
- (void) mapToObject
{
    if (object && key)
        [object setValue:text forKey:key];
}

@end
