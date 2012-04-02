//
//  MUEntryCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@interface MUCellDataTextField : MUCellDataMaped

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIFont *titleFont;

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIFont *textFont;
@property(nonatomic, assign) BOOL textSecured;                                 ///< default is NO

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@property(nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;   ///< default is UITextAutocapitalizationTypeSentences
@property(nonatomic, assign) UITextAutocorrectionType autocorrectionType;           ///< default is UITextAutocorrectionTypeDefault
@property(nonatomic, assign) UIKeyboardType keyboardType;                           ///< default is UIKeyboardTypeDefault
@property(nonatomic, assign) UIKeyboardAppearance keyboardAppearance;               ///< default is UIKeyboardAppearanceDefault
@property(nonatomic, assign) UIReturnKeyType returnKeyType;                         ///< default is UIReturnKeyDefault

@end
