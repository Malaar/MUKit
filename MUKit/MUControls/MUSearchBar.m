//
//  MUSearchBar.m
//  MUKit
//
//  Created by Malaar on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUSearchBar.h"

@interface MUSearchBar(Private)

- (void) replaceBG;

@end

@implementation MUSearchBar

@synthesize imageBG;

#pragma mark - init/dealloc
//==============================================================================
//- (id) init
//{
//    if( (self = [super init]) )
//    {
//    }
//    
//    return self;
//}

//==============================================================================
- (void) dealloc
{
    [imageBG release];
    
    [super dealloc];
}

//==============================================================================
- (void) setImageBG:(UIImage *)aImageBG
{
    if(imageBG != aImageBG)
    {
        [imageBG release];
        imageBG = [aImageBG retain];
        [self replaceBG];
        [backgroundView setImage:imageBG];
    }
}

//==============================================================================
- (void) replaceBG
{
    for(UIView* view in self.subviews)
    {
        //NSLog(@"SUBV: %@; superclass: %@", view, [view superclass]);
        if( [NSStringFromClass([view class]) isEqualToString:@"UISearchBarBackground"] )
        {
            [view removeFromSuperview];
            backgroundView = [[UIImageView alloc] initWithImage:imageBG];
            [self addSubview:backgroundView];
            [self sendSubviewToBack:backgroundView];
            break;
        }
    }
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
