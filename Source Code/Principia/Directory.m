//
//  Directory.m
//  Principia
//
//  Created by Shirley Paulson on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Directory.h"

@implementation Directory

@synthesize dirSearchBar;
@synthesize searchText;
@synthesize tabData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"People", @"People");
        self.tabBarItem.image = [UIImage imageNamed:@"People"];
    }
    return self;
}

//------------------------------------------------------------------------------------

- (void) execSearch {
    
    if (tabData == nil)
        tabData = [NSMutableArray new];
    else
        [tabData removeAllObjects];

    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Failed to open database");
	}
    
    NSString *select = @"SELECT FirstName,LastName,Address,phone,email from Directory where (FirstName='Dale' or lastname='Dale') and type in (1,2);";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2( database, [select UTF8String],-1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [self.searchText UTF8String], -1, NULL);		
        sqlite3_bind_text(statement, 2, [self.searchText UTF8String], -1, NULL);		
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //cust_id=sqlite3_column_int(statement,0);
            char *namec = (char *)sqlite3_column_text(statement, 0);
            if (namec==nil) namec="";
            NSString *name = [NSString stringWithUTF8String:namec];
            
            char *namelc = (char *)sqlite3_column_text(statement, 1);
            if (namelc==nil) namelc="";
            NSString *namel = [NSString stringWithUTF8String:namelc];
            
            char *addrc = (char *)sqlite3_column_text(statement, 2);
            if (addrc==nil) addrc="";
            NSString *addr = [NSString stringWithUTF8String:addrc];
            
            char *phonec = (char *)sqlite3_column_text(statement, 3);
            if (phonec==nil) phonec="";
            NSString *phone = [NSString stringWithUTF8String:phonec];
            
            char *emailc = (char *)sqlite3_column_text(statement, 4);
            if (emailc==nil) emailc="";
            NSString *email = [NSString stringWithUTF8String:emailc];

            NSDictionary *row1=[[NSDictionary alloc] initWithObjectsAndKeys: name,@"fname",namel,@"lname",addr,@"addr",phone,@"phone",email,@"email",nil];

            [tabData addObject:row1];
            //[row1 release];
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    NSLog (@"Database Loaded");
    
    [self.tableView reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=nil;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchText = dirSearchBar.text;
    if (![[self.searchText stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [searchBar resignFirstResponder];
        //[self.appDelegate showActivityViewer];
        [self performSelector:@selector(execSearch) withObject:NULL afterDelay:0.0];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (tabData == nil)
        tabData = [NSMutableArray new];
    else
        [tabData removeAllObjects];

    [dirSearchBar becomeFirstResponder];
    [self.tableView reloadData];
}

//------------------------------------------------------------------------------------

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//------------------------------------------------------------------------------------


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

//------------------------------------------------------------------------------------
// numberOfRowsInSection
//
// returns the number of rows in the table

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [tabData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

//------------------------------------------------------------------------------------
// cellForRowAtIndexPath
//
// provides and creates cells for the tableview

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    // Set the text of the cell to the row index.
    NSDictionary *rowdata = [tabData objectAtIndex:row];
    NSString *addr=[rowdata objectForKey:@"addr"];
    NSString *fname=[rowdata objectForKey:@"fname"];
    NSString *lname=[rowdata objectForKey:@"lname"];
    NSString *phone=[rowdata objectForKey:@"phone"];
    NSString *email=[rowdata objectForKey:@"email"];

    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"DirectCell"];
    if (!cell) 
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DirectCell" owner:self options:nil] lastObject];
    [(UILabel *)[cell viewWithTag:100] setText:[NSString stringWithFormat:@"%@ %@",fname,lname]];
    [(UILabel *)[cell viewWithTag:101] setText:addr];
    [(UILabel *)[cell viewWithTag:102] setText:email];
    [(UILabel *)[cell viewWithTag:103] setText:phone];
    return cell;
}

//------------------------------------------------------------------------------------
// didSelectRowAtIndexPath
//
// executes when user taps a cell

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Show an alert with the index selected.
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Item Selected"                         
                          message:[NSString stringWithFormat:@"Item %d", indexPath.row]                     
                          delegate:self       
                          cancelButtonTitle:@"OK"           
                          otherButtonTitles:nil];
    [alert show];
    //[alert release];
}

//------------------------------------------------------------------------------------
// numberOfSectionsInTableView
//
// specifies how many sections there are in the table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


//------------------------------------------------------------------------------------

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSLog(@"Data File Path: %@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
    
}

@end
