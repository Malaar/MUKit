//
//  MUTextCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataLabel.h"
#import "MUCellLabel.h"

@implementation MUCellDataLabel

@synthesize title, titleFont, titleColor;
@synthesize text, textFont, textColor;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super initWithObject:aObject key:aKey];
    if(self)
    {
        self.cellClass = [MUCellLabel class];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [title release];
    [titleColor release];
    [titleFont release];
    [text release];
    [textColor release];
    [textFont release];
    
    [super dealloc];
}

#pragma mark - Maping
//==============================================================================
- (void) mapFromObject
{
    text = [object valueForKey:key];
}

//==============================================================================
- (void) mapToObject
{
    [object setValue:text forKey:key];
}

@end
