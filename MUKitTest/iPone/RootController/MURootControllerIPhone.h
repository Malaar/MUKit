//
//  MUViewControllerIPhone.h
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUImageViewTapable.h"

@interface MURootControllerIPhone : UIViewController

@property (retain, nonatomic) IBOutlet MUImageViewTapable *ivTapable;

- (IBAction)showKeyboardAvoidingScrollView:(id)sender;
- (IBAction)showKeyboardAvoidingTableView:(id)sender;
- (IBAction)showHalfCellTestController:(id)sender;

@end
