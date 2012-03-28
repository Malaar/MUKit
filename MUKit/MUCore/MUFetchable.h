//
//  MUFetchable.h
//  TimeLink
//
//  Created by Malaar on 10/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==============================================================================
@protocol MUFetchable <NSObject>

@property (nonatomic, assign) BOOL needFetch;      // need fetch data from server

- (void) fetchData;

@end
