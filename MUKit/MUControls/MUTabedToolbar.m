//
//  MUTabBar.m
//  MUKit
//
//  Created by Malaar on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTabedToolbar.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUTabedToolbar (Private)

- (void) setup;
- (void) itemPressed:(UIButton*)aSender;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUTabedToolbar

@synthesize delegate;
@synthesize buttons;
@synthesize enabled;

#pragma mark - init/dealloc

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        [self setup];
    }
    return self;
}

//==============================================================================
- (id) initWithFrame:(CGRect)aFrame
{
	if( (self = [super initWithFrame:aFrame]) )
	{
        [self setup];
	}
	
	return self;
}

//==============================================================================
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if( (self = [super initWithCoder:aDecoder]) )
    {
        [self setup];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [buttons release];
	
	[super dealloc];
}

//==============================================================================
- (void) setup
{
    self.backgroundColor = [UIColor clearColor];
    [self setEnabled:YES];
}

//==============================================================================
- (void) itemPressed:(UIButton*)aSender
{
	if(!enabled)
		return;
    
    BOOL canSelect = YES;
    if([delegate respondsToSelector:@selector(tabedToolbar:shouldSelectItemAtIndex:)])
        canSelect = [delegate tabedToolbar:self shouldSelectItemAtIndex:aSender.tag];

    if(canSelect)
    {
        NSUInteger prevIndex = (currentItem) ? (currentItem.tag) : (NSNotFound);
        [self switchToItemWithIndex:aSender.tag];
        
        if([delegate respondsToSelector:@selector(tabedToolbar:itemChangedTo:from:)])
            [delegate tabedToolbar:self itemChangedTo:aSender.tag from:prevIndex];
    }
}

//==============================================================================
// programmaticaly switch to title by index
/**
 * delegate method
 * - (void) tabBar:(MUTabBar*)aTabBar itemChangedTo:(int)aToIndex from:(int)aFromIndex;
 * WON'T be called
 */
- (void) switchToItemWithIndex:(NSUInteger)aIndex
{
    UIButton* selItem = nil;
    if(aIndex < [buttons count])
    {
        selItem = [buttons objectAtIndex:aIndex];
    }

    currentItem.enabled = YES;
    selItem.enabled = NO;
    currentItem = selItem;
}

//==============================================================================
- (void) setEnabled:(BOOL)aEnabled
{
	enabled = aEnabled;
	self.userInteractionEnabled = enabled;
}

//==============================================================================
- (void) setButtons:(NSMutableArray *)aButtons
{
    if(buttons == aButtons)
        return;
    
    [buttons release];
    buttons = [aButtons retain];
    
    NSMutableArray* items = [NSMutableArray new];
    UIBarButtonItem* bbi;
    
    int index = 0;
    for(UIButton* bt in buttons)
    {
        bt.tag = index++;
        [bt addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];

        bbi = [[UIBarButtonItem alloc] initWithCustomView:bt];
        [items addObject:bbi];
        [bbi release];
    }
    
    self.items = items;

    [items release];
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
