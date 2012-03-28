//
//  MUImageViewTapable.m
//  MUKit
//
//  Created by Malaar on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUImageViewTapable.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUImageViewTapable (Private)

- (void) initialize;
- (void) handleTap:(UITapGestureRecognizer*)aTapRecognizer;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUImageViewTapable

@synthesize enable;
@synthesize data;

//==============================================================================
- (id)init
{
    if( (self = [super init]) )
    {
        [self initialize];
    }
    return self;
}

//==============================================================================
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if( (self = [super initWithCoder:aDecoder]) )
    {
        [self initialize];
    }
    return self;
}

//==============================================================================
- (id) initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self initialize];
    }
    return self;
}

//==============================================================================
- (void) initialize
{
    enable = YES;
    targetActions = [NSMutableArray new];
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapRecognizer];
    [tapRecognizer release];
}

//==============================================================================
- (void) dealloc
{
    [targetActions release];
    [data release];
    
    [super dealloc];
}

//==============================================================================
- (void) addTarget:(id)aTarget action:(SEL)anAction
{
    MUTargetAction* ta = [MUTargetAction targetActionWithTarget:aTarget action:anAction];
    [targetActions addObject:ta];
}

//==============================================================================
- (void) handleTap:(UITapGestureRecognizer*)aTapRecognizer
{
    if(!enable)
        return;
    
    if(aTapRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [targetActions makeObjectsPerformSelector:@selector(sendActionFrom:) withObject:self];
    }
}


@end
