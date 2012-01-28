//
//  MUTextFieldGoup.m
//  ROM
//
//  Created by Malaar on 10.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUValidationGroup.h"
#import "MUValidator.h"
#import "MUTextField.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUValidationGroup (Private)

- (void) showInvalidViewForField:(UITextField*)aTextField;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidationGroup

@synthesize invalidIndicatorImage;

#pragma mark - init/dealloc
//==============================================================================
- (id) init
{
	NSAssert(NO, @"Can't use this method !!!");	[self release];
	return nil;
}

//==============================================================================
- (id) initWithTextFields:(NSArray*)aTextFields
{
	if( (self = [super init]) )
	{
		textFields = [aTextFields copy];
    }
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[textFields release];
    [invalidIndicatorImage release];
	
	[super dealloc];
}

#pragma mark - validation
//==============================================================================
- (NSArray*) validateFields
{
    NSMutableArray* result = [NSMutableArray array];
    
    [self hideInvalidIndicators];
    
    // ...
    for(id<MUValidationProtocol> object in textFields)
    {
        if( [object conformsToProtocol:@protocol(MUValidationProtocol)] )
        {
            if( ![object validate] )
            {
                [result addObject:object];
                if ([object isKindOfClass:[MUTextField class]])
                    [self showInvalidViewForField:(MUTextField*)object];
            }
        }
    }
    
    return result;
}

//==============================================================================
- (void) showInvalidViewForField:(UITextField*)aTextField
{
    aTextField.rightView = [[[UIImageView alloc] initWithImage: invalidIndicatorImage] autorelease];
    aTextField.rightViewMode = UITextFieldViewModeAlways;
}

//==============================================================================
- (void) hideInvalidIndicators
{
    for(id<MUValidationProtocol> object in textFields)
    {
        if( [object isKindOfClass:[MUTextField class]] )
            [(MUTextField*)object setRightView:nil];
    }
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
