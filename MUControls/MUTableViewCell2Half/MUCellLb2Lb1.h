//
//  MUCellLb2Lb1.h
//  MUKit
//
//  Created by Yuriy Bosov on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUCellLb1Lb1.h"

//==============================================================================
@interface MUCellLb2Lb1Data : MUCellLb1Lb1Data
{
    NSString *leftText2;
    UIFont *leftTextFont2;
}

@property (nonatomic, retain) NSString *leftText2;
@property (nonatomic, readonly) UIFont *leftTextFont2;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@interface MUCellLb2Lb1 : MUCellLb1Lb1 
{
    UILabel* leftLabel2;
}

@end
//==============================================================================