//
//  MUButtonCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellButton.h"
#import "MUCellDataButton.h"

@implementation MUCellButton

- (void) setupCellData:(MUCellDataButton *)aCellData
{
    [super setupCellData:aCellData];
    
    self.textLabel.text = aCellData.title;
    self.textLabel.textAlignment = aCellData.titleAlignment;
    self.textLabel.textColor = aCellData.titleColor;
    self.textLabel.font = aCellData.titleFont;
}

@end
