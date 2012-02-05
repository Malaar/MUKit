//
//  MUTextFieldGoup.h
//  MUKit
//
//  Created by Malaar on 10.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MUValidationGroupDelegate <NSObject>

- (void) proccessValidationResults:(NSMutableArray*)aValidationResults;

@end


@interface MUValidationGroup : NSObject
{
	NSArray* textFields;
    UIImage* invalidIndicatorImage;
}

@property (nonatomic, retain) UIImage* invalidIndicatorImage;
@property (nonatomic, assign) NSObject<MUValidationGroupDelegate>* delegate;

- (id) initWithTextFields:(NSArray*)aTextFields;
- (NSArray*) validateFields;
- (void) hideInvalidIndicators;

@end
