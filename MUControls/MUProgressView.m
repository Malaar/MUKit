//
//  MUProgressView.m
//  MUFtpReqest
//
//  Created by Yuriy Bosov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MUProgressView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MUProgressView

//==============================================================================
@synthesize cornerRadius, progress;

#pragma mark - Init/Dealloc
//==============================================================================
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) 
    {
        [self setup];
    }
    return self;
}

//==============================================================================
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

//==============================================================================
- (void) setup
{
    self.backgroundColor = [UIColor clearColor];
    
    trackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    trackView.contentMode = UIViewContentModeScaleAspectFill;
    trackView.clipsToBounds = YES;
    trackView.backgroundColor = [UIColor clearColor];
    trackView.image = [self trackImage];
    [self addSubview:trackView];
    
    progressView = [[UIImageView alloc] initWithFrame:CGRectMake([self offsetProgressView], 
                                                                 [self offsetProgressView], 
                                                                 0, 
                                                                 self.frame.size.height - [self offsetProgressView])];
    progressView.contentMode = UIViewContentModeScaleAspectFill;
    progressView.clipsToBounds = YES;
    progressView.backgroundColor = [self progressColor];
    progressView.image = [self progressImage];
    [self addSubview:progressView];
}

//==============================================================================
- (void) dealloc
{
    [progressView release];
    [trackView release];
    [super dealloc];
}

//==============================================================================
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.borderWidth = [self borderWidth];
    self.layer.borderColor = [self borderColor];
}

#pragma mark - use of the derived-class
//==============================================================================
- (float)borderWidth
{
    return 1;
}

//==============================================================================
- (CGColorRef)borderColor
{
    return [[UIColor lightGrayColor] CGColor];
}

//==============================================================================
- (float)offsetProgressView
{
    return 1.f;
}

//==============================================================================
- (UIColor *)progressColor
{
    return [UIColor clearColor];
}

//==============================================================================
- (UIImage *)progressImage
{
    return nil;
}

//==============================================================================
- (UIImage *)trackImage
{
    return nil;
}

#pragma mark - Setter Methods
//==============================================================================
- (void) setProgressColor:(UIColor *)progressColor
{
    progressView.backgroundColor = progressColor;
}

//==============================================================================
- (void)setProgressImage:(UIImage *)progressImage
{
    progressView.image = progressImage;
}

//==============================================================================
- (void)setTrackImage:(UIImage *)trackImage
{
    trackView.image = trackImage;
}

//==============================================================================
- (void)setCornerRadius:(float)aCornerRadius
{
    cornerRadius = aCornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    progressView.layer.cornerRadius = cornerRadius;
    trackView.layer.cornerRadius = cornerRadius;
}

//==============================================================================
- (void) setProgress:(float)aProgress
{
    [self setProgress:aProgress animated:NO];
}

//==============================================================================
- (void) setProgress:(float)aProgress animated:(BOOL)animated
{
    progress = aProgress;
    CGRect frame = CGRectMake([self offsetProgressView], 
                              [self offsetProgressView], 
                              0, 
                              self.frame.size.height - 2*[self offsetProgressView]);
    
    if (progress >= 1.f)
    {
        progress = 1.f;    
        frame.size.width = self.frame.size.width - 2*[self offsetProgressView];
    }
    else if (progress > 0.f && progress < 1.f) 
    {
        frame.size.width = (self.frame.size.width - 2*[self offsetProgressView]) * progress;
    }

    [UIView animateWithDuration:(animated)?(0.3):(0) animations:^
    {
        progressView.frame = frame;
    }];
}

@end
