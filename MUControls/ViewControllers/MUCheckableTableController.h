//
//  MUFilterTableController.h
//  TimeLink
//
//  Created by Malaar on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUBaseTableController.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUCheckableData : NSObject
{
    NSString* titleKey;
}

@property (nonatomic, retain) NSArray* dataSource;
@property (nonatomic, assign) NSInteger selectedIndex;

+ (id) checkableDataWithDataSource:(NSArray*)aDataSource selectedIndex:(NSInteger)aSelectedIndex titleKey:(NSString*)aTitleKey;
- (id) initWithDataSource:(NSArray*)aDataSource selectedIndex:(NSInteger)aSelectedIndex titleKey:(NSString*)aTitleKey;;

- (NSString*) titleAtIndex:(NSInteger)anIndex;
- (NSObject*) selectedObject;

@end

@class MUCheckableTableController;
//==============================================================================
//==============================================================================
//==============================================================================
@protocol MUCheckableTableControllerDelegate

- (void) checkableTableController:(MUCheckableTableController *)aCheckableTableController completeSelectionWithCheckableData:(MUCheckableData*)aCheckableData;
- (BOOL) shouldCancelCheckableTableController:(MUCheckableTableController *)aCheckableTableController;
- (void) canceledCheckableTableController:(MUCheckableTableController *)aCheckableTableController;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUCheckableTableController : MUBaseTableController
{
    UITableViewCell* prevSelectedCell;
    NSInteger selectedIndex;
    
    MUCheckableData* checkableData;
    NSObject<MUCheckableTableControllerDelegate>* delegate;
    
    BOOL multipleSelection;
}

@property (nonatomic, assign) NSObject<MUCheckableTableControllerDelegate>* delegate;
@property (nonatomic, assign) BOOL closeWhenSelected;

- (id) initWithCheckableData:(MUCheckableData*) aCheckableData title:(NSString*)aTitle;

@end
