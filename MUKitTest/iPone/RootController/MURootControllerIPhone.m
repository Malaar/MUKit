//
//  MUViewControllerIPhone.m
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MURootControllerIPhone.h"
#import "MUKit.h"
#import "MUKeyboardAvoidingScrollController.h"
#import "MUKeyboardAvoidingTableController.h"
#import "HalfCellTestController.h"
#import "TableViewWithMapedCells.h"
#import "MUSwitchController.h"

@implementation MURootControllerIPhone
@synthesize ivTapable;

//==============================================================================
- (id)init
{
    self = [super initWithNibName:@"MURootControllerIPhone" bundle:nil];
    if (self) 
    {
        self.title = @"Root";
    }
    return self;
}

//==============================================================================
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//==============================================================================
- (void)loadView
{
    [super loadView];
}

//==============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ivTapable addTarget:self action:@selector(imageTapped:)];
    NSURL* imgURL = [NSURL URLWithString:@"http://d1xzuxjlafny7l.cloudfront.net/wp-content/uploads/2011/03/MapsSmall.jpg"];
    [ivTapable setImageWithURL:imgURL];
}

//==============================================================================
- (void)viewDidUnload
{
    [self setIvTapable:nil];
    [super viewDidUnload];
}

//==============================================================================
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Button Action
//==============================================================================
- (IBAction)showKeyboardAvoidingScrollView:(id)sender 
{
    MUKeyboardAvoidingScrollController *vc = [[MUKeyboardAvoidingScrollController new] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}

//==============================================================================
- (IBAction)showKeyboardAvoidingTableView:(id)sender 
{
    MUKeyboardAvoidingTableController *vc = [[MUKeyboardAvoidingTableController new] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}

//==============================================================================
- (IBAction)showHalfCellTestController:(id)sender 
{
    HalfCellTestController *vc = [[HalfCellTestController new] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}

//==============================================================================
- (IBAction)showTableDisposerController:(id)sender
{
    TableViewWithMapedCells *vc = [[TableViewWithMapedCells new] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}

//==============================================================================
- (IBAction)switchController:(id)sender
{
    MUSwitchController* switchController = (MUSwitchController*)MUGetPrimeViewController();

    TableViewWithMapedCells *vc = [[TableViewWithMapedCells new] autorelease];
    UINavigationController* nc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [switchController switchToController:nc];
    NSLog(@"Switch Pressed");
}

//==============================================================================
- (void)dealloc
{
    [ivTapable release];

    [super dealloc];
}

//==============================================================================
- (void) imageTapped:(UIImage*)anImage
{
    MUShowSimpleAlert(@"Image Tapable", @"image taped!");
}

@end
