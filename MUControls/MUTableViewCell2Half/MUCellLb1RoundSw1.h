//
//  MUCellLb1RoundSw1.h
//  MUKit
//
//  Created by Malaar on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUTableViewCell2Half.h"
#import "DCRoundSwitch.h"

//==============================================================================
@interface MUCellLb1RoundSw1Data : MUTableViewCell2HalfData
{
    NSString* leftText1;
    UIFont* leftTextFont1;
    BOOL switchValue1;

    NSString* switchOnText;
    NSString* switchOffText;
    UIColor* switchOnTintColor;
}

@property (nonatomic, retain) NSString *leftText1;
@property (nonatomic, readonly) UIFont *leftTextFont1;
@property (nonatomic, assign) BOOL switchValue1;

@property (nonatomic, retain) NSString* switchOnText;
@property (nonatomic, retain) NSString* switchOffText;
@property (nonatomic, retain) UIColor* switchOnTintColor;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@interface MUCellLb1RoundSw1 : MUTableViewCell2Half
{
    UILabel* leftLabel1;
    DCRoundSwitch* rightSwitch1;
}

@property (nonatomic, readonly) DCRoundSwitch* rightSwitch1;

@end

//==============================================================================