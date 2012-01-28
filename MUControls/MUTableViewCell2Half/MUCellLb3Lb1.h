//
//  MUCellLb3Lb1.h
//  TimeLink
//
//  Created by Yuriy Bosov on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUCellLb2Lb1.h"


//==============================================================================
@interface MUCellLb3Lb1Data : MUCellLb2Lb1Data
{
    NSString *leftText3;
    UIFont *leftTextFont3;
}

@property (nonatomic, retain) NSString *leftText3;
@property (nonatomic, readonly) UIFont *leftTextFont3;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@interface MUCellLb3Lb1 : MUCellLb2Lb1 
{
    UILabel* leftLabel3;
}

@end
//==============================================================================
