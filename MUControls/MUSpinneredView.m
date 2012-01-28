//
//  MYSpinnered.m
//  LastDay
//
//  Created by yuriy on 29.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUSpinneredView.h"


@implementation MUSpinneredView

//==========================================================================================
- (id) initWithParentView: (UIView*)aParentView color:(UIColor*)aColor
{
	if((self = [super init]) && aParentView)
	{
		parentView = aParentView;
		// overlay
		self.backgroundColor = aColor;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//		self.alpha = 0.5;
		// spinner
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		spinner.center = self.center;
        spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		[self addSubview:spinner];
	}
	return self;
}

//==========================================================================================
- (void) dealloc
{
	[self removeFromSuperview];
	[spinner release];
	
	[super dealloc];
}

//==========================================================================================
- (void) show
{
	if(!isShow)
	{
		self.frame = parentView.bounds;
		[parentView addSubview:self];
		[spinner startAnimating];
		isShow = YES;
	}
}

//==========================================================================================
- (void) hide
{
	if(isShow)
	{
		[spinner stopAnimating];
		[self removeFromSuperview];
		isShow = NO;
	}
}

//==========================================================================================
//==========================================================================================
//==========================================================================================

@end
