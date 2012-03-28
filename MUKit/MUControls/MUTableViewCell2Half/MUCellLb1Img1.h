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
@interface MUCellLb1Img1Data : MUTableViewCell2HalfData
{
    NSString *leftText1;
	UIImage* rightImage1;
    
    UIFont *leftTextFont1;
}

@property (nonatomic, retain) NSString* leftText1;
@property (nonatomic, retain) UIImage* rightImage1;
@property (nonatomic, readonly) UIFont* leftTextFont1;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@interface MUCellLb1Img1 : MUTableViewCell2Half 
{
    UILabel* leftLabel1;
    UIImageView* rightImageView1;
}

@end
//==============================================================================