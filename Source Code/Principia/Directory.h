//
//  Directory.h
//  Principia
//
//  Created by Shirley Paulson on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFileName @"PrinDB.sqlite"

@interface Directory : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    sqlite3 *database;
    NSMutableArray *tabData;       // temp names
    NSString *searchText;
    IBOutlet UISearchBar *dirSearchBar;
}

@property (strong, nonatomic) NSMutableArray *tabData;
@property (strong, nonatomic) IBOutlet UISearchBar *dirSearchBar;
@property (nonatomic, retain) NSString *searchText;
- (NSString *)dataFilePath;

@end
