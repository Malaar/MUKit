//
//  MUKeyboardAvoidingScrollController.m
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUKeyboardAvoidingScrollController.h"
#import "MUKeyboardAvoidingScrollView.h"
#import "MUTextField.h"
#import "MUValidator.h"
#import "MUValidationGroup.h"

@implementation MUKeyboardAvoidingScrollController

@synthesize tf_01;
@synthesize tf_02;
@synthesize tf_03;
@synthesize tf_04;
@synthesize tf_05;
@synthesize tf_06;
@synthesize tf_07;
@synthesize tf_08;
@synthesize tf_09;
@synthesize tf_10;

#pragma mark - Init/Dealloc
//==============================================================================
- (id)init
{
    self = [super initWithNibName:@"MUKeyboardAvoidingScrollController" bundle:nil];
    if (self) 
    {
        self.title = @"ScrollView";
    }
    return self;
}

//==============================================================================
- (void)dealloc 
{
    [tf_01 release];
    [tf_02 release];
    [tf_03 release];
    [tf_04 release];
    [tf_05 release];
    [tf_06 release];
    [tf_07 release];
    [tf_08 release];
//    [scrollView release];
    [validationGroup release];
    [tf_09 release];
    [tf_10 release];
    [super dealloc];
}

#pragma mark - View lifecycle
//==============================================================================
- (void)viewDidLoad
{    
    MUValidator *validator = [[[MUValidatorNotEmpty alloc] init] autorelease];
    validator.errorMessage = @"TextField not Empty";
    tf_01.placeholder = @"Not Empty";
    tf_01.validator = validator;
    
    validator = [[[MUValidatorEmail alloc] init] autorelease];
    validator.errorMessage = @"Incorrect Email";
    tf_02.placeholder = @"Email";
    tf_02.validator = validator;
    
    validator = [[[MUValidatorEqual alloc] initWithTestedField:tf_02] autorelease];
    validator.errorMessage = @"Not Confirmation Email";
    tf_03.placeholder = @"Confirmation Email";
    tf_03.validator = validator;
    
    validator = [[[MUValidatorFullName alloc] init] autorelease];
    validator.errorMessage = @"Incorrect Full Name";
    tf_04.placeholder = @"Full Name";
    tf_04.validator = validator;
    
    validator = [[[MUValidatorIntWithRange alloc] initWithRange:NSMakeRange(10, 5)] autorelease];
    validator.errorMessage = @"Incorrect Code";
    tf_05.placeholder = @"Enter Code (10~15 symbol)";
    tf_05.validator = validator;
    
    validator = [[[MUValidatorLetters alloc] init] autorelease];
    validator.errorMessage = @"Letters!!!";
    tf_06.placeholder = @"Enter Letters";
    tf_06.validator = validator;
    
    validator = [[[MUValidatorNumber alloc] init] autorelease];
    validator.errorMessage = @"Number!!!";
    tf_07.placeholder = @"Enter Number";
    tf_07.validator = validator;
    
    validator = [[[MUValidatorURL alloc] init] autorelease];
    validator.errorMessage = @"Incorrect URL";
    tf_08.placeholder = @"Enter URL";
    tf_08.validator = validator;
    
    validator = [[[MUValidatorUSAZipCode alloc] init] autorelease];
    validator.errorMessage = @"Incorrect Zip Code";
    tf_09.placeholder = @"Enter Zipc Code";
    tf_09.validator = validator;
    
    validator = [[[MUValidatorWords alloc] init] autorelease];
    validator.errorMessage = @"Words!!!";
    tf_10.placeholder = @"Enter Words";
    tf_10.validator = validator;
    
    [((MUKeyboardAvoidingScrollView*)scrollView) addObjectsForKeyboard:[NSArray arrayWithObjects:tf_01, tf_02, tf_03, tf_04, tf_05, tf_06, tf_07, tf_08, tf_09, tf_10, nil]];
    validationGroup = [[MUValidationGroup alloc] initWithTextFields:[NSArray arrayWithObjects:tf_01, tf_02, tf_03, tf_04, tf_05, tf_06, tf_07, tf_08, tf_09, tf_10, nil]];
    validationGroup.invalidIndicatorImage = [UIImage imageNamed:@"warning_icon"];
    [super viewDidLoad];
}

//==============================================================================
- (void)viewDidUnload
{
    [self setTf_01:nil];
    [self setTf_02:nil];
    [self setTf_03:nil];
    [self setTf_04:nil];
    [self setTf_05:nil];
    [self setTf_06:nil];
    [self setTf_07:nil];
    [self setTf_08:nil];
    
    [validationGroup release];
    validationGroup = nil;
    
    [self setTf_09:nil];
    [self setTf_10:nil];
    [super viewDidUnload];
}

//==============================================================================
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - Navigation Button
//==============================================================================
- (UIBarButtonItem*)createRightNavButton
{
    return [[[UIBarButtonItem alloc] initWithTitle:@"Validation" style:UIBarButtonItemStyleDone target:nil action:nil] autorelease];
}

#pragma mark - Button Action
//==============================================================================
- (void)rightNavButtonPressed:(id)aSender
{
    [((MUKeyboardAvoidingScrollView*)scrollView) hideKeyBoard];
    
    NSString *alertTitle = nil;
    NSString *alertText = nil;
    
    NSArray *errorFields = [validationGroup validateFields];
    if ([errorFields count] > 0) 
    {
        id<MUValidationProtocol> obj = [errorFields objectAtIndex:0];
        alertText = [obj validator].errorMessage;
        alertTitle = @"Error";
    }
    else
    {
        alertText = @"Validation Success";
    }
    
    [self showAlertViewWithTitle:alertTitle message:alertText delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
}

#pragma mark - UITextFieldDelegate
//==============================================================================
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [((MUKeyboardAvoidingScrollView*)scrollView) adjustOffset];
}

//==============================================================================
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [((MUKeyboardAvoidingScrollView*)scrollView) responderShouldReturn:textField];
    return YES;
}

@end
