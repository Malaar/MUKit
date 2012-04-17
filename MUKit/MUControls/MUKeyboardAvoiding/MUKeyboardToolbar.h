//
//  MUKeyboardToolbar.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUToolbar.h"

@protocol MUKeyboardToolbarProtocol <NSObject>

- (void) didNextButtonPressd;
- (void) didPrevButtonPressd;
- (void) didDoneButtonPressd;

@end

@interface MUKeyboardToolbar : MUToolbar
{
    UISegmentedControl *segmentedPreviousNext;
    UIBarButtonItem *doneButton;
    id<MUKeyboardToolbarProtocol> delegate;
}

@property (nonatomic, retain) NSString *previousTitle;
@property (nonatomic, retain) NSString *nextTitle;
@property (nonatomic, assign) id<MUKeyboardToolbarProtocol> delegate;

@property (nonatomic, readonly) UIBarButtonItem *doneButton;

- (void) selectedInputFieldIndex:(NSInteger)selectInsex allCountInputFields:(NSInteger)allCountInputFields;

@end
