//
//  MUTabBar.h
//  ROM
//
//  Created by Malaar on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==============================================================================
//==============================================================================
//==============================================================================
///
@interface MUToolbar : UIToolbar
{
    UIImage* bgImage;
    BOOL drawColor;
}

@property (nonatomic, retain) UIImage* backgroundImage;
@property (nonatomic, assign) BOOL drawColor;


@end
