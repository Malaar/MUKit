//
//  MUCell.h
//  MUKit
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUCellProtocol.h"

@interface MUCell : UITableViewCell <MUCellProtocol>

- (NSArray*) inputTraits;

@end
