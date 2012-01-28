//
//  MUTextView.h
//  VoterBuzz-iphone
//
//  Created by Yuriy Bosov on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUValidator.h"


@interface MUTextView : UITextView <MUValidationProtocol>
{
    MUValidator* validator;
}

@end
