//
//  MUTextFieldGoup.h
//  ROM
//
//  Created by Malaar on 10.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MUValidationGroup : NSObject
{
	NSArray* textFields;

    UIImage* invalidIndicatorImage;
}

@property (nonatomic, retain) UIImage* invalidIndicatorImage;

- (id) initWithTextFields:(NSArray*)aTextFields;
- (NSArray*) validateFields;
- (void) hideInvalidIndicators;

@end
