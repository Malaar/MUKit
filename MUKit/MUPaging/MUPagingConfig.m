//
//  CTPagingConfig.m
//  Apps4All
//
//  Created by Malaar on 19.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "MUPagingConfig.h"

@implementation MUPagingConfig

- (id)init
{
    self = [super init];
    if(self)
    {
        _pageSize = 20;
//        _enablePullToRefresh = YES;
//        _enablePaging = YES;
        _loadMoreDataType = MULoadMoreDataTypeAuto;
        _useCompoundCells = NO;
        _compoundCellsGroupByCount = 2;
    }
    return self;
}

@end
