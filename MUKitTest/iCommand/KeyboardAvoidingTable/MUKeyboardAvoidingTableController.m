//
//  MUKeyboardAvoidingTableController.m
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUKeyboardAvoidingTableController.h"
#import "MUTextField.h"
#import "MUValidator.h"
#import "MUValidationGroup.h"
#import "MUKeyboardAvoidingTableView.h"
#import "MUCreditCardNumberFormatter.h"
#import "MUPhoneNumberFormatter.h"

#define tag_card_number_text_field  100
#define tag_phone_number_text_field 101

@interface MUKeyboardAvoidingTableController ()

- (MUTextField *)createTextField;
- (UITableViewCell *)createTableViewCell;

@end

@implementation MUKeyboardAvoidingTableController

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
@synthesize tf_11;
@synthesize tf_12;

//==============================================================================
- (id)init
{
    self = [super initWithNibName:@"MUKeyboardAvoidingTableController" bundle:nil];
    if (self) 
    {
        self.title = @"TableView";
        creditCardNumberFormatter = [MUCreditCardNumberFormatter new];
        phoneNumberFormatter = [MUPhoneNumberFormatter new];
    }
    return self;
}

//==============================================================================
- (void)dealloc 
{
    [creditCardNumberFormatter release];
    [phoneNumberFormatter release];
    
    [tableViewCells release];
    [validationGroup release];
    [tableView release];
    [tf_01 release];
    [tf_02 release];
    [tf_03 release];
    [tf_04 release];
    [tf_05 release];
    [tf_06 release];
    [tf_07 release];
    [tf_08 release];
    [tf_09 release];
    [tf_10 release];
    [tf_11 release];
    [tf_12 release];
    
    [super dealloc];
}

#pragma mark - View lifecycle
//==============================================================================
- (void)viewDidLoad
{
    NSMutableArray *sectionFirst = [NSMutableArray array];
    NSMutableArray *sectionSecond = [NSMutableArray array];
    NSMutableArray *sectionThit = [NSMutableArray array];
    tableViewCells = [[NSMutableArray alloc] initWithObjects:sectionFirst, sectionSecond, sectionThit, nil];
    
    // create cells and textfields
    UITableViewCell *cell = nil;
 
    tf_01 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_01];
    [sectionFirst addObject:cell];
    
    tf_02 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_02];
    [sectionFirst addObject:cell];
    
    tf_03 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_03];
    [sectionFirst addObject:cell];
    
    tf_04 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_04];
    [sectionFirst addObject:cell];
    
    tf_05 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_05];
    [sectionFirst addObject:cell];
    
    tf_06 = [[self createTextField] retain];    
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_06];
    [sectionSecond addObject:cell];
    
    tf_07 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_07];
    [sectionSecond addObject:cell];
    
    tf_08 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_08];
    [sectionSecond addObject:cell];
    
    tf_09 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_09];
    [sectionSecond addObject:cell];
    
    tf_10 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_10];
    [sectionSecond addObject:cell];
    
    tf_11 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_11];
    [sectionThit addObject:cell];
    
    tf_12 = [[self createTextField] retain];
    cell = [self createTableViewCell];
    [cell.contentView addSubview:tf_12];
    [sectionThit addObject:cell];

    // create vaidators
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
    
//    validator = [[[MUValidatorIntWithRange alloc] initWithRange:NSMakeRange(10, 5)] autorelease];
    validator = [[[MUValidatorStringWithRange alloc] init] autorelease];
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
    
    validator = [[[MUValidatorStringWithRange alloc] initWithRange:NSMakeRange(5,5)] autorelease];
    validator.errorMessage = @"Word len 5~10";
    tf_10.placeholder = @"Enter Word";
    tf_10.validator = validator;
    
    validator = [[[MUValidatorIntWithRange alloc] initWithRange:NSMakeRange(16, 4)] autorelease];
    validator.errorMessage = @"Incorrect Card Number!!!";
    tf_11.placeholder = @"Enter Card Number";
    tf_11.validator = validator;
    tf_11.tag = tag_card_number_text_field;
    
    validator = [[[MUValidatorCountNumberInTextWithRange alloc] initWithRange:NSMakeRange(7, 4)] autorelease];
    validator.errorMessage = @"Incorrect Phone Number!!!";
    tf_12.placeholder = @"Enter Phone Number";
    tf_12.validator = validator;
    tf_12.tag = tag_phone_number_text_field;
    
    [((MUKeyboardAvoidingTableView*)tableView) addObjectsForKeyboard:[NSArray arrayWithObjects:tf_01, tf_02, tf_03, tf_04, tf_05, tf_06, tf_07, tf_08, tf_09, tf_10, tf_11, tf_12, nil]];
    validationGroup = [[MUValidationGroup alloc] initWithTextFields:[NSArray arrayWithObjects:tf_01, tf_02, tf_03, tf_04, tf_05, tf_06, tf_07, tf_08, tf_09, tf_10, tf_11, tf_12, nil]];
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

    [tableViewCells release];
    tableViewCells = nil;
    
    [super viewDidUnload];
}

//==============================================================================
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Navigation Button
//==============================================================================
- (UIBarButtonItem*)createRightNavButton
{
    return [[[UIBarButtonItem alloc] initWithTitle:@"Validation" style:UIBarButtonItemStyleDone target:nil action:nil] autorelease];
}

#pragma mark - Private Method
//==============================================================================
- (MUTextField *)createTextField
{
    MUTextField *textField = [[[MUTextField alloc] initWithFrame:CGRectMake(10, 0, 300, 40)] autorelease];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.autoresizesSubviews = YES;
    textField.delegate = self;
    return textField;
}

//==============================================================================
- (UITableViewCell *)createTableViewCell
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.autoresizesSubviews = YES;
    return cell;
}

#pragma mark - Button Action
//==============================================================================
- (void)rightNavButtonPressed:(id)aSender
{
    [((MUKeyboardAvoidingTableView*)tableView) hideKeyBoard];
    
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

#pragma mark - UITableViewDataSource
//==============================================================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tableViewCells count];
}

//==============================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tableViewCells objectAtIndex:section] count];
}

//==============================================================================
-(UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[tableViewCells objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

#pragma mark - UITextFieldDelegate
//==============================================================================
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [((MUKeyboardAvoidingTableView*)tableView) adjustOffset];
}

//==============================================================================
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [((MUKeyboardAvoidingTableView*)tableView) responderShouldReturn:textField];
    return YES;
}

//==============================================================================
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    if (textField.tag == tag_card_number_text_field)
    {
        result = [creditCardNumberFormatter cardFormatForTextField:textField shouldChangeCharactersInRange:range replacementString:string separatorString:@" "];
    }
    else if (textField.tag == tag_phone_number_text_field)
    {
        result = [phoneNumberFormatter phoneFormatForTextField:textField shouldChangeCharactersInRange:range replacementString:string withLocale:@"us"];
    }
    return result;
}

@end
