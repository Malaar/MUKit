//
//  MUProgressView.h
//  MUKit
//
//  Created by Yuriy Bosov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUProgressView : UIView
{
    UIImageView *progressView;
    UIImageView *trackView;
}

@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, assign) float progress;

- (void) setup;
- (void) setProgressColor:(UIColor *)progressColor;
- (void) setProgressImage:(UIImage *)progressImage;
- (void) setTrackImage:(UIImage *)trackImage;
- (void) setProgress:(float)progress animated:(BOOL)animated;

//use of the derived-class
- (float)borderWidth;
- (CGColorRef)borderColor;
- (float)offsetProgressView;
- (UIColor *)progressColor;
- (UIImage *)progressImage;
- (UIImage *)trackImage;

@end
