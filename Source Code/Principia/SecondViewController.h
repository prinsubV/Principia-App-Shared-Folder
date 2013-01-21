//
//  SecondViewController.h
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFilename @"PrinDB.sqlite"

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
    IBOutlet UIImageView *Image;
    IBOutlet UIScrollView *Scroller;
    sqlite3    *database;
    NSMutableArray *eventlist;
}

@property(strong,retain) IBOutlet UIImageView *Image;
@property(strong,retain) IBOutlet UIScrollView *Scroller;
@property(strong,retain) NSMutableArray *eventlist;

-(NSString *) dataFilePath;
-(NSDate *)dateParser:(NSString *) rawstr;

@end
