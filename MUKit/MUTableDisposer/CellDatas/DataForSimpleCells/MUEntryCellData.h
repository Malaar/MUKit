//
//  MUEntryCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataStandart.h"

@interface MUEntryCellData : MUCellDataStandart
{
    NSString *placeholder;
    NSString *textValue;
}

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) NSString *textValue;

@property(nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;   // default is UITextAutocapitalizationTypeSentences
@property(nonatomic, assign) UITextAutocorrectionType autocorrectionType;           // default is UITextAutocorrectionTypeDefault
@property(nonatomic, assign) UIKeyboardType keyboardType;                           // default is UIKeyboardTypeDefault
@property(nonatomic, assign) UIKeyboardAppearance keyboardAppearance;               // default is UIKeyboardAppearanceDefault
@property(nonatomic, assign) UIReturnKeyType returnKeyType;                         // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property(nonatomic, assign) BOOL secureTextEntry;                                  // default is NO

//- (MUEntryCellData *)initWithTitle:(NSString *)string Value:(NSString *)param Placeholder:(NSString *)string;

@end
