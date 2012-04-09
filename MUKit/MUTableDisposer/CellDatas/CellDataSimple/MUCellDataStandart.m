//
//  MULabelCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataStandart.h"
#import "MUCellStandart.h"


@implementation MUCellDataStandart

@synthesize subtitle;
@synthesize image;
@synthesize imageURL;
@synthesize imagePlaceholder;
@synthesize title;
@synthesize titleFont;
@synthesize subtitleFont;
@synthesize titleColor;
@synthesize subtitleColor;
@synthesize titleTextAlignment;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super initWithObject:aObject key:aKey];
    if (self)
    {
        self.cellClass = [MUCellStandart class];
        
        titleTextAlignment = UITextAlignmentLeft;
        titleFont = [UIFont systemFontOfSize:18];
        subtitleFont = [UIFont systemFontOfSize:16];
        titleColor = [UIColor blackColor];
        subtitleColor = [UIColor grayColor];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [subtitle release];
    [image release];
    [imageURL release];
    [imagePlaceholder release];
    [title release];
    [titleColor release];
    [subtitleColor release];
    
    [super dealloc];
}

#pragma mark - Maping
//==============================================================================
- (void) mapFromObject
{
    if (object && key)
        subtitle = [[object valueForKey:key] retain];
}

//==============================================================================
- (void) mapToObject
{
    if (object && key)
        [object setValue:subtitle forKey:key];
}

@end
