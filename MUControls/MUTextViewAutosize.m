//
//  MUTextViewAutosize.m
//  TimeLink
//
//  Created by Malaar on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTextViewAutosize.h"

@implementation MUTextViewAutosize

//==============================================================================
- (void) setText:(NSString *)aText
{
    [super setText:aText];
    [self adjustSizeToContent];
}

//==============================================================================
- (void) adjustSizeToContent
{
    CGRect frame = self.frame;
    frame.size.height = self.contentSize.height;
    self.frame = frame;
}

@end
