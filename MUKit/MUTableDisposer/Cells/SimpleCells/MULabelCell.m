//
//  MULabelCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULabelCell.h"
#import "MULabelCellData.h"

@implementation MULabelCell

- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    MULabelCellData *labelCellData = (MULabelCellData *)self.cellData;
    
    self.textLabel.text = labelCellData.title;
    self.textLabel.font = labelCellData.titleFont;
    self.textLabel.textColor = labelCellData.titleColor;
    self.textLabel.textAlignment = labelCellData.titleTextAlignment;
    
    self.detailTextLabel.textColor = labelCellData.valueColor;
    self.detailTextLabel.font = labelCellData.valueFont;
    if (labelCellData.value)
    {
        self.detailTextLabel.text = [labelCellData.value description];
    }
}

@end
