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

- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    MUCellDataStandart *labelCellData = (MUCellDataStandart*)self.cellData;
    
    self.textLabel.text = labelCellData.title;
    self.textLabel.font = labelCellData.titleFont;
    self.textLabel.textColor = labelCellData.titleColor;
    self.textLabel.textAlignment = labelCellData.titleTextAlignment;
    
    self.detailTextLabel.textColor = labelCellData.subtitleColor;
    self.detailTextLabel.font = labelCellData.subtitleFont;
    self.detailTextLabel.text = labelCellData.subtitle;
}

@end
