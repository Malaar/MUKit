//
//  MUTextField.h
//  TimeLink
//
//  Created by Malaar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUValidator.h"

@interface MUTextField : UITextField <MUValidationProtocol>
{
    MUValidator* validator;
}

@end
