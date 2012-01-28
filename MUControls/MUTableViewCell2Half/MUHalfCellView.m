//
//  MUHalfCellView.m
//  TimeLink
//
//  Created by Yuriy Bosov on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUHalfCellView.h"

@implementation MUHalfCellView

//==============================================================================
@synthesize padding, alignment, distanceBetweenSubView;

//==============================================================================
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // default padding
        padding = MUHalfCellPaddingZero();
        
        // default alignment
        alignment = halfCellAlignmentNone;
    }
    return self;
}

//==============================================================================
- (void) setAlignment:(MUHalfCellAlignment)aAlignment
{
    if ([self.subviews count])
    {
        //CGPoint origin = CGPointZero;
        CGRect frame = CGRectZero;
        // горизонтальное
        if (aAlignment & halfCellAlignmentLeft)
        {
            for (int i = 0; i < [self.subviews count]; i++)
            {
                if ([[self.subviews objectAtIndex:i] isKindOfClass:[UILabel class]] ||
                    [[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]])
                {
                    [[self.subviews objectAtIndex:i] setTextAlignment:UITextAlignmentLeft];
                }
                frame = [[self.subviews objectAtIndex:i] frame];
                frame.origin.x = padding.leftPadding;
                [[self.subviews objectAtIndex:i] setFrame:frame];
            }
        }
        else if (aAlignment & halfCellAlignmentCenter)
        {
            float contentWidth = self.frame.size.width - padding.rightPadding - padding.leftPadding;
            for (int i = 0; i < [self.subviews count]; i++)
            {
                if ([[self.subviews objectAtIndex:i] isKindOfClass:[UILabel class]] ||
                    [[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]])
                {
                    [[self.subviews objectAtIndex:i] setTextAlignment:UITextAlignmentCenter];
                }

                frame = [[self.subviews objectAtIndex:i] frame];
                frame.origin.x = padding.leftPadding + contentWidth/2 - frame.size.width/2;
                [[self.subviews objectAtIndex:i] setFrame:frame];
            }
        }
        else if (aAlignment & halfCellAlignmentRight)
        {
            for (int i = 0; i < [self.subviews count]; i++)
            {
                if ([[self.subviews objectAtIndex:i] isKindOfClass:[UILabel class]] ||
                    [[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]])
                {
                    [[self.subviews objectAtIndex:i] setTextAlignment:UITextAlignmentRight];
                }

                frame = [[self.subviews objectAtIndex:i] frame];
                frame.origin.x = self.frame.size.width - padding.rightPadding - frame.size.width;
                [[self.subviews objectAtIndex:i] setFrame:frame];
            }
        }
        
        // вертикальное
        if (aAlignment & halfCellAlignmentTop)
        {
            for (int i = 0; i < [self.subviews count]; i++)
            {
                frame = [[self.subviews objectAtIndex:i] frame];
                if (i - 1 >= 0)
                    frame.origin.y = [[self.subviews objectAtIndex:i - 1] frame].origin.y + [[self.subviews objectAtIndex:i - 1] frame].size.height +  distanceBetweenSubView;
                else 
                    frame.origin.y = padding.topPadding;

                [[self.subviews objectAtIndex:i] setFrame:frame];
            }
        }
        else if (aAlignment & halfCellAlignmentMiddle)
        {
            float height = 0;
            float delta = 0;
            for (int i = 0; i < [self.subviews count]; i++)
            {
                height += [[self.subviews objectAtIndex:i] frame].size.height;
                if (i != 0 && i != [self.subviews count] - 1)
                    height += distanceBetweenSubView;
            }
            
            delta = self.frame.size.height/2 - height/2;
         
            for (int i = 0; i < [self.subviews count]; i++)
            {
                frame = [[self.subviews objectAtIndex:i] frame];
                frame.origin.y = delta;
                delta += frame.size.height + distanceBetweenSubView;
                [[self.subviews objectAtIndex:i] setFrame:frame];
            }
        }
        else if (aAlignment & halfCellAlignmentBottom)
        {
            for (int i = [self.subviews count] - 1; i >= 0; i--)
            {
                frame = [[self.subviews objectAtIndex:i] frame];
                if (i + 1 < [self.subviews count])
                    frame.origin.y = [[self.subviews objectAtIndex:i + 1] frame].origin.y - distanceBetweenSubView - frame.size.height;
                else
                    frame.origin.y = self.frame.size.height - padding.bottomPadding - frame.size.height;
                
                [[self.subviews objectAtIndex:i] setFrame:frame];
            }
        }
    }
}

//==============================================================================
- (void)dealloc
{
    [super dealloc];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
