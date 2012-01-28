//
//  MUCellLb1Tf1.h
//  TimeLink
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUTextFieldPadding.h"
#import "MUTableViewCell2Half.h"
#import "MUTextField.h"

//==============================================================================

@interface MUCellLb1Tf1Data : MUTableViewCell2HalfData
{
    NSString *leftText1;
    NSString *textFieldText1;
    NSString *placeholderTextFieldText1;
    
    UIFont *leftTextFont1;
    UIFont *textFieldFont1;
    
    NSInteger rightTextFieldTag;
}

@property (nonatomic, retain) NSString *leftText1;
@property (nonatomic, retain) NSString *textFieldText1;
@property (nonatomic, retain) NSString *placeholderTextFieldText1;
@property (nonatomic, readonly) UIFont *leftTextFont1;
@property (nonatomic, readonly) UIFont *textFieldFont1;

@property (nonatomic, assign) NSInteger rightTextFieldTag;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@interface MUCellLb1Tf1 : MUTableViewCell2Half 
{
    UILabel* leftLabel1;
    MUTextField* textField1;
}

@property (nonatomic, readonly) MUTextField* textField1;

@end

//==============================================================================