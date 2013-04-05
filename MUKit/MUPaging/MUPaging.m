//
//  CTPaging.m
//  Apps4All
//
//  Created by Malaar on 19.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "MUPaging.h"
#import "MUBOCompoundModel.h"

@interface MUPaging ()

@property (nonatomic) MUGatewayTask* gatewayTask;
@property (nonatomic, strong) MUCell<MUPagingMoreCellProtocol>* moreCell;

- (void)loadMoreDataPressed:(id*)aSender;

@end

@implementation MUPaging

@synthesize needFetch;
@synthesize pagingConfig;
@synthesize controller;
@synthesize tableDisposer;
@synthesize delegate;

@synthesize moreCell;
@synthesize reloading;
@synthesize loadingMore;
@synthesize lastUpdate;

@synthesize pageOffset;
@synthesize gatewayTask;
@synthesize models;
@synthesize compoundModels;

#pragma mark - Init/Dealloc

- (id)initWithConfig:(MUPagingConfig*)aPagingConfig
          controller:(UIViewController*)aController
       tableDisposer:(MUTableDisposerModeled*)aTableDisposer
{
    self = [super init];
    if(self)
    {
        pagingConfig = aPagingConfig;
        controller = aController;
        tableDisposer = aTableDisposer;
        
        // defaults
        needFetch = YES;
        gatewayTask = nil;
        pageOffset = 0;
        reloading = YES;
        loadingMore = NO;
        lastUpdate = nil;

        //
        models = [NSMutableArray new];
        compoundModels = [NSMutableArray new];
        
        //
        reachability = [Reachability reachabilityForInternetConnection];
        [reachability startNotifier];
    
        //
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChangedNotification:)
                                                     name:kReachabilityChangedNotification object:nil];

        if(pagingConfig.useCompoundCells)
        {
            [tableDisposer registerCellData:[MUCompoundCellData class] forModel:[MUBOCompoundModel class]];
        }
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Load/Reload data

- (void)reloadData
{
    [gatewayTask cancel];
    gatewayTask = nil;
    pageOffset = 0;
    [models removeAllObjects];
    [compoundModels removeAllObjects];
    reloading = YES;
    self.needFetch = YES;
    [self fetchData];
}

- (void)loadMoreData
{
    pageOffset += pagingConfig.pageSize;
    loadingMore = YES;
    self.needFetch = YES;
    [self fetchData];
}

- (MUGatewayTask*)fetchDataWithCallback:(MUGatewayCallback)aCallback
{
    return [delegate paging:self fetchDataWithCallback:aCallback];
}

- (NSArray*)didFetchData:(NSArray*)aData
{
    return aData;   // override if you need
}

- (void)setupModels:(NSArray*)aModels
{
    [tableDisposer removeAllSections];
    MUSectionReadonly* section = [MUSectionReadonly section];
    [tableDisposer addSection:section];
    
    [models addObjectsFromArray:aModels];
    tableDisposer.tableView.hidden = models.count == 0;
    
    if(pagingConfig.useCompoundCells)
    {
        NSArray* compoundModelsNew = [MUBOCompoundModel compoundModelsFromModels:aModels
                                                                    groupByCount:pagingConfig.compoundCellsGroupByCount];
        [compoundModels addObjectsFromArray:compoundModelsNew];
        [tableDisposer setupModels:compoundModels forSection:section];
    }
    else
    {
        [tableDisposer setupModels:models forSection:section];
    }
    
    if(aModels.count == pagingConfig.pageSize)
    {
        MUCellData<MUPagingMoreCellDataProtocol>* moreCellData = [delegate moreCellDataForPaging:self];
        [moreCellData addTarget:self action:@selector(loadMoreDataPressed:)];
        [section addCellData:moreCellData];
    }
    else
    {
        moreCell = nil;
    }
    [tableDisposer reloadData];
}

#pragma mark - MUFetchable
- (void)fetchData
{
    if(!self.needFetch)
        return;
    
    if([delegate respondsToSelector:@selector(shouldFetchForPaging:)])
    {
        if(![delegate shouldFetchForPaging:self])
            return;
    }
    
    self.needFetch = NO;
    
    if(loadingMore)
        [moreCell didBeginDataLoading];
    
    if([delegate respondsToSelector:@selector(willBeginFetchingForPaging:)])
        [delegate willBeginFetchingForPaging:self];

    [gatewayTask cancel];
    __weak MUPaging* __self = self;
    gatewayTask = [self fetchDataWithCallback:^(MUGatewayResponse *aResponse, BOOL aSuccess)
   {
       __self.gatewayTask = nil;
       __self.needFetch = aResponse.boArray.count == 0;
       
       if(__self.reloading)
       {
           if(aSuccess)
               __self.lastUpdate = [NSDate date];
       }

       if([delegate respondsToSelector:@selector(didCompleteFetchingForPaging:)])
           [__self.delegate didCompleteFetchingForPaging:__self];
       
       if(aSuccess)
       {
           NSArray* fetchedModels = [self didFetchData:aResponse.boArray];
           
           if([__self.delegate respondsToSelector:@selector(paging:didFetchedDataWithSuccess:)])
               fetchedModels = [__self.delegate paging:self didFetchedDataWithSuccess:fetchedModels];

           [__self setupModels:fetchedModels];
       }
       else
       {
           [__self.moreCell didEndDataLoading];

           if([__self.delegate respondsToSelector:@selector(paging:didFetchedDataWithFailure:)])
               [__self.delegate paging:__self didFetchedDataWithFailure:aResponse];
       }
       
       __self.reloading = NO;
       __self.loadingMore = NO;

   }];
}

#pragma mark - For MuTableDisposer

- (void)tableDisposer:(MUTableDisposerModeled*)aTableDisposer didCreateCellData:(MUCellData*)aCellData
{
    if(aTableDisposer != tableDisposer)
        return;
    
    if(pagingConfig.useCompoundCells)
    {
        if([aCellData isKindOfClass:[MUCompoundCellData class]])
        {
            [(MUCompoundCellData*)aCellData setTableDisposer:tableDisposer];
        }
    }
}

- (void)tableDisposer:(MUTableDisposerModeled*)aTableDisposer didCreateCell:(MUCell*)aCell
{
    if(aTableDisposer != tableDisposer)
        return;
    
    if([aCell.cellData conformsToProtocol:@protocol(MUPagingMoreCellDataProtocol)])
    {
        moreCell = (MUCell<MUPagingMoreCellProtocol>*)aCell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(tableDisposer.tableView != tableView)
        return;
    
    if(pagingConfig.loadMoreDataType == MULoadMoreDataTypeAuto)
    {
        if(cell == moreCell)
        {
            [self loadMoreData];
        }
    }
}

#pragma mark - Actions

- (void)loadMoreDataPressed:(id*)aSender
{
    [self loadMoreData];
}

#pragma mark - Notifications
- (void)reachabilityChangedNotification:(NSNotification*)aNotification
{
    if([reachability isReachable])
        [self reloadData];
}

@end
