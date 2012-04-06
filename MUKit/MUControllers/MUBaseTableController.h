//
//  MUTLBaseTableController.h
//  MUKit
//
//  Created by Malaar on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUBaseViewController.h"


@interface MUBaseTableController : MUBaseViewController <UITableViewDelegate, UITableViewDataSource>
{
@protected
    NSMutableArray* dataSource;
    IBOutlet UITableView* tableView;
}

- (Class) tableViewClass;
- (BOOL) isDataSourceAvailable;
- (UITableViewStyle) getTableViewStyle;

@end
