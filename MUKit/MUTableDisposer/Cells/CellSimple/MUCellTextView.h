//
//  MUCellTextView.h
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCell.h"
#import "MUTextView.h"


@interface MUCellTextView : MUCell
{
    UILabel* titleLabel;
}

@property (nonatomic, readonly ) MUTextView *textView;

@end
