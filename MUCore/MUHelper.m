//
//  MUHelper.m
//  Pro-Otdyh
//
//  Created by Malaar on 24.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUHelper.h"

//==============================================================================
UIViewController* MUGetPrimeViewController()
{
    UIViewController* result;
    UIView* baseView = (UIView*)[UIApplication sharedApplication].keyWindow;
    if([baseView.subviews count] > 0)
    {
        baseView = [baseView.subviews objectAtIndex:0];
        result = [baseView firstAvailableUIViewController];
    }
    return result;
}