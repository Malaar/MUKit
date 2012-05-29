//
//  MUCellDataTextView.h
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextPair.h"
#import "MUValidator.h"
#import "MUFilter.h"


@interface MUCellDataTextView : MUCellDataTextPair

@property (nonatomic, assign) UITextAlignment textAlignment;

@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;   ///< default is UITextAutocapitalizationTypeSentences
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;           ///< default is UITextAutocorrectionTypeDefault
@property (nonatomic, assign) UIKeyboardType keyboardType;                           ///< default is UIKeyboardTypeDefault
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;               ///< default is UIKeyboardAppearanceDefault
@property (nonatomic, assign) UIReturnKeyType returnKeyType;                         ///< default is UIReturnKeyDefault

@property (nonatomic, retain) MUValidator *validator;
@property (nonatomic, retain) MUFilter *filter;

@end
