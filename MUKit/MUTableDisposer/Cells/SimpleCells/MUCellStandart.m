//
//  MULabelCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellStandart.h"
#import "MUCellDataStandart.h"

@implementation MUCellStandart

//==============================================================================
- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    MUCellDataStandart *cellDataStandart = (MUCellDataStandart*)self.cellData;
    
    self.textLabel.text = cellDataStandart.title;
    self.textLabel.font = cellDataStandart.titleFont;
    self.textLabel.textColor = cellDataStandart.titleColor;
    self.textLabel.textAlignment = cellDataStandart.titleTextAlignment;
    
    self.detailTextLabel.textColor = cellDataStandart.subtitleColor;
    self.detailTextLabel.font = cellDataStandart.subtitleFont;
    self.detailTextLabel.text = cellDataStandart.subtitle;
    
    [self.imageView setImage:cellDataStandart.image];
}

@end
