//
//  MULabelCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULabelCellData.h"

@implementation MULabelCellData

@synthesize value;
@synthesize image;
@synthesize title;
@synthesize titleFont;
@synthesize valueFont;
@synthesize titleColor;
@synthesize valueColor;
@synthesize titleTextAlignment;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey title:(NSString *)aTitle
{
    self = [super initWithObject:aObject key:aKey];
    if (self)
    {
        self.title = aTitle;
    }
    return self;
}

//==============================================================================
- (void) setup
{
    [super setup];
    
    titleTextAlignment = UITextAlignmentLeft;
    titleFont = [UIFont systemFontOfSize:18];
    valueFont = [UIFont systemFontOfSize:16];
    titleColor = [UIColor blackColor];
    valueColor = [UIColor grayColor];
}

//==============================================================================
- (void) dealloc
{
    [value release];
    [image release];
    [title release];
    [titleColor release];
    [titleFont release];
    
    [super dealloc];
}

#pragma mark - Maping
//==============================================================================
- (void) mapFromObject
{
    value = [object valueForKey:key];
}

//==============================================================================
- (void) mapToObject
{
    [object setValue:value forKey:key];
}

@end
