//
//  MUImageViewTapable.h
//  MUKitMaster
//
//  Created by Malaar on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"
#import "MUTargetAction.h"


@interface MUImageViewTapable : UIImageView
{
    NSMutableArray* targetActions;
    NSObject* data;
}

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, retain) NSObject* data;

- (void) addTarget:(id)aTarget action:(SEL)anAction;

@end
