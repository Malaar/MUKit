//
//  MUCellLb1Lb1.h
//  MUKit
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUTableViewCell2Half.h"

//==============================================================================
@interface MUCellLb1Lb1Data : MUTableViewCell2HalfData
{
    NSString *leftText1;
    NSString *rightText1;
    
    UIFont *leftTextFont1;
    UIFont *rightTextFont1;
}

@property (nonatomic, retain) NSString *leftText1;
@property (nonatomic, retain) NSString *rightText1;
@property (nonatomic, readonly) UIFont *leftTextFont1;
@property (nonatomic, readonly) UIFont *rightTextFont1;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@interface MUCellLb1Lb1 : MUTableViewCell2Half 
{
    UILabel* leftLabel1;
    UILabel* rightLabel1;
}

@end
//==============================================================================