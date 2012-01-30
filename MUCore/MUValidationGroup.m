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
@synthesize delegate;

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
    [self hideInvalidIndicators];
    NSMutableArray* result = [NSMutableArray array];    
    NSMutableArray* validationResults = [NSMutableArray array];
    
    for(id<MUValidationProtocol> object in textFields)
    {
        if( [object conformsToProtocol:@protocol(MUValidationProtocol)] )
        {
            [validationResults addObject: [NSNumber numberWithBool:[object validate]]];
        }
    }
    
    // to castom proccess any links between validatable vields
    if(delegate)
    {
        [delegate proccessValidationResults:validationResults];
    }    
    
    if ([textFields count] == [validationResults count]) 
    {
        id<MUValidationProtocol> object = nil;
        for(int i = 0; i < [validationResults count]; ++i)
        {
            if( ![[validationResults objectAtIndex:i] boolValue] )
            {
                object = [textFields objectAtIndex:i];
                [result addObject:object];
                if ([object isKindOfClass:[UITextField class]])
                {
                    [self showInvalidViewForField:(UITextField*)object];
                }
            }
        }
    }
    else
    {
        NSAssert(nil, @"MUKit(MUValidationGroup): [textFields count] != [validationResults count]");
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
        if( [object isKindOfClass:[UITextField class]] )
            [(UITextField*)object setRightView:nil];
    }
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
