//
//  TableViewWithMapedCells.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewWithMapedCells.h"
#import "MUSectionWritable.h"

#import "MUKeyboardAvoidingTableView.h"

#import "MUCellDataSwitch.h"
#import "MUCellDataTextField.h"
#import "MUCellDataLabel.h"
#import "MUCellDataStandart.h"
#import "MUCellDataButton.h"
#import "MUCellDataTextView.h"

@interface MUTestObject : NSObject

@property (nonatomic, retain) NSString* strValue;

@end

@implementation MUTestObject

@synthesize strValue;

- (void) dealloc
{
    [strValue release];
    
    [super dealloc];
}

@end

@interface TableViewWithMapedCells ()

- (void) cellButtonPressed;
- (void) switcheDidChengeValue:(UISwitch *)sender;

@end


@implementation TableViewWithMapedCells

//==============================================================================
- (id)init
{
    self = [super init];
    if (self) 
    {
        self.title = @"TEST";
        tableDisposer = [[MUTableDisposerMaped alloc] init];
        tableDisposer.tableStyle = UITableViewStyleGrouped;
        tableDisposer.tableClass = [MUKeyboardAvoidingTableView class];
        tableDisposer.delegate = self;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [tableDisposer release];
    [validationGroup release];
    [super dealloc];
}

#pragma mark - View lifecycle
//==============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview: tableDisposer.tableView];
    tableDisposer.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // new section
    MUSectionWritable *section = [[[MUSectionWritable alloc] init] autorelease];
    section.headerTitle = @"Section title";    
    section.footerTitle = @"footerTitle";
    [tableDisposer addSection:section];
    
    MUCellDataTextField *cellDataTextField = [[[MUCellDataTextField alloc] initWithObject:nil key:nil] autorelease];
    cellDataTextField.text = @"MUCellDataTextField";
    cellDataTextField.title = @"Text";
    cellDataTextField.placeholder = @"please enter text";
    MUValidator *validatorNotEmpty = [[MUValidatorNotEmpty new] autorelease];;
    cellDataTextField.validator = validatorNotEmpty;
    [section addCellData: cellDataTextField];
    
    cellDataTextField = [[[MUCellDataTextField alloc] initWithObject:nil key:nil] autorelease];
    cellDataTextField.text = @"MUCellDataTextField";
    cellDataTextField.placeholder = @"please enter text";
    [section addCellData: cellDataTextField];
    
    MUTestObject* testObject = [MUTestObject new];
    testObject.strValue = @"string value";

    MUCellDataTextView* cdTextView = [[MUCellDataTextView alloc] initWithObject:testObject key:@"strValue"];
    cdTextView.title = @"Title";
//    cdTextView.enableEdit = NO;
    [section addCellData:cdTextView];
    
    MUCellDataSwitch *cellDataSwitch = [[[MUCellDataSwitch alloc] initWithObject:nil key:nil] autorelease];
    cellDataSwitch.title = @"Switch";
    cellDataSwitch.boolValue = YES;
    [section addCellData:cellDataSwitch];
    
    cellDataSwitch = [[[MUCellDataSwitch alloc] initWithObject:nil key:nil] autorelease];
    cellDataSwitch.subtitle = @"Switch";
    cellDataSwitch.boolValue = NO;
    cellDataSwitch.title = @"Switch";
    cellDataSwitch.onText = @"Y!!!";
    cellDataSwitch.offText = @"N!!!";
    cellDataSwitch.titleColor = [UIColor blueColor];
    cellDataSwitch.titleTextAlignment = UITextAlignmentCenter;
    cellDataSwitch.titleFont = [UIFont systemFontOfSize:15];
    [cellDataSwitch setTarget:self action:@selector(switcheDidChengeValue:)];
    [section addCellData:cellDataSwitch];
    
    // new section
    section = [[[MUSectionWritable alloc] init] autorelease];
    section.headerTitle = @"Section title";    
    section.footerTitle = @"footerTitle";
    [tableDisposer addSection:section];
    
    cellDataSwitch = [[[MUCellDataSwitch alloc] initWithObject:nil key:nil] autorelease];
    cellDataSwitch.title = @"Switch";
    cellDataSwitch.titleColor = [UIColor grayColor];
    cellDataSwitch.titleFont = [UIFont systemFontOfSize:16];
    cellDataSwitch.boolValue = YES;
    [section addCellData:cellDataSwitch];

    
    // new section
    section = [[[MUSectionWritable alloc] init] autorelease];
    section.headerTitle = @"Section title";    
    section.footerTitle = @"footerTitle";    
    [tableDisposer addSection:section];
    
    MUCellDataButton *button = [[[MUCellDataButton alloc] init] autorelease];
    button.title = @"Cell Button";
    button.titleAlignment = UITextAlignmentCenter;
    button.titleFont = [UIFont italicSystemFontOfSize:18];
    button.cellSelectionStyle = UITableViewCellSelectionStyleGray;
    button.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [button setTarget:self action:@selector(cellButtonPressed)];
    [section addCellData:button];
    
    [tableDisposer mapFromObject];
    validationGroup = [[MUValidationGroup alloc] initWithValidators:[NSArray arrayWithObjects:validatorNotEmpty, nil]];
    validationGroup.invalidIndicatorImage = [UIImage imageNamed:@"warning_icon"];
}

//==============================================================================
- (void)viewDidUnload
{
    [validationGroup release];
    [tableDisposer releaseView];
    [super viewDidUnload];
}

//==============================================================================
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    tableDisposer.tableView.frame = self.view.bounds;
}

//==============================================================================
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

//==============================================================================
- (UIBarButtonItem *)createRightNavButton
{
    return [[[UIBarButtonItem alloc] initWithTitle:@"Validate" style:UIBarButtonItemStyleDone target:nil action:nil] autorelease];
}

//==============================================================================
- (void) rightNavButtonPressed:(id)aSender
{
    [validationGroup validate];
}

#pragma mark - Private Methods
//==============================================================================
- (void) cellButtonPressed
{
    NSLog(@"cellButtonPressed");
}

//==============================================================================
- (void) switcheDidChengeValue:(UISwitch *)sender
{
    NSLog(@"switcheDidChengeValue %d", sender.on);
}

@end








