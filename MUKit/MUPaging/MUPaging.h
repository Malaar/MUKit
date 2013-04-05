//
//  CTPaging.h
//  Apps4All
//
//  Created by Malaar on 19.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUPagingConfig.h"
#import "MUCompoundCell.h"
#import "MUGateway.h"
#import "MUFetchable.h"
#import "Reachability.h"
#import "MUTableDisposerModeled.h"

@protocol MUPagingDelegate;
@protocol MUPagingMoreCellProtocol;
@protocol MUPagingMoreCellDataProtocol;

@interface MUPaging : NSObject <MUFetchable>
{
    Reachability* reachability;
    MUCell<MUPagingMoreCellProtocol>* moreCell;
}

@property (nonatomic, readonly) MUPagingConfig* pagingConfig;
@property (nonatomic, readonly) UIViewController* controller;
@property (nonatomic, readonly) MUTableDisposerModeled* tableDisposer;

@property (nonatomic, weak) id<MUPagingDelegate> delegate;

@property (nonatomic, assign) BOOL reloading;
@property (nonatomic, assign) BOOL loadingMore;
@property (nonatomic, strong) NSDate* lastUpdate;

@property (nonatomic, readonly) MUGatewayTask* gatewayTask;
@property (nonatomic, readonly) NSUInteger pageOffset;
@property (nonatomic, readonly) NSMutableArray* models;
@property (nonatomic, readonly) NSMutableArray* compoundModels;

#pragma mark - Init/Dealloc
- (id)initWithConfig:(MUPagingConfig*)aPagingConfig
          controller:(UIViewController*)aController
       tableDisposer:(MUTableDisposerModeled*)aTableDisposer;

#pragma mark - Load/Reload data
- (void)reloadData;
- (void)loadMoreData;
- (MUGatewayTask*)fetchDataWithCallback:(MUGatewayCallback)aCallback;
- (NSArray*)didFetchData:(NSArray*)aData;
- (void)setupModels:(NSArray*)aModels;

#pragma mark - For MuTableDisposer
- (void)tableDisposer:(MUTableDisposerModeled*)aTableDisposer didCreateCellData:(MUCellData*)aCellData;
- (void)tableDisposer:(MUTableDisposerModeled*)aTableDisposer didCreateCell:(MUCell*)aCell;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Notifications
- (void)reachabilityChangedNotification:(NSNotification*)aNotification;

@end


@protocol MUPagingDelegate <NSObject>

- (MUGatewayTask*)paging:(MUPaging*)aPaging fetchDataWithCallback:(MUGatewayCallback)aCallback;
- (MUCellData<MUPagingMoreCellDataProtocol>*)moreCellDataForPaging:(MUPaging*)aPaging;

@optional

- (BOOL)shouldFetchForPaging:(MUPaging*)aPaging;
- (void)willBeginFetchingForPaging:(MUPaging*)aPaging;
- (void)didCompleteFetchingForPaging:(MUPaging*)aPaging;

- (NSArray*)paging:(MUPaging*)aPaging didFetchedDataWithSuccess:(NSArray*)aData;
- (void)paging:(MUPaging*)aPaging didFetchedDataWithFailure:(MUGatewayResponse*)aResponse;

@end

@protocol MUPagingMoreCellProtocol <NSObject>

- (void)didBeginDataLoading;
- (void)didEndDataLoading;

@end

@protocol MUPagingMoreCellDataProtocol <NSObject>

- (void)addTarget:(id)aTarget action:(SEL)anAction;

@end