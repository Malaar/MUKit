//
//  MUTextView.h
//  MUKit
//
//  Created by Yuriy Bosov on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUValidator.h"
#import "MUKeyboardAvoiderProtocol.h"
#import "MUFilter.h"

@class MUTextView_Holder;

@interface MUTextView : UITextView <MUValidationProtocol, UITextViewDelegate, MUKeyboardAvoiderProtocol>
{
    MUValidator* validator;
    MUTextView_Holder* delegateHolder;
    MUFilter *filter;
    
    NSString* placeholder;
    UIColor* placeholderColor;
}

@property (nonatomic, assign) id<UITextViewDelegate> mudelegate;
@property (nonatomic, copy) NSString* observedText;
@property (nonatomic, retain) MUFilter *filter;

@property (nonatomic, retain) NSString* placeholder;
@property (nonatomic, retain) UIColor* placeholderColor;

@end
