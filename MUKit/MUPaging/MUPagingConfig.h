//
//  CTPagingConfig.h
//  Apps4All
//
//  Created by Malaar on 19.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _MULoadMoreDataType
{
    MULoadMoreDataTypeAuto,
    MULoadMoreDataTypeManual
    
} MULoadMoreDataType;

@interface MUPagingConfig : NSObject

@property (nonatomic, assign) NSUInteger pageSize;
//@property (nonatomic, assign) BOOL enablePullToRefresh;
//@property (nonatomic, assign) BOOL enablePaging;
@property (nonatomic, assign) MULoadMoreDataType loadMoreDataType;
@property (nonatomic, assign) BOOL useCompoundCells;
@property (nonatomic, assign) NSUInteger compoundCellsGroupByCount;

@end
