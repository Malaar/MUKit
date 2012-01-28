//
//  MUCellLbTextView.h
//  TimeLink
//
//  Created by Malaar on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUTableViewCell2Half.h"
#import "MUTextViewAutosize.h"

@interface MUCellLbTextViewData : MUTableViewCell2HalfData
{
    NSString *leftText1;
    NSString* textViewText;
    
    UIFont *leftTextFont1;
    UIFont* textViewTextFont;
    
}

@property (nonatomic, retain) NSString *leftText1;
@property (nonatomic, retain) NSString *textViewText;

@property (nonatomic, readonly) UIFont *leftTextFont1;
@property (nonatomic, readonly) UIFont *textViewTextFont;

@end

@interface MUCellLbTextView : MUTableViewCell2Half
{
    UILabel* leftLabel1;
    MUTextViewAutosize* textView;
}

@property (nonatomic, readonly) MUTextViewAutosize* textView;

@end
