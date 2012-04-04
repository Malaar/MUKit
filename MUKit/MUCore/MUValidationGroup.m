//
//  MUTextFieldGoup.m
//  MUKit
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
- (id) initWithValidators:(NSArray *)aValidators
{
	if( (self = [super init]) )
	{
		validators = [aValidators copy];
    }
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[validators release];
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
    
    for (MUValidator *validator in validators)
    {
        [validationResults addObject: [NSNumber numberWithBool:[validator validate]]];
    }
    
    // to castom proccess any links between validatable vields
    if(delegate)
    {
        [delegate proccessValidationResults:validationResults];
    }    
    
    if ([validators count] == [validationResults count]) 
    {
        MUValidator *validator = nil;
        for(int i = 0; i < [validationResults count]; ++i)
        {
            validator = [validators objectAtIndex:i];
            if( ![[validationResults objectAtIndex:i] boolValue] )
            {
                [result addObject:validator.validatableObject];
                if ([validator.validatableObject isKindOfClass:[UITextField class]])
                {
                    [self showInvalidViewForField:(UITextField*)validator.validatableObject];
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
    for(MUValidator *object in validators)
    {
        if( [object.validatableObject isKindOfClass:[UITextField class]] )
            [(UITextField*)object.validatableObject setRightView:nil];
    }
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
