//
//  MUHelper.m
//  Pro-Otdyh
//
//  Created by Malaar on 24.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUHelper.h"
#import "MUKitDefines.h"


//==============================================================================
UIViewController* MUGetPrimeViewController()
{
    UIViewController* result = nil;
    UIView* baseView = (UIView*)[UIApplication sharedApplication].keyWindow;
    if([baseView.subviews count] > 0)
    {
        baseView = [baseView.subviews objectAtIndex:0];
        result = [baseView firstAvailableUIViewController];
    }
    return result;
}

//==============================================================================
void MUShowSimpleAlert(NSString* aTitle, NSString* aMessage)
{
    [[[[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
}

//==============================================================================
NSMutableArray* MUDivideArray(NSArray* aDividedArray, NSString* aFieldName, BOOL anAscending, MUDividedComparator aComparator)
{
	NSMutableArray* result = [NSMutableArray array];
	// sort
	NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:aFieldName ascending:anAscending];
	NSArray* sortedBOs = [aDividedArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	
	// divide by year,month,date
	NSMutableArray* sectionElements = nil;
	id obj1;
	id obj2;
	for(NSObject* bo in sortedBOs)
	{
		obj1 = [[sectionElements lastObject] valueForKeyPath:aFieldName];
		obj2 = [bo valueForKeyPath:aFieldName];
		if(obj2)
		{
			if(aComparator(obj1, obj2))
				[sectionElements addObject:bo];
			else
			{
				if(sectionElements)
					[result addObject:sectionElements];
				sectionElements = [NSMutableArray arrayWithObject:bo];
			}
		}
	}
	if(sectionElements)
		[result addObject:sectionElements];
	
	return result;
}

//==============================================================================
NSDate* MUDateFromTimeStampInDictionary(NSDictionary* aDictionary, NSString* aKey)
{
    NSTimeInterval timestamp = [MU_NULL_PROTECT( [aDictionary objectForKey:aKey] ) doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

//==============================================================================
NSString* MUGenerateUUID()
{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString* uuid = (NSString*)CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    return uuid;
}

//==============================================================================
NSString* MUDocumentDirecoryPath()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

//==============================================================================
void MUHideWebViewShadows(UIWebView* webView)
{
    for (UIView* subView in [webView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]])
        {
            for (UIView* shadowView in [subView subviews])
            {
                if ([shadowView isKindOfClass:[UIImageView class]])
                {
                    [shadowView setHidden:YES];
                }
            }
        }
    }
}
