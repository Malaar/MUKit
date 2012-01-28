//
//  MUTabBar.m
//  ROM
//
//  Created by Malaar on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUToolbar.h"


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUToolbar

@synthesize backgroundImage = bgImage;
@synthesize drawColor;

#pragma mark - init/dealloc
//==============================================================================
- (id) initWithFrame:(CGRect)aFrame
{
	if( (self = [super initWithFrame:aFrame]) )
	{
		self.backgroundColor = [UIColor clearColor];
        drawColor = NO;
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[bgImage release];
	
	[super dealloc];
}

//==============================================================================
- (void) drawRect:(CGRect)aRect
{
    if(bgImage)
        [bgImage drawInRect:self.bounds blendMode:kCGBlendModeNormal alpha:1.0f];
    else if(drawColor)
    {
        CGContextRef context = UIGraphicsGetCurrentContext(); 
        CGColorRef colorRef = self.backgroundColor.CGColor;
        const float* components = CGColorGetComponents(colorRef);
        CGContextSetRGBFillColor(context, components[0], components[1], components[2], components[3]);
        CGContextFillRect(context, self.bounds);

    }
    else
        [super drawRect:aRect];
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
