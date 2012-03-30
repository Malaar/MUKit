//
//  MUEntryCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUEntryCellData.h"

@implementation MUEntryCellData

@synthesize placeholder;
@synthesize textValue;

@synthesize autocapitalizationType;
@synthesize autocorrectionType;
@synthesize keyboardType;
@synthesize keyboardAppearance;
@synthesize returnKeyType;
@synthesize secureTextEntry;

//- (MUEntryCellData *)initWithTitle:(NSString *)string Value:(NSString *)param Placeholder:(NSString *)string
//{
//    
//}

- (void) dealloc
{
    [placeholder release];
    [textValue release];
    
    [super dealloc];
}

@end
