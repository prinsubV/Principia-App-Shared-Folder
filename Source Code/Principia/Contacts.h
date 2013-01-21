//
//  Contacts.h
//  Principia
//
//  Created by Dale Matheny on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFileName @"PrinDB.sqlite"

@interface Contacts : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    sqlite3 *database;
    NSMutableArray *tabData;       // temp names
}

@property (strong, nonatomic) NSMutableArray *tabData;
- (NSString *)dataFilePath;

@end
