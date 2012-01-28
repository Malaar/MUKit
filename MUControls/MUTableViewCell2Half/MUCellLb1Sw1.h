//
//  MUCellLd1Sw1.h
//  TimeLink
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUTableViewCell2Half.h"

//==============================================================================
@interface MUCellLb1Sw1Data : MUTableViewCell2HalfData
{
    NSString *leftText1;
    BOOL switchValue1;
    UIFont *leftTextFont1;
}

@property (nonatomic, retain) NSString *leftText1;
@property (nonatomic, assign) BOOL switchValue1;
@property (nonatomic, readonly) UIFont *leftTextFont1;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@interface MUCellLb1Sw1 : MUTableViewCell2Half
{
    UILabel* leftLabel1;
    UISwitch* rightSwitch1;
}

@property (nonatomic, readonly) UISwitch* rightSwitch1;

@end

//==============================================================================