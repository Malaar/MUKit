//
//  MUBOTitledID.h
//  MUKit
//
//  Created by Malaar on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUTitledID : NSObject <NSCopying>
{
    id ID;
    NSString* title;
}

@property (nonatomic, retain) id ID;
@property (nonatomic, retain) NSString* title;

+ (id) titledIDWithID:(id)aID title:(NSString*)aTitle;
- (id) initWithID:(id)aID title:(NSString*)aTitle;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface NSArray (MUTitledID)

- (MUTitledID*) titledIDByID:(id) aID;
- (MUTitledID*) titledIDByTitle:(NSString*) aTitle;

@end